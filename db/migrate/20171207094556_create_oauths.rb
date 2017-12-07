class CreateOauths < ActiveRecord::Migration[5.1]
  def change
    create_table :oauths do |t|

      t.timestamps
    end
  end
end
