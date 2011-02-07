/**
 * AQUANTUM Demo Application 1.0
 *
 * Copyright 2010, Sebastian Tschan, AQUANTUM
 * http://www.aquantum.de
 */

/*jslint browser: true, regexp: false */
/*global $, window */

var Application = function (settings, locale) {
    var tmplHelper,

        TemplateHelper = function (locale, settings) {
            var roundDecimal = function (num, dec) {
                    return Math.round(num * Math.pow(10, dec)) / Math.pow(10, dec);
                };
            this.locale = locale;
            this.settings = settings;
            this.formatFileSize = function (bytes) {
                if (isNaN(bytes) || bytes === null) {
                    return '';
                }
                if (bytes >= 1000000000) {
                    return roundDecimal(bytes / 1000000000, 2) + ' GB';
                }
                if (bytes >= 1000000) {
                    return roundDecimal(bytes / 1000000, 2) + ' MB';
                }
                return roundDecimal(bytes / 1000, 2) + ' KB';
            };
            this.formatFileName = function (fileName) {
                // Remove any path information:
                return fileName.replace(/^.*[\/\\]/, '');
            };
        },

        getAuthenticityToken = function (singleValue) {
            var name = settings.authenticity_token.name,
                parts = $.cookie(name).split('|'),
                obj;
            if (singleValue) {
                obj = {};
                obj[name] = parts[0];
                return obj;
            }
            return {name: name, value: parts[0]};
        },

        addUrlParams = function (url, data) {
            return url + (/\?/.test(url) ? '&' : '?') + $.param(data);
        },

        getFileNode = function (key) {
            return $('#file_' + key);
        },

        deleteItem = function (node, url, callBack) {
            var dialog = $('#dialog_confirm_delete'),
                options,
                form;
            if (!dialog.length) {
                dialog = $('#template_confirm_delete').tmpl(locale).attr('id', 'dialog_confirm_delete');
                options = {
                    modal: true,
                    show: 'fade',
                    hide: 'fade',
                    width: 400,
                    buttons: {}
                };
                options.buttons[locale.buttons.destroy] = function () {
                    $(this).find('form:first').submit();
                };
                options.buttons[locale.buttons.cancel] = function () {
                    $(this).dialog('close');
                };
                dialog.dialog(options);
            }
            form = dialog.find('form').bind('submit', function () {
                dialog.dialog('close');
                $('#loading').fadeIn();
                $.ajax({
                    url: addUrlParams(url, getAuthenticityToken(true)),
                    type: 'DELETE',
                    success: function (data) {
                        $('#loading').fadeOut();
                        callBack(data);
                    }
                });
                return false;
            });
            node.addClass('ui-state-highlight');
            dialog.bind('dialogclose', function () {
                $(this).find('form').unbind('submit').unbind('dialogclose');
                node.removeClass('ui-state-highlight');
            }).dialog('open');
        },
        
        deleteFile = function (key) {
            var node = getFileNode(key);
            deleteItem(node, '/file-upload/files/' + key + '.json', function (data) {
                node.fadeOut(function () {
                    $(this).remove();
                });
            });
        },

        initFileUploadForm = function () {
            var node = $('.files');
            node.find('.upload').fileUploadUI({
                uploadTable: node.find('.upload_files'),
                downloadTable: node.find('.download_files'),
                buildUploadRow: function (files, index) {
									// console.log(files);
									// alert("files=" + files);
                    return $('#template_upload').tmpl(files[index], tmplHelper);
                },
                buildDownloadRow: function (data) {
										alert("data=" + data);
                    return $('#template_download').tmpl(data, tmplHelper);
                },
                beforeSend: function (event, files, index, xhr, handler, callBack) {
                    if (files[index].size > settings.max_file_size) {
                        setTimeout(function () {
                            handler.removeNode(handler.uploadRow);
                        }, 10000);
                        return;
                    }
										alert("upload=" + xhr.upload);
                    $.get('/file-upload/upload' + (xhr.upload ? '.json' : ''), function (data) {
                        handler.url = data.replace(/http(s)?:\/\/[^\/]+/, '');
                        callBack();
                    });
                }
            });
        },

        initEventHandlers = function () {
            var getKey = function (node) {
                return node.attr('id').replace(/\w+?_/, '');
            };
            $('.file_delete button').live('click', function () {
                deleteFile(getKey($(this).closest('tr')));
                return false;
            });
        };

    this.initialize = function () {
        tmplHelper = new TemplateHelper(locale, settings);
        initEventHandlers();
        initFileUploadForm();
        // $('#loading').fadeOut();
    };
};