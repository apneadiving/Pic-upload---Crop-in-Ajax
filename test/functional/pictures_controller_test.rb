require 'test_helper'

class PicturesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Picture.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Picture.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Picture.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to picture_url(assigns(:picture))
  end

  def test_edit
    get :edit, :id => Picture.first
    assert_template 'edit'
  end

  def test_update_invalid
    Picture.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Picture.first
    assert_template 'edit'
  end

  def test_update_valid
    Picture.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Picture.first
    assert_redirected_to picture_url(assigns(:picture))
  end

  def test_destroy
    picture = Picture.first
    delete :destroy, :id => picture
    assert_redirected_to pictures_url
    assert !Picture.exists?(picture.id)
  end
end
