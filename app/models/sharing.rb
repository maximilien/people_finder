class Sharing < ActiveRecord::Base
  belongs_to :survivor_update
  belongs_to :user
  belongs_to :shared_user,
             :class_name => 'User', 
             :foreign_key => :shared_user_id
end
