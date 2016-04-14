class AddAboutMeColumnToDevelopers < ActiveRecord::Migration
  def change
    add_column :developers, :about_me, :text
  end
end
