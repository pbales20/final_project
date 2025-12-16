import { Controller } from "@hotwired/stimulus"

// Turns a <select multiple data-controller="multi-select"> into a dropdown-esque UI
// by shrinking to a single option by default and expanding on focus.
export default class extends Controller {
  static values = {
    expandedSize: { type: Number, default: 6 }
  }

  connect() {
    this.defaultSize = this.element.size || 1
    this.element.size = 1
    this.element.classList.add("multi-select-dropdown")
  }

  expand() {
    this.element.size = this.expandedSizeValue
    this.element.classList.add("is-open")
  }

  collapse() {
    this.element.size = 1
    this.element.classList.remove("is-open")
  }
}
