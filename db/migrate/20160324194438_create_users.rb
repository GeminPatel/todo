class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :password_digest
      t.boolean :admin
      t.boolean :status
      t.datetime :last_login_on
      t.string :remember_digest

      t.timestamps null: false
    end
  end
end
