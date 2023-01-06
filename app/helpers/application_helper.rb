module ApplicationHelper
  def flash_class(level)
    case level
    when "notice" then "alert alert-success"
    when "success" then "alert alert-success"
    when "error" then "alert alert-danger"
    when "alert" then "alert alert-danger"
    end
  end

  def user_avatar(user)
    user&.avatar.url || asset_path("user.png")
  end

  def user_avatar_thumb(user)
    user&.avatar.thumb.url || asset_path("user.png")
  end

  def event_photo(event)
    photos = event.photos.persisted

    photos&.sample&.photo&.url || asset_path("event.jpg")
  end

  def event_thumb(event)
    photos = event.photos.persisted

    photos&.sample&.photo&.thumb&.url || asset_path("event_thumb.jpg")
  end
end
