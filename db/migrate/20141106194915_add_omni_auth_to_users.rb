class AddOmniAuthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :omniauth_id, :string, unique: true
    
    add_index :users, :omniauth_id
  end
end
