class LatestImages
  NAME_SPACE='latest_images'

  def self.read(start, num)
    latest_images = []
    num.times do |count|
      image = Rails.cache.read("#{NAME_SPACE}:#{start + count}")
      image.present? ? latest_images << image : break
    end
    latest_images
  end

  def self.update
    today_period = Time.current.beginning_of_day..Time.current.end_of_day
    latest_images = Image.where(created_at: today_period).shuffle
    latest_images.each.with_index do |latest_image, index|
      Rails.cache.write("#{NAME_SPACE}:#{index}", latest_image)
    end
  end

  def self.all_delete
    count = 0
    loop do
      result = Rails.cache.delete("#{NAME_SPACE}:#{count}")
      break if result == 0
      count += 1
    end
  end
end