module UsersHelper
  def gravatar_for user, size: Settings.validations.users.size_avatar
    gravatar_id = Digest::MD5.hexdigest user.email.downcase
    gravatar_url = "#{Settings.links.gravatar}#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
