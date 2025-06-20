class LikesController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_or_initialize_by(user: current_user)
    if @like.persisted?
      redirect_to post_path(@post), alert: 'Ya diste like a este post.'
    else
      @like.save
      redirect_to post_path(@post), notice: '¡Te gustó este post!'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find_by(user: current_user)
    if @like
      @like.destroy
      redirect_to post_path(@post), notice: 'Ya no te gusta este post.'
    else
      redirect_to post_path(@post), alert: 'No habías dado like a este post.'
    end
  end
end
