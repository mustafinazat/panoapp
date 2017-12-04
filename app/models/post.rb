class Post < ApplicationRecord
	belongs_to :user
	has_many :panoramas, as: :parentlink , :dependent => :destroy
end

