class RenameColumncooking_timeInMyRecipe < ActiveRecord::Migration[7.0]
  def change
    rename_column :my_recipes, :cooking_time, :cooking_time
  end
end
