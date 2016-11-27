class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :post_owner, only: [:edit, :update, :destroy]

  def post_owner
    unless @post.user == current_user
      flash[:notice] = 'Access denied as you are not owner of this Post'
      redirect_to posts_path
    end

  end

  def index
    @posts = Post.limit(10).order("created_at DESC")
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Successfully updated project'
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: 'Successfully removed project'
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :amount)
  end
end
