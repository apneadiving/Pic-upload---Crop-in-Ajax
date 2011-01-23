class UsersController < ApplicationController
  def index
    @users = User.all
    render :json => ["a", "b", "c", "d"]
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @user.build_picture if @user.picture.nil?
  end

  def create
    params[:user]["picture"] = params[:picture]
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created user."
      redirect_to @user
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end
end
