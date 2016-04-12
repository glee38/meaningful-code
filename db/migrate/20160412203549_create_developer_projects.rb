class CreateDeveloperProjects < ActiveRecord::Migration
  def change
    create_table :developer_projects do |t|
      t.integer :developer_id
      t.integer :project_id
    end
  end
end
