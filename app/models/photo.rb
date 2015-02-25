class Photo < ActiveRecord::Base

  validates_presence_of :img_url, :date

end
