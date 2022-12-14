import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="general-info"
export default class extends Controller {
    static targets = [ "card", "panel" ]

    show() {
        this.request = new Request(event.target.dataset.showUrl);
        this.fetchContent(this.request);
    }

    fetchContent(request) {
        fetch(request)
            .then((response) => {
                if (response.status == 200) {
                    response.text().then((text) => this.panelTarget.innerHTML = text);
                } else {
                    console.log("Couldn't load data");
                }
            })
    }
}