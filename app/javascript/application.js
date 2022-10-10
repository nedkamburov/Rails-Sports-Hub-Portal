// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "@fortawesome/fontawesome-free"

const dropdownTrigger = document.querySelector('#dropdownMenuButton')
const dropdown = document.querySelector('.dropdown-menu')
dropdownTrigger.addEventListener('click', () => {
    dropdown.classList.toggle('show')
})