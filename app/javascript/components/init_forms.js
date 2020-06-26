const disableForm = (currentForm) => {
    currentForm
        .querySelectorAll(".form_input , .form_input-larger")
        .forEach((form) => {
            enableForm(form)
            form.disabled = true
        })
}

const setToggler = (toggler, currentForm) => {
    toggler.classList.add = "toggled"
    toggler.addEventListener("click", () => {
        Rails.fire(currentForm, "submit");
        disableForm(currentForm)
    })
}

const enableForm = (toggler) => {
    const currentForm = document.getElementById(toggler.dataset.offer)
    toggler.addEventListener('click', () => {
        currentForm
            .querySelectorAll(".form_input , .form_input-larger")
            .forEach((form) => {
                form.disabled = false
            })
    })
    setToggler(toggler, currentForm)
}

const initForms = () => {
    const togglers = document.querySelectorAll('.form-toggler')
    if (togglers) {
        togglers.forEach((toggler) => {
            enableForm(toggler);
        })
    }
}

export { initForms }