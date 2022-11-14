import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="article-comments"
export default class extends Controller {
  connect() {
    document.querySelectorAll('.subcomment-form').forEach((el) => {
      el.addEventListener('click', (e) => {
        e.preventDefault();
        const form = e.currentTarget.parentNode.parentNode.parentNode.nextElementSibling
        form.classList.toggle('active')
      })
    })
  }
}
