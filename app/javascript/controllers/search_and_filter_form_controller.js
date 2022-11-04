import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-and-filter-form"
export default class extends Controller {
  static targets = [ "form" ]

  search_and_filter() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 200)
  }
}
