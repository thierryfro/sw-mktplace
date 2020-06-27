import flatpickr from "flatpickr";


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