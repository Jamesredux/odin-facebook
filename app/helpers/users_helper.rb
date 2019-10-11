module UsersHelper

	#returns the gravatar for a given user
	#def gravatar_for(user, size: 80)
	#	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	#	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
	#	image_tag(gravatar_url, alt: user.name, class: "gravatar")
	#end	

	 def gravatar_for(user, options = { size: 80 })
    size         = options[:size]
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  private

  def signed_in_user?
  	User.find(params[:id]) == current_user

  end	

  def current_user?(user)
    user == current_user
  end

  def not_friends(user)
    !current_user.friends.include?(user)
  end  

  def not_already_sent(user)
    !current_user.pending_friends.include?(user)
  end
end
