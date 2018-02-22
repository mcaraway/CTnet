class CreateDbconnections < ActiveRecord::Migration[5.0]
  def change
    create_table :dbconnections do |t|
      t.string :adapter
      t.string :mode
      t.string :host
      t.string :port
      t.string :username
      t.string :password
      t.string :database
      t.string :encoding

      t.timestamps
    end
  end
end
