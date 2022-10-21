import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="sort"
export default class extends Controller {
    connect() {
        this.sortable = Sortable.create(this.element, {
            animation: 150,
            onEnd: end.bind(this)
        })

        setPositions()

        function end(e)  {
            let updatedOrder = []
            setPositions()

            const items = e.target.querySelectorAll(".col-item")
            console.log(items)
            items.forEach((item, index) => {
                updatedOrder.push({
                    id: item.dataset.id,
                    position: index + 1
                })
            })
            console.log(this.data.get('url'))
            fetch(this.data.get('url'), {
                method: "PUT",
                headers: {
                    "Content-Type": "application/json",
                    "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
                },
                body: JSON.stringify({ order: updatedOrder }),
            });
        }


        function setPositions() {
            const items = document.querySelectorAll(".col-item")

            items.forEach((item, index) => {
                item.setAttribute('data-pos', index + 1 )
            })
        }
    }
}
