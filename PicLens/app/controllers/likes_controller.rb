class LikesController < ApplicationController
  before_action :set_post
  before_action :set_like, only: [:destroy]

  def create
    @like = @post.likes.build(user_id: params[:user_id])
    if @like.save
      redirect_to @post, notice: 'Like agregado correctamente.'
    else
      redirect_to @post, alert: 'No se pudo agregar el like.'
    end
  end

  def destroy
    @like.destroy

    redirect_to @post, notice: 'Like eliminado correctamente.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_like
    @like = @post.likes.find(params[:id])
  end

  def like_params
    params.require(:like).permit(:user_id)
  end
end
