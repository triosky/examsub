class CreateExamLists < ActiveRecord::Migration
  def change
    create_table :exam_lists do |t|
      t.string :vendor_name
      t.string :exam_code
      t.string :exam_lang
      t.string :exam_title
      t.string :exam_time
      t.string :exam_cost
      t.text   :user_ids, :default => ""
      t.integer :sub_count, :default => 0

      t.timestamps null: false
    end
  end
end
