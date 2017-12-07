class Virtualtour < ApplicationRecord
	belongs_to :user
	has_many :panoramas, as: :parentlink , :dependent => :destroy


	 def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
     Virtualtour.all
    end
  end


end
