class ProfilePublisher< Facebooker::Rails::Publisher
 include ApplicationHelper
 
 def profile_update user
   send_as :profile
   from user.facebook_session.user
   recipients user.facebook_session.user
   profile render(:partial => "profile.fbml.erb", 
                  :locals => {:profile => user.profile, :app_name => app_name, 
                              :haiti_quake_survirvors_url => haiti_quake_survirvors_url,
                              :site_blurb_short => site_blurb_short})
   profile_action render(:partial => "profile_action.fbml.erb", 
                         :locals => {:haiti_quake_survirvors_url => haiti_quake_survirvors_url})
  end
end