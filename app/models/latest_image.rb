DataMapper.setup(:default, {:adapter => 'redis'})

class LatestImage
  include Redis::Objects
  include DataMapper::Resource

  property :id, Serial
  value :image_id
  value :girl_id
  value :img_path
end

LatestImage.finalize