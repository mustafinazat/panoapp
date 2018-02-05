module ApplicationHelper



  def flash_class(msg_type)
    case msg_type
        when "notice" then "alert alert-info"
        when "success" then "alert alert-success"
        when "error" then "alert alert-danger"
        when "alert" then "alert alert-warning"
    end
end


  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "#{flash_class(msg_type)} alert-dismissable") do 
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message 
            end)
    end
    nil
  end

  def imageoriginal(panorama)
    if panorama
      if panorama.parentlink.vk_album_id.empty?
        panorama.image.url
      else
        panorama.image_file_name
      end
    end
  end

  def imagethumb(panorama) 
  if panorama
  if panorama.parentlink.vk_album_id.empty? 
    panorama.image.url(:thumb)
else
  panorama.image_file_name_thumb
  end
end
  end


  

end
