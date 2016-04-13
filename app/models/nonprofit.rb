class Nonprofit < ActiveRecord::Base
  has_secure_password
  validates_presence_of :name, :github, :username, :email, :password_digest
  validates_uniqueness_of :username, :email, :github
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  has_many :projects
  has_many :developer_projects
  has_many :developers, through: :developer_projects

  include Slugify
  extend Slugify
end