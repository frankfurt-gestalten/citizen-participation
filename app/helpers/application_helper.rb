module ApplicationHelper

  def title(page_title)
    content_for(:title) { page_title }
  end

  def random_banner
    @banner_photos = Banner.random_banner
  end

  def recent_banner
    @banner_photos = Banner.recent_banner
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def avatar_url(user, size)
    if user.avatar_url.present?
      image_url = user.avatar_url(:avatar)
    else
      default_url = "#{root_url}assets/avatar-#{size}.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      image_url = "https://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm"
    end
  end
end
