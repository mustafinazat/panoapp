class Post < ApplicationRecord
	belongs_to :user
	has_many :panoramas, as: :parentlink , :dependent => :destroy



 def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
     Post.all
    end
  end


end

