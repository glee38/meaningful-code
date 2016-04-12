class CreateNonprofits < ActiveRecord::Migration
  def change
    create_table :nonprofits do |t|
      t.string :name
      t.text :cause
      t.text :tagline
      t.string :website
      t.string :username
      t.string :password_digest
      t.string :email
    end
  end
end
