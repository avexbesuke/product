class EmotionsController < ApplicationController
  def new
    redirect_to root_path if params[:title].nil?
    @emotion = Emotion.new
  end

  def create
    @book = Book.new(book_params)
    @book.save if Book.where(title: @book.title).empty?
    book_id = Book.find_by(title: book_params[:title]).id
    @emotion = Emotion.new(emotion_params)
    @emotion.book_id = book_id
    if @emotion.save
      redirect_to user_path(@emotion.user.id)
    else
      render :new
    end
  end

  def edit
    @emotion = Emotion.find(params[:id])
  end

  def update
    @emotion = Emotion.find(params[:id])
    if @emotion.update(emotion_params)
      redirect_to user_path(@emotion.user.id)
    else
      render :edit
    end
  end

  def destroy
    @emotion = Emotion.find(params[:id])
    if @emotion.delete
      redirect_to user_path(@emotion.user.id)
    else
      redirect_to user_path(@emotion.user.id)
    end
  end

  def index
    @search_emotions = Emotion.order("created_at DESC").ransack(params[:q])
    @emotions = @search_emotions.result(distinct: true).page(params[:page]).per(10)
    @tags = Emotion.all_tags

    if params[:tag_name]
      @emotions = Emotion.all.page(params[:page])
      @emotions = @emotions.tagged_with(params[:tag_name].to_s).per(10)
    end
  end

  private

  def emotion_params
    params.require(:emotion).permit(:body, :tag_list).merge(user_id: current_user.id)
  end

  def book_params
    params.require(:emotion).permit(:title, :author, :image_url, :synopsis)
  end
end
