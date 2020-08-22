class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :access, :string
    add_column :posts, :store_name, :string
  end
end
