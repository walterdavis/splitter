class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.references :book, foreign_key: true
      t.text :image_data

      t.timestamps
    end
  end
end
