// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "@fortawesome/fontawesome-free"
Turbo.session.drive = false

popupAddCategoryController()

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