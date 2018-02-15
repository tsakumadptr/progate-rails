class PostsController < ApplicationController
  before_action :authenticate_user

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
  end

  def create
    @post = Post.new(
      content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "投稿を保存しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      @post.content = params[:content]
      render("posts/edit")
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] ="投稿を削除しました"
    redirect_to("/posts/index")
  end

end
