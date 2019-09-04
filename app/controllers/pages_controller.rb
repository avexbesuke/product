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
    
    reads = @user.reads.group("CONCAT(YEAR(created_at), MONTH(created_at))").count.sort.pop(6)
    reads_flat = reads.flatten!
    reads_numeric = []
    reads_flat.each do |read|
      if read.is_a? Numeric
        reads_numeric.push(read)
      end
    end
    gon.max_read = reads_numeric.max

    read_date = @user.reads.group("CONCAT(YEAR(created_at), MONTH(created_at))").count
    now = Date.today
    month = Date.today >> 1
    year_month = []
    6.times do
      if read_date.has_key?("#{now.year}" + "#{now.month}")
        read_date[now] = read_date.delete("#{now.year}" + "#{now.month}")
      else
        read_date[now] = 0
      end
      year_month.push("#{month.year.to_s[2,2]}" + "/" + "#{month.month}")
      month = month << 1
      now = now << 1
    end

    gon.reads = read_date.sort.pop(6)
    gon.year_month = year_month
  end

  private

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end
end
