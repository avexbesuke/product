class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:about]
  def index; end

  def show
    @user = User.find(params[:id])
    @readed_books = @user.read_books.order("created_at DESC").limit(10)
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

    unless @user.reads.empty?
      reads = @user.reads.group("CONCAT(YEAR(created_at), MONTH(created_at))").count.sort.pop(6)
      reads_flat = reads.flatten!
      reads_numeric = []
      reads_flat.each do |read|
        reads_numeric.push(read) if read.is_a? Numeric
      end
      gon.max_read = reads_numeric.max

      read_date = @user.reads.group("CONCAT(YEAR(created_at), MONTH(created_at))").count
      now = Date.today
      month = Date.today >> 1
      year_month = []
      6.times do
        read_date[now] = if read_date.key?(now.year.to_s + now.month.to_s)
                           read_date.delete(now.year.to_s + now.month.to_s)
                         else
                           0
                         end
        year_month.push(month.year.to_s[2, 2].to_s + "/" + month.month.to_s)
        month = month << 1
        now = now << 1
      end

      gon.reads = read_date.sort.pop(6)
      gon.year_month = year_month
    end
  end

  private

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end
end
