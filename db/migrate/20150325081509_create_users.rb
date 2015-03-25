class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :short_name
      t.string :email
      t.string :user_name
      t.string :password_digest
      t.string :fb_id
      t.string :reset_password_token
      t.datetime :reset_password_token_at
      t.string :title
      t.string :role
      t.string :avatar
      t.string :gender
      t.datetime :last_signed_in_at
      t.boolean :blocked, default: false
      t.integer :sign_up_step, default: 0

      t.timestamps null: false
    end
  end
end
