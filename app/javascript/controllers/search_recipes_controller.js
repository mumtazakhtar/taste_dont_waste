import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="search-recipes"
// export default class extends Controller {
//   connect() {
//     console.log("Hello from the controller")
//   }
// }

// Connects to data-controller="search-recipes"
export default class extends Controller {

  static targets = [ "form", "ingredients", "ingredient", "ingredientlist", "array"]
  static values = ["ingredient"]

  connect() {
  }


  removeIngredient(event) {
    // console.log(event.target.innerText);
    const thisIngredient = event.target.innerText.toLocaleLowerCase();
    console.log(thisIngredient)
    // console.log(this.ingredientlistTargets[0].dataset.ingredient)

    const oldURI = [this.formTarget.baseURI.toLocaleLowerCase()]
    // console.log(oldURI)

    if (this.ingredientlistTargets.length === 1 ) {
      var newUri = `${oldURI}`.replace(`${thisIngredient}`, '');
    } else if (this.ingredientlistTargets[0].dataset.ingredient === thisIngredient ){
      var newUri = `${oldURI}`.replace(`${thisIngredient}%2c+`, '');
    } else {
      var newUri = `${oldURI}`.replace(`%2c+${thisIngredient}`, '');
    }

    // console.log(newUri)
    window.location.replace(newUri)
  }

}
