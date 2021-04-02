class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :name, null: false
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
