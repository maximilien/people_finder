module FacebookApiHelper
  def get_facebook_profile_info facebook_user
    profile_hash = {}
    profile_hash[:first_name] = facebook_user.first_name
    profile_hash[:last_name] = facebook_user.last_name
    profile_hash
  end
end