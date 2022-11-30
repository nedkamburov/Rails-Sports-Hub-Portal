import {Controller} from "@hotwired/stimulus";
import toastr from "toastr";

export default class extends Controller {
    connect() {
        let type = this.element.dataset.flashType;
        let message = this.element.dataset.flashMessage;

        toastr[type](message, '',
            {"closeButton": true,
            "positionClass": "toast-top-right",
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "progressBar": true,
            "hideMethod": "fadeOut" });
    }
}