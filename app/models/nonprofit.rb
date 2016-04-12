class Nonprofit < ActiveRecord::Base
  has_many :projects
  has_many :developer_projects
  has_many :developers, through: :developer_projects
end