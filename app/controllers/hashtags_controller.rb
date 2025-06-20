class HashtagsController < ApplicationController
  before_action :set_hashtag, only: %i[show edit update destroy]

  def index
    @hashtags = Hashtag.all
  end


  def show
  end

  def new
    @hashtag = Hashtag.new
  end

  def create
    @hashtag = Hashtag.new(hashtag_params)
    if @hashtag.save
      redirect_to @hashtag, notice: 'Hashtag creado correctamente.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @hashtag.update(hashtag_params)
      redirect_to @hashtag, notice: 'Hashtag actualizado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @hashtag.destroy
    redirect_to hashtags_url, notice: 'Hashtag eliminado correctamente.'
  end

  private

  def set_hashtag
    @hashtag = Hashtag.find(params[:id])
  end

  def hashtag_params
    params.require(:hashtag).permit(:tag)
  end
end
