

class Post < ApplicationRecord

	after_commit :update_slug, on: :create
  before_save :default_values
	belongs_to :user
	has_many :panoramas, as: :parentlink , :dependent => :destroy
  has_many :taggings
  has_many :tags, through: :taggings , :dependent => :destroy



  validates :title, presence: { :message => " должно быть заполнено"}, length: { minimum: 5 }
  validates :description, presence: { :message => " должно быть заполнено"}, length: { minimum: 22, maximum: 140  }

  scope :closed, -> { where(closed: true) }
  scope :opened, -> { where(closed: false) }

def self.getopened(user)
  if user
     Post.all.opened.or(Post.where(user_id: user.id, closed: true))
  else
    Post.all.opened
  end
end

  def default_values
    self.closed ||= false if self.closed.nil?
  end

def all_tags
 self.tags.map(&:name).join(', ')
end

def all_tags=(names)

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
      where('lower(title) LIKE ?', "%#{search.downcase}%")
    else
     Post.all
    end
  end
end


