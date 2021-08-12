class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :approved, :boolean
    add_column :users, :role, :integer
    add_column :users, :date_of_birth, :date
  end
end
