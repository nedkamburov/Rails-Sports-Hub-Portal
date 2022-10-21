// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "@fortawesome/fontawesome-free"
Turbo.session.drive = false

headerDropdownController()
popupAddCategoryController()

function headerDropdownController() {
    const dropdownTrigger = document.querySelector('#dropdownMenuButton')
    const dropdown = document.querySelector('.dropdown-menu')
    if (!dropdownTrigger || !dropdown) return

    dropdownTrigger.addEventListener('click', () => {
        dropdown.classList.toggle('show')

        document.addEventListener('click', function (event) {
            const isClickOutside = !dropdown.contains(event.target) && !dropdownTrigger.contains(event.target);
            if (isClickOutside) {
                dropdown.classList.remove('show')
            }
        });
    })
}
function popupAddCategoryController() {
    const addButtons = document.querySelectorAll('.col-add-item')
    const popups = document.querySelectorAll('.popup-add-item')
    if (!addButtons) return

    addButtons.forEach(btn => {
        btn.addEventListener('click', (e) => {
            const popup = e.target.querySelector('.popup-add-item')
            if (!popup) return
            const cancelBtn = popup.querySelector('#cancel')
            hideAllPopups()
            popup.classList.add('active')

            cancelBtn.addEventListener('click', () => {
                popup.classList.remove('active')
            })
        })
    })

    function hideAllPopups() {
        popups.forEach(popup => {
            popup.classList.remove('active')
        })
    }
}