class Post < ActiveRecord::Base
  belongs_to :user

  strip_attributes only: [:text]

  validates_presence_of :user, :text

end
