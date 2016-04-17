class AddColumnDateToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :date, :date
  end
end
