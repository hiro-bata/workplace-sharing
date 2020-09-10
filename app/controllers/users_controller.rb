class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :user_admin, only: [:index]
  
  def index
  end
  
  def show
      @user = User.find(params[:id])
      @posts = @user.posts.order(id: :desc).page(params[:page])
      @favorites = current_user.favorite_posts.includes(:user)
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー登録が完了しました。"
      redirect_to login_url
    else
      flash.now[:danger] = "ユーザー登録に失敗しました。"
      render :new
    end
  end
  
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:success] = "ユーザーを削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_admin
    @users = User.all
      if  current_user.admin == false
          redirect_to root_path
      else
          render action: "index"
      end
  end


end