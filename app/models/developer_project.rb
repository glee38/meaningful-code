class DeveloperProject < ActiveRecord::Base
  self.table_name = "developer_projects"
  belongs_to :developer
  belongs_to :project
end