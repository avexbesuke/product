class PagesController < ApplicationController
  def index; end

  def show
    @user = User.find(params[:id])
    @readed_books = @user.read_books.limit(3)
    @fast_best_book = @user.books.first
    @fast_best_emotion = @user.emotions.first

    @othere_emotions = []
    @othere_reads = []
    if follows.present?
      follows.each do |user|
        emotions = Emotion.where(user_id: user.id).order(created_at: :desc)
        @othere_emotions.concat(emotions)

        reads = Read.where(user_id: user.id).order(created_at: :desc)
        @othere_reads.concat(reads)
      end
      @othere_emotions = @othere_emotions.sort_by!(&:created_at).reverse!
      @othere_reads = @othere_reads.sort_by!(&:created_at).reverse!
    end


    #グラフ練習
    @reads = @user.reads.group("CONCAT(YEAR(created_at), MONTH(created_at))").count
  end

  private

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end
end
