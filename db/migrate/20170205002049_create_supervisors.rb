class CreateSupervisors < ActiveRecord::Migration[5.0]
  def change
    create_table :supervisors do |t|
      t.belongs_to :user, foreign_key: true
      t.string :name
      t.string :hostname
      t.integer :port

      t.timestamps
    end
  end
end
