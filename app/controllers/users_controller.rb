class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :admin_user, :only => [:show]
  def new
    @title = "Sign up"
    @user = User.new
  end

  def index
    @title = "Home page"
    @users = User.all
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully registered!"
      redirect_back_or_default users_path
    else
      render :action => :new
    end
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated!"
      redirect_to users_path
    else
      render :action => :edit
    end
  end
  
  private
  
  def admin_user
    @user = @current_user
    redirect_to users_path unless @user.admin?
  end

end
