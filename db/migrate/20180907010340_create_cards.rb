class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.text :first_last_name
      t.text :company
      t.text :school
      t.text :job_title
      t.string :image_url
      t.string :profile_url

      t.timestamps
    end
  end
end
