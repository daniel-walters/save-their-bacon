class CreateAnimals < ActiveRecord::Migration[6.1]
  def change
    create_table :animals do |t|
      t.string :name
      t.integer :year_born
      t.integer :weight
      t.text :bio
      t.string :species
      t.boolean :sponsored
      t.integer :sponsor_price
      t.references :category, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
