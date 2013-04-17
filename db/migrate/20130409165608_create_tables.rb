class CreateTables < ActiveRecord::Migration
  def change
    # Widgets

    create_table :widgets do |t|
      t.string :name, :null => false
      t.boolean :legacy, :null => false, :default => false
      t.integer :location_id, :null => false

      t.timestamps
    end

    add_index :widgets, :location_id
    add_index :widgets, :updated_at
    add_index :widgets, :created_at

    # Features

    create_table :features do |t|
      t.string :name, :null => false
      t.integer :widget_id, :null => false

      t.timestamps
    end

    add_index :features, :widget_id
    add_index :features, :updated_at
    add_index :features, :created_at

    # Locations

    create_table :locations do |t|
      t.string :name, :null => false

      t.timestamps
    end

    add_index :locations, :name
    add_index :locations, :created_at
  end
end
