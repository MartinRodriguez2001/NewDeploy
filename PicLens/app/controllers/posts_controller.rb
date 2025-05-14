class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.includes(:user, :images, :likes, :comments, :hashtags)
                .order(created_at: :desc)
                .page(params[:page])
                .per(12)
  end

  def show
    @post = Post.includes(:user, :images, :likes, :comments, :hashtags, comments: :user)
                .find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      if params[:post][:image_url].present?
        url = params[:post][:image_url].strip
        url = "http://#{url}" unless url.start_with?('http://', 'https://')
        @post.images.create(image_url: url, position: 0)
      elsif params[:post][:file].present?
        image = @post.images.new(position: 0)
        image.file.attach(params[:post][:file])
        image.save
      end
      
      process_hashtags
      
      redirect_to @post, notice: 'Post creado exitosamente.'
    else
      render :new
    end
  end

  def edit
    @hashtag_list = @post.hashtags.pluck(:tag).join(',')
    Rails.logger.debug "Hashtags para edición: #{@hashtag_list}"
  end

  def update
    if @post.update(post_params)
      if params[:post][:image_url].present?
        url = params[:post][:image_url].strip
        url = "http://#{url}" unless url.start_with?('http://', 'https://')
        @post.images.destroy_all
        @post.images.create(image_url: url, position: 0)
      elsif params[:post][:file].present?
        @post.images.destroy_all
        image = @post.images.new(position: 0)
        image.file.attach(params[:post][:file])
        image.save
      end
      
      process_hashtags
      
      redirect_to @post, notice: 'Post actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: 'Post eliminado exitosamente.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:caption, :location, :hashtag_list)
  end
  
  def process_hashtags
    Rails.logger.debug "Procesando hashtags para post #{@post.id}"
    
    @post.hashtags.clear
    
    if params[:post][:hashtag_list].present?
      tags = params[:post][:hashtag_list].split(',').map(&:strip).reject(&:blank?)
      
      Rails.logger.debug "Hashtags a procesar: #{tags.inspect}"
      
      tags.each do |tag|
        hashtag = Hashtag.find_or_create_by_tag(tag)
        Rails.logger.debug "Agregando hashtag: #{tag} (#{hashtag.id})"
        @post.hashtags << hashtag
      end
    end
    
    Rails.logger.debug "Hashtags finales: #{@post.hashtags.pluck(:tag).join(', ')}"
  end
end
