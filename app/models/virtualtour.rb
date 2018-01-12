class Virtualtour < ApplicationRecord
	belongs_to :user
	has_many :panoramas, as: :parentlink , :dependent => :destroy
	has_many :taggings
  has_many :tags, through: :taggings








  def allv_tags
 self.tags.map(&:name).join(', ')
end

def allv_tags=(names)

 self.tags = names.split(",").map do |name|
  Tag.where(name: name.strip).first_or_create!
end
end

extend FriendlyId





 friendly_id :slug_candidates, use: :slugged
 def slug_candidates
    [
      
      [id.to_s, title.to_s.to_slug.normalize(transliterations: :russian).to_s]
    ]
  end



 def update_slug
    unless slug.include? self.id.to_s
      self.slug = nil
      self.save
    end
  end





	 def self.search(search)
    if search
      where('title LIKE ?', "%#{search}%")
    else
     Virtualtour.all
    end
  end


end
