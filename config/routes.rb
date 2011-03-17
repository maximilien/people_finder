ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  map.connect 'my/:action/:id', :controller => 'my'
  map.connect 'fbml/:action/:id', :controller => 'fbml'
  map.connect 'requests/:action/:id', :controller => 'requests'
  map.connect 'stats/:action/:id', :controller => 'stats'
  
  map.survivors_atom 'feeds/survivors.atom', :controller => 'feeds', :action => 'survivors', :format => 'atom'
  map.survivor_updates_atom 'feeds/survivor_updates.atom', :controller => 'feeds', :action => 'survivor_updates', :format => 'atom'
  
  map.connect 'survivors/duplicates', :controller => 'survivors', :action => 'duplicates'
  map.connect 'survivors/duplicate', :controller => 'survivors', :action => 'duplicate'
  map.connect 'survivors/remove_duplicate', :controller => 'survivors', :action => 'remove_duplicate'
  map.connect 'survivors/missing', :controller => 'survivors', :action => 'missing'
  map.connect 'survivors/trapped', :controller => 'survivors', :action => 'trapped'
  map.connect 'survivors/injured', :controller => 'survivors', :action => 'injured'
  map.connect 'survivors/ok_well', :controller => 'survivors', :action => 'ok_well'
  map.connect 'survivors/ok', :controller => 'survivors', :action => 'ok'
  map.connect 'survivors/other', :controller => 'survivors', :action => 'other'
  
  map.connect 'survivors/randomly_tweet', :controller => 'survivors', :action => 'randomly_tweet'
  map.connect 'survivors/tweet', :controller => 'survivors', :action => 'tweet'
  
  map.connect 'survivor_updates/randomly_tweet', :controller => 'survivor_updates', :action => 'randomly_tweet'
  map.connect 'survivor_updates/tweet', :controller => 'survivor_updates', :action => 'tweet'
  
  map.connect 'locations/show_locations_map', :controller => 'locations', :action => 'show_locations_map'
  map.connect 'locations/show_all_locations', :controller => 'locations', :action => 'show_all_locations'
  map.connect 'locations/remove_duplicate', :controller => 'locations', :action => 'remove_duplicate'
  map.connect 'locations/duplicate', :controller => 'locations', :action => 'duplicate'
    
  map.connect 'profiles/:id', :controller => 'profiles', :action => 'show'
  map.connect 'profiles/:action', :controller => 'profiles'
  
  # Sample resource route with sub-resources:
  map.resources :invitations
  map.resources :sharings
  map.resources :survivors
  map.resources :survivor_updates
  map.resources :profiles
  map.resources :locations
  map.resources :family_members
  map.resources :friends
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "welcome"
  
  # See how all your routes lay out with "rake routes"
  
  # Install the default routes as the lowest priority.
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end