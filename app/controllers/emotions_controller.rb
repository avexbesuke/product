class EmotionsController < ApplicationController
  def new
    redirect_to root_path if params[:bid].nil?
    @book = Book.find_by(bid: params[:bid])
    @emotion = Emotion.new
  end

  def create
    book_id = Book.find_by(bid: book_params[:bid]).id
    @emotion = Emotion.new(emotion_params)
    @emotion.book_id = book_id
    if @emotion.save
      redirect_to user_path(@emotion.user.id)
    else
      redirect_to emotion_write_path(book_params)
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
    @emotions = @search_emotions.result(distinct: true).page(params[:page]).per(Settings.number[:page_show_num])
    @tags = Emotion.all_tags

    if params[:tag_name]
      @emotions = Emotion.all.page(params[:page])
      @emotions = @emotions.tagged_with(params[:tag_name].to_s).per(Settings.number[:page_show_num])
    end
  end

  private

  def emotion_params
    params.require(:emotion).permit(:body, :tag_list).merge(user_id: current_user.id)
  end

  def book_params
    params.require(:emotion).permit(:bid)
  end
end
