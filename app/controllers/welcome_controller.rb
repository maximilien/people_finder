# 
# Welcome controller
# @author E. M. Maximilien
# Copyright (C) IBM Corp., 2011
# License under the MIT license, found here: 
#

class WelcomeController < ApplicationController  
  skip_before_filter :ensure_application_is_installed_by_facebook_user, :only => [:privacy_policy, :tou]
  skip_before_filter :set_current_user, :only => [:privacy_policy, :tou]
  skip_before_filter :reminders, :only => [:privacy_policy, :tou]
  
  before_filter :set_about_tab
  
  def index
  end
  
  def about
  end
  
  def tou
    respond_to do |format|
      format.fbml { render :template => 'welcome/tou', :layout => false } 
    end
  end
  
  def news
  end
  
  def privacy_policy
    respond_to do |format|
      format.fbml { render :template => 'welcome/privacy_policy', :layout => false } 
    end
  end

  def faq
  end

  def recruiting_faq  
  end

  def faqs
    render :action => 'faq'
  end

  def recruiting_faqs
     render :action => 'recruiting_faq'
  end

  private
  
  def set_about_tab
    @about_tab = "AboutTab"
  end
end