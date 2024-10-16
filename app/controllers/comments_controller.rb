# frozen_string_literal: true

class CommentsController < ProtectedController
  before_action :set_post, only: %i[new create index]

  def index
    redirect_to post_path(@post)
  end

  def new
    @comment = @post.comments.new(parent_id: params[:parent_id])
  end

  def create
    @comment = @post.comments.new(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to post_path(@post), notice: t('comments.comment_added')
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end
end
