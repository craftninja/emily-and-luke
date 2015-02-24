class Registry < ActiveRecord::Base

  validates_presence_of :img_url, :title, :url, :description

end
