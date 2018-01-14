class AddAuthorIdToPoem < ActiveRecord::Migration[5.1]
  def change
    add_column :poems, :author_id, :integer
  end
end
