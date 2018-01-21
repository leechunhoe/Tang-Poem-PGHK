class AddPhoneticTitleToPoem < ActiveRecord::Migration[5.1]
  def change
    add_column :poems, :title_hongim, :string
    add_column :poems, :title_tailo, :string
  end
end
