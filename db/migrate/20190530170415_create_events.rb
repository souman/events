class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.integer :state
      t.datetime :starttime
      t.datetime :endtime
      t.boolean :allday
      t.timestamps
    end
  end
end
