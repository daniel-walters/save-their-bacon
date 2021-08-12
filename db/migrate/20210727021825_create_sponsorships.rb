class CreateSponsorships < ActiveRecord::Migration[6.1]
  def change
    create_table :sponsorships do |t|
      t.string :receipt
      t.references :animal, null: false, foreign_key: true
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.references :sponsor, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
