class ThreadBannings < ActiveRecord::Migration[5.2]
  def change
    create_table :thread_bannings do |t|
      t.references :user, foreign_key: true, index: true
      t.references :thread, foreign_key: true, index: true
      t.integer :duration
      t.string :reason
    end
  end
end
