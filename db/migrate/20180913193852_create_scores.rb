class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :user, foreign_key: true
      t.integer :difficulty
      t.integer :num_played
      t.integer :num_correct

      t.timestamps
    end
  end
end
