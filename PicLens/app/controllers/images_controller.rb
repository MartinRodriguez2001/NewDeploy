class ImagesController < ApplicationController
  before_action :set_post
  before_action :set_image, only: %i[show edit update destroy]

  def index
    @images = @post.images
  end

  def show
  end

  def new
    @image = @post.images.build
  end

  def create
    @image = @post.images.build(image_params)
    if @image.save
      redirect_to post_images_path(@post), notice: 'Imagen agregada correctamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @image.update(image_params)
      redirect_to post_image_path(@post, @image), notice: 'Imagen actualizada correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @image.destroy
    redirect_to post_images_path(@post), notice: 'Imagen eliminada correctamente.'
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_image
    @image = @post.images.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:image_url, :position)
  end
end
