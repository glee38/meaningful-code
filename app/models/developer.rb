class Developer < ActiveRecord::Base
  has_many :developer_projects
  has_many :projects, through: :developer_projects
  has_many :nonprofits, through: :projects
end