class Person < ActiveRecord::Base
  belongs_to :user
  belongs_to :survivor
  
  has_many :notes
end