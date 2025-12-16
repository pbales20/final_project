import { Controller } from "@hotwired/stimulus"

// Makes a checkbox list behave like a dropdown multi-select badge.
export default class extends Controller {
  static targets = ["toggle", "panel", "summary"]
  static values = {
    defaultLabel: String
  }

  connect() {
    this.boundOutsideClick = this.handleOutsideClick.bind(this)
    document.addEventListener("click", this.boundOutsideClick)
    this.updateSummary()
  }

  disconnect() {
    document.removeEventListener("click", this.boundOutsideClick)
  }

  toggle(event) {
    event.preventDefault()
    if (this.isOpen()) {
      this.close()
    } else {
      this.open()
    }
  }

  changed() {
    this.updateSummary()
    this.submitForm()
  }

  updateSummary() {
    const checked = this.checkboxElements().filter((checkbox) => checkbox.checked)
    if (checked.length === 0) {
      this.summaryTarget.textContent = this.defaultLabelValue || "Select"
      this.summaryTarget.classList.add("is-placeholder")
      return
    }

    const labels = checked
      .map((checkbox) => checkbox.dataset.optionLabel)
      .filter(Boolean)

    this.summaryTarget.classList.remove("is-placeholder")
    if (labels.length <= 2) {
      this.summaryTarget.textContent = labels.join(", ")
    } else {
      const remainder = labels.length - 2
      this.summaryTarget.textContent = `${labels.slice(0, 2).join(", ")} +${remainder} more`
    }
  }

  handleOutsideClick(event) {
    if (this.isOpen() && !this.element.contains(event.target)) {
      this.close()
    }
  }

  isOpen() {
    return !this.panelTarget.hasAttribute("hidden")
  }

  open() {
    this.panelTarget.removeAttribute("hidden")
    this.toggleTarget.classList.add("is-open")
  }

  close() {
    this.panelTarget.setAttribute("hidden", true)
    this.toggleTarget.classList.remove("is-open")
  }

  checkboxElements() {
    return Array.from(this.panelTarget.querySelectorAll('input[type="checkbox"]'))
  }

  submitForm() {
    const form = this.element.closest("form")
    if (form) {
      form.requestSubmit()
    }
  }
}
