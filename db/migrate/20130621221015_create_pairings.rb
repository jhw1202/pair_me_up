class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.integer :member_1
      t.integer :member_2

      t.timestamps
    end
  end
end
