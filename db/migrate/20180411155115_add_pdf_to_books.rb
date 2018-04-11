class AddPdfToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :pdf_data, :text
  end
end
