// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"
import "@fortawesome/fontawesome-free"
Turbo.session.drive = false
import "trix"
import "@rails/actiontext"

Turbo.setConfirmMethod((recordType, element) => {
    let dialog = document.getElementById("turbo-confirm")

    // Populate the dialog window text with a specific record type name
    if (recordType) dialog.querySelectorAll(".record-type")
        .forEach(el => el.textContent = recordType  )
    dialog.showModal()

    return new Promise((resolve, reject) => {
        dialog.addEventListener("close", () => {
            resolve(dialog.returnValue == "confirm")
        }, { once: true })
    })
})