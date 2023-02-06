import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="search-recipes"
// export default class extends Controller {
//   connect() {
//     console.log("Hello from the controller")
//   }
// }

// Connects to data-controller="search-recipes"
export default class extends Controller {

  static targets = [ "form", "test" ]

  connect() {
    console.log(this.formTarget.value)
  }

  addIngredient() {
    this.testTarget.innerText = "Bingo!"
  }

}
