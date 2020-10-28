# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :autor
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
