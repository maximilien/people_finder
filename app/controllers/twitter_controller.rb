class TwitterController < ApplicationController
  skip_before_filter :ensure_application_is_installed_by_facebook_user, :set_current_user, :update_stats, :reminders, :register_publish_action, :ensure_authenticated_to_facebook
  
  def oauth
    #DEBUG
    puts 'twitter OAuth SUCCESS!'
    puts params
    #END
  end
end