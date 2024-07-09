class CreateMeetings < ActiveRecord::Migration[7.1]
  def change
    create_table :meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.integer :in_progress_sync_status
      t.boolean :last_sync_success
      t.datetime :last_sync_at

      t.timestamps
    end
  end
end
