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
      po.string :playerOne
      po.string :playerTwo
      po.string :playerThree
      po.string :playerOne_img
      po.string :playerTwo_img
      po.string :playerThree_img
      po.string :p1_statOne
      po.string :p1_statTwo
      po.string :p1_statThree
      po.string :p2_statOne
      po.string :p2_statTwo
      po.string :p2_statThree
      po.string :p3_statOne
      po.string :p3_statTwo
      po.string :p3_statThree
      po.string :content
      po.string :category
      po.datetime :created_at
      po.datetime :updated_at
    end
    add_column :posts, :user_id, :integer
  end
end
