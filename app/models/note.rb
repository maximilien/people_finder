class Note < ActiveRecord::Base
  belongs_to :user
  
  belongs_to :person
  belongs_to :linked_person,
             :class_name => 'Person', 
             :foreign_key => :linked_person_id
end