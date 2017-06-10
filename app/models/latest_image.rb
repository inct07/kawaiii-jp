DataMapper.setup(:default, {:adapter => 'redis'})

class LatestImage
  include Redis::Objects
  include DataMapper::Resource

  property :id, Serial
  property :image_id, String
  property :girl_id, String
  property :img_path, String
end

LatestImage.finalize