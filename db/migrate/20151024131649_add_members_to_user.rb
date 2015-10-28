class AddMembersToUser < ActiveRecord::Migration
  def change
      add_column :users, :type, :string
      add_column :users, :first_name, :string
      add_column :users, :last_name, :string
      add_column :users, :dob, :string
      add_column :users, :postal_code, :integer
      add_column :users, :yrs_coached, :float
      add_column :users, :affiliation, :string
  end
end
