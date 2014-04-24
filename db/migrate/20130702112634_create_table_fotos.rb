class CreateTableFotos < ActiveRecord::Migration
 def change
   create_table :fotos do |t|
     t.string :title
     t.string :file
     t.references :attachable, :polymorphic => true

     t.timestamps
   end
   add_index :fotos, :attachable_id
 end
end
