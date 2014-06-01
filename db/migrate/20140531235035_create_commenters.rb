class CreateCommenters < ActiveRecord::Migration
  def change
    create_table :commenters do |t|
      t.string :name
      t.string :email
      t.string :address_line_1
      t.string :zip
      t.text :comment
      t.boolean :sent_to_fcc
      t.timestamps
    end
  end
end
