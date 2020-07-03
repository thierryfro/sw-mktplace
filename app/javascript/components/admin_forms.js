const restartToggler = (toggler) => {
    toggler.classList.remove("toggled")
    const new_toggler = toggler.cloneNode(true);
    toggler.parentNode.replaceChild(new_toggler, toggler);
    enableForm(new_toggler)
}

const disableForm = (currentForm, toggler) => {
    currentForm
        .querySelectorAll(".form_input")
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
    const currentForm = document.getElementById(toggler.dataset.form)
    toggler.addEventListener('click', () => {
        currentForm
            .querySelectorAll(".form_input")
            .forEach((form) => {
                form.disabled = false
            })
        setToggler(toggler, currentForm)
    })
}

const initAdminForms = () => {
    const togglers = document.querySelectorAll('.form-info-toggler')
    if (togglers) {
        togglers.forEach((toggler) => {
            enableForm(toggler);
        })
    }
}

const initImageSetter = () => {
    const imgSetter = document.querySelector('#image-setter')
    if (imgSetter) {
        imgSetter.addEventListener("click", () => {
            document.querySelector('#user_photo').click()
        })
    }
}

export { initAdminForms, initImageSetter }