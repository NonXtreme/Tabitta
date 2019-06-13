class CreateHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :hashtags do |t|
      t.string :name, index: true
      t.references :tweet, index: true, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
