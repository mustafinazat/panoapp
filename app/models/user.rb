class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         #:omniauthable, omniauth_providers: [:vkontakte]
  has_many :posts, dependent: :destroy
  has_many :virtualtours, dependent: :destroy
  has_many :articles, dependent: :destroy
  validates :nickname, presence: { :message => " должен быть!!!"}, length: { minimum: 5 }, uniqueness: true
  validates :description, presence: { :message => " должно быть!!!"}, length: { minimum: 22 }, if: "!encrypted_password_changed?"
 # def self.from_vkontakte(auth)
 #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
 #     user.nickname = auth.info.name
 #  end
 # end


  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [
        [nickname.to_s.to_slug.normalize(transliterations: :russian).to_s]
    ]
  end

  def update_slug
    unless slug.include? self.id.to_s
      self.slug = nil
      self.save
    end
  end



end
