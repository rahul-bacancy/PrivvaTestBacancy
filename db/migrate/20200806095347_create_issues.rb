class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.string :name
      t.text :description
      t.string :status
      t.references :project, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
