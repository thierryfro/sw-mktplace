const restartToggler = (toggler) => {
    toggler.classList.remove("toggled")
    const new_toggler = toggler.cloneNode(true);
    toggler.parentNode.replaceChild(new_toggler, toggler);
    enableForm(new_toggler)
}

const disableForm = (currentForm) => {
    currentForm
        .querySelectorAll(".form_input , .form_input-larger")
        .forEach((form) => {
            form.disabled = true
        })
}

const setToggler = (toggler, currentForm) => {
    toggler.classList.add("toggled")
    toggler.addEventListener("click", () => {
        Rails.fire(currentForm, "submit");
        disableForm(currentForm);
        restartToggler(toggler);
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