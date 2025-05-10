class PostHashtagsController < ApplicationController
  before_action :set_post
  before_action :set_post_hashtag, only: %i[destroy]

  def create
    @post_hashtag = @post.post_hashtags.build(hashtag_id: params[:hashtag_id])
    if @post_hashtag.save
      redirect_to @post, notice: 'Etiqueta asociada al post correctamente.'
    else
      redirect_to @post, alert: 'No se pudo asociar la etiqueta.'
    end
  end

  def destroy
    @post_hashtag.destroy
    redirect_to @post, notice: 'Etiqueta desasociada del post correctamente.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_post_hashtag
    @post_hashtag = @post.post_hashtags.find(params[:id])
  end
end
