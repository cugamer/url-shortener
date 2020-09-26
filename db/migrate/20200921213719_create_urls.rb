class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :full_url
      t.string :short_url

      t.timestamps
    end
    add_index :urls, [:full_url, :short_url], unique: true
  end
end
