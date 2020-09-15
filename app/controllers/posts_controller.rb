class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create]
  # before_action :correct_user, only: [:destroy]
  
  def index
       @posts = Post.order(id: :desc).page(params[:page]).per(5)
  end

  def new
     if logged_in?
       @post = current_user.posts.build
     end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿が完了しました。"
      redirect_to posts_url
    else
      flash.now[:danger] = "投稿に失敗しました。"
      render :new
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_back(fallback_location: root_path)
  end
  
  def search
    if params[:access].present?
      @posts = Post.where('access LIKE ?', "%#{params[:access]}%")
      if @posts.present?
        @posts = @posts.order(id: :desc).page(params[:page]).per(5)
      else
        flash.now[:danger] = "検索結果がありませんでした。"
        @posts = Post.none
        @posts = @posts.page(params[:page]).per(5)
      end
    else
      @posts = Post.all
      @posts = @posts.order(id: :desc).page(params[:page]).per(5)
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:store_name, :access, :content, :image)
  end
  
  # def correct_user
  #   @post = current_user.posts.find_by(id: params[:id])
  #   unless @post
  #     redirect_to root_url  
  #   end
  # end

  
end
