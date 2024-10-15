# frozen_string_literal: true

class PostsController < ProtectedController
  def index
    @user = User.find_by(id: params[:user_id]) || current_user
    @pagy, posts = pagy(@user.posts, items: Constants::Shared::ITEMS_PER_PAGE)
    @posts = posts.decorate
  end

  def show
    @post = Post.find_by(id: params[:id]).decorate
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
