class CreatePoems < ActiveRecord::Migration[5.1]
  def change
    create_table :poems do |t|
      t.string :hanji
      t.string :stailo
      t.string :hongim

      t.timestamps
    end
  end
end
