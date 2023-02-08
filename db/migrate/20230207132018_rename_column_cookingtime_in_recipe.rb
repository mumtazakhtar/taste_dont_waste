class RenameColumncooking_timeInRecipe < ActiveRecord::Migration[7.0]
  def change
    rename_column :recipes, :cooking_time, :cooking_time
  end
end
