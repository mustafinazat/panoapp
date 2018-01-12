class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         #:omniauthable, omniauth_providers: [:vkontakte]
  has_attached_file :avatar, :styles => { :large => "400x400>", :medium => "200x200>", :thumb => "100x100>" }, default_url: "/images/missing_avatar.jpg"
  validates_attachment :avatar, :content_type => { :content_type => "image/jpeg", :message => "Only JPEG formats allowed" }
  has_many :posts, dependent: :destroy
  has_many :virtualtours, dependent: :destroy


 # def self.from_vkontakte(auth)
 #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
 #     user.nickname = auth.info.name
  #  end
 # end


end
