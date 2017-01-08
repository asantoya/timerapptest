class CreateTasks < ActiveRecord::Migration[5.0]
  
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :name
      t.string :text
      t.integer :duration
      t.string :state
      t.timestamps :start_date
      t.timestamps :stop_date


      t.timestamps
    end
  end
end
