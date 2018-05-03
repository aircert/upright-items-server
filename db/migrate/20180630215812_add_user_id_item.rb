class AddUserIdItem < ActiveRecord::Migration[5.1]
  def change
    change_table :items do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
    end
  end
end