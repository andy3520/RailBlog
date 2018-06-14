module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar img-fluid header-avatar mini-post-avatar")
  end

  def first_name(full_name)
    words = full_name.split(' ')
    last_word = words.last
    user = last_word.length > 6 ? last_word[0...6]+'..' : last_word
  end
end
