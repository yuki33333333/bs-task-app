class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.string :name, null: false
      t.string :mail, null: false
      t.string :password_digest, null: false
      t.string :remenber_token

      t.timestamps
    end
  end
end
