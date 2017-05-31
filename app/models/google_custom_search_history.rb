class GoogleCustomSearchHistory < ApplicationRecord
  enum request_by: { latest: 0, bulk: 1 }
end