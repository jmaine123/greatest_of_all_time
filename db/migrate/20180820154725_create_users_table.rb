class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :email
      t.datetime :birthday
      t.datetime :created_at
      t.datetime :updated_at
    end

    create_table :posts do |po|
      po.string :owner
      po.string :title
      po.string :image_url
      po.string :content
      po.string :category
      po.datetime :created_at
      po.datetime :updated_at
    end
    add_column :posts, :user_id, :integer
  end
end
