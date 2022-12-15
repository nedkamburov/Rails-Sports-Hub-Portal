import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reactive-table"
export default class extends Controller {
    static targets = [ "tab", "cards" ]

    connect() {
      const firstTab = document.querySelector('.selected');
      this.#change_url(firstTab)
    }

    toggle() {
        const selected = document.querySelector('.selected');
        if (selected !== null) {
            selected.classList.toggle('selected');
        }
        event.target.classList.toggle('selected');
        this.#change_url(event.target)
        this.request = new Request(event.target.dataset.toggleUrl);
        this.fetchContent(this.request);
    }

    fetchContent(request) {
        fetch(request)
            .then((response) => {
                if (response.status == 200) {
                    response.text().then((text) => this.cardsTarget.innerHTML = text);
                } else {
                    console.log("Couldn't load data");
                }
            })
    }

    #change_url(target) {
        const page_type = target.dataset.togglePageType
        const addNewButton = document.querySelector('#add-new-button');
        if (!addNewButton) return
        addNewButton.href = addNewButton.href.replace(/(?<=new).*/, `?page_type=${page_type}`)
    }
}