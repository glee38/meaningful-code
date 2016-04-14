class Nonprofit < ActiveRecord::Base
  has_secure_password
  validates_presence_of :name, :cause, :tagline, :website, :username, :email, :password_digest
  validates_uniqueness_of :username, :email, :website
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  has_many :projects
  has_many :developers, through: :projects

  include Slugify
  extend Slugify

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end