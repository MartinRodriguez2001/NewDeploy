class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :require_user

  def index
    @comments = @post.comments.includes(:user)
  end

  def show
  end

  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'Comentario agregado.'
    else
      redirect_to post_path(@post), alert: 'No se pudo agregar el comentario.'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post), notice: 'Comentario actualizado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comentario eliminado correctamente.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
