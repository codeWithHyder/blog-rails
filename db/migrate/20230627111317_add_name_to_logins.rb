class AddNameToLogins < ActiveRecord::Migration[7.0]
  def change
    add_column :logins, :name, :string
  end
end
