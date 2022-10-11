// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "@fortawesome/fontawesome-free"

function headerDropdownController() {
    const dropdownTrigger = document.querySelector('#dropdownMenuButton')
    const dropdown = document.querySelector('.dropdown-menu')

    dropdownTrigger.addEventListener('click', () => {
        dropdown.classList.toggle('show')

        document.addEventListener('click', function(event) {
            const isClickOutside = !dropdown.contains(event.target) && !dropdownTrigger.contains(event.target);
            if (isClickOutside) {
                dropdown.classList.remove('show')
            }
        });
    })


}

headerDropdownController()

