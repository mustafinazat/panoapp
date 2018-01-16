class Tag < ApplicationRecord
has_many :taggings
 has_many :posts, through: :taggings
 has_many :virtualtours, through: :taggings
 has_many :articles, through: :taggings
end
