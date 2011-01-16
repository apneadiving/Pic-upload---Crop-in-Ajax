require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Profile.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Profile.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Profile.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to profile_url(assigns(:profile))
  end

  def test_edit
    get :edit, :id => Profile.first
    assert_template 'edit'
  end

  def test_update_invalid
    Profile.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Profile.first
    assert_template 'edit'
  end

  def test_update_valid
    Profile.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Profile.first
    assert_redirected_to profile_url(assigns(:profile))
  end

  def test_destroy
    profile = Profile.first
    delete :destroy, :id => profile
    assert_redirected_to profiles_url
    assert !Profile.exists?(profile.id)
  end
end
