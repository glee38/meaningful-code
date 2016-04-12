class CreateDevelopers < ActiveRecord::Migration
  def change
    create_table :developers do |t|
      t.string :name
      t.string :github
      t.string :username
      t.string :password_digest
      t.string :email
    end
  end
end
