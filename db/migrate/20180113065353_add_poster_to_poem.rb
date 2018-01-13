class AddPosterToPoem < ActiveRecord::Migration[5.1]
  def change
    add_column :poems, :poster_url, :string
  end
end
