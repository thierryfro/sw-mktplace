import flatpickr from "flatpickr";
import "flatpickr/dist/themes/material_red.css";

const initDatepicker = () => {
    const datepicker = document.querySelector('.datepicker')
    if (datepicker) {
        flatpickr(".datepicker", {
            enableTime: false,
            dateFormat: "d/m/Y",
            defaultDate: datepicker.dataset.birthdate
        });
    }
}

export { initDatepicker }