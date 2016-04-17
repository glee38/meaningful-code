class Message < ActiveRecord::Base
  validates_presence_of :recipient, :subject, :content

  belongs_to :developer
  belongs_to :nonprofit
end