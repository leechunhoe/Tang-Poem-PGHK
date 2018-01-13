class AddAuthorToPoem < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :author, :author
  end
end
