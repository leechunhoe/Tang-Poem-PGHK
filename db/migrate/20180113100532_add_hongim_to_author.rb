class AddHongimToAuthor < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :hongim, :string
  end
end
