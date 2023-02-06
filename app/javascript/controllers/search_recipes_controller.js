import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-recipes"
export default class extends Controller {

  static targets = [ "form", "ingredients", "ingredient", "ingredientlist", "array" ]
  static values = ["ingredient"]

  connect() {
  }

  removeIngredient(event) {
    // console.log(event.target.innerText);
    const thisIngredient = event.target.innerText;
    console.log(thisIngredient)

    const oldURI = [this.formTarget.baseURI]
    var newUri = `${oldURI}`.replace(`${thisIngredient}`, '');
    console.log(newUri)
    window.location.replace(newUri)
  }


}
