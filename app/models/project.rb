class Project < ActiveRecord::Base
  belongs_to :nonprofit
  has_many :developer_projects
  has_many :developers, through: :developer_projects
end