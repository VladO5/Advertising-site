class Create < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email, unique: true
      t.string :password
      t.boolean :isModerator, default: false
      t.timestamps
    end

    create_table :advertisements do |t|
      t.string :title
      t.string :body
      t.boolean :isApproved
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
