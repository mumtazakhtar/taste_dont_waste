import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-recipes"
export default class extends Controller {

  static targets = [ "form", "ingredients", "ingredient", "ingredientlist" ]
  static values = ["ingredient"]

  connect() {
    // console.log(this.formTarget.value)

  }

  addIngredient() {
    console.log("Ingredient added")
  }

  removeIngredient() {
    console.log("Remove button clicked")
    console.log(this.ingredientlistTarget.innerText)

    console.log(this.ingredientlistTargets)
    // console.log(event.ingredientTarget)
    // console.log(this.ingredientTarget.value)
    // console.log(this.searchRecipesTarget.value)
    // console.log(this.ingredientTarget.value)
    // console.log(this.ingredientlistTarget.value)
    // console.log(this.searchIngredientTarget.value)

    // console.log(this.formTarget.value)
    // const newQuery = [this.formTarget.value]
    // console.log(newQuery)
    // const x = newQuery.shift();
    // console.log(`variable x value: ${x}`);
  }


}
