class Article < ApplicationRecord

	after_commit :update_slug, on: :create
	belongs_to :user
	has_many :taggings
  has_many :tags, through: :taggings , :dependent => :destroy
  validates :title, presence: { :message => " должно быть заполнено"}

  has_attached_file :picture, :styles => { :large => "1000x1000>", :medium => "700x700>", :thumb => "200x200>" }, default_url: "/images/missing_avatar.jpg"
  validates_attachment :picture, :content_type => { :content_type => "image/jpeg", :message => "Only JPEG formats allowed" }
  

def all_tags
 self.tags.map(&:name).join(', ')
end

def all_tags=(names)

self.tags = names.split(",").map do |name|
  Tag.where(name: name.strip).first_or_create!
end
end

extend FriendlyId

 friendly_id :slug_candidates, use: [:slugged, :finders]
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
      where('lower(title) LIKE ?', "%#{search.downcase}%")
    else
     Article.all
    end
  end
end
