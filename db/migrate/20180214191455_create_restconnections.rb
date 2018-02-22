class CreateRestconnections < ActiveRecord::Migration[5.0]
  def change
    create_table :restconnections do |t|
      t.string :host
      t.string :appname
      t.string :appid
      t.string :description
      t.string :debug
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
