const disableForm = (currentForm, toggler) => {
    currentForm
        .querySelectorAll(".form_input , .form_input-larger")
        .forEach((form) => {
            form.disabled = true
            toggler.classList.remove("toggled")
            enableForm(toggler)
        })
}

const setToggler = (toggler, currentForm) => {
    toggler.classList.add("toggled")
    toggler.addEventListener("click", () => {
        Rails.fire(currentForm, "submit");
        disableForm(currentForm, toggler)
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
        setToggler(toggler, currentForm)
    })
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