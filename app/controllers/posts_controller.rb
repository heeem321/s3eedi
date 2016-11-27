class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :pledge, :post_pledge, :update, :destroy]
  before_action :authorize_post_owner, only: [:edit, :update, :destroy]
  before_action :ensure_posting_pledge_once_only, only: [:pledge, :post_pledge]

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

  def pledge
    @pledge = @post.pledges.build
  end

  def post_pledge
    @pledge = Pledge.new post_pledge_params
    @pledge.post = @post
    @pledge.user = current_user
    if @pledge.save
      redirect_to @post, notice: 'Thank you'
    else
      render :pledge
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :amount, :image)
  end

  def post_pledge_params
    params.require(:pledge).permit(:amount)
  end

  def ensure_posting_pledge_once_only
    if Pledge.where(user_id: current_user.id, post_id: @post.id).exists?
      redirect_to @post, alert: 'You already posted a pledge to the project'
    end
  end

  def authorize_post_owner
    unless @post.user == current_user
      flash[:notice] = 'Access denied as you are not owner of this Post'
      redirect_to posts_path
    end
  end
end
