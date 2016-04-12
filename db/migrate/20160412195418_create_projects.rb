class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :project_specs
      t.datetime :created_at
      t.datetime :updated_at
      t.date :due_date
      t.integer :nonprofit_id
    end
  end
end
