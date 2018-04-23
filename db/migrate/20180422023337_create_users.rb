class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :name
      t.string :last_name
      t.string :email
      t.boolean :admin
      t.boolean :active
      t.datetime :last_activity
      t.boolean :password_expires

      t.timestamps
    end
  end
end
