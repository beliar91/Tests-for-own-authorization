class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :password_reset_token
      t.datetime :password_sent_at

      t.timestamps null: false
    end
  end
end
