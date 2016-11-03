class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :contact, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
