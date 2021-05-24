class CreateStatements < ActiveRecord::Migration[6.1]
  def change
    create_table :statements do |t|
      t.string :action, null: false, limit: 20
      t.references :user, null: false, foreign_key: true
      t.decimal :balance, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
