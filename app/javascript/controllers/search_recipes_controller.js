import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-recipes"
export default class extends Controller {
  connect() {
    console.log("Test test test")
  }
}
