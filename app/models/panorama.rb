class Panorama < ApplicationRecord

  belongs_to :parentlink, polymorphic: true
  has_attached_file :image,
  styles: { original:  {}, originalq80:  {}, thumb: "1280x720#"},
  convert_options: { originalq80:  "-quality 80" , thumb: "-quality 80"}
    do_not_validate_attachment_file_type :image
    
end
