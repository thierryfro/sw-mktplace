const disableForm = (currentForm, toggler) => {
    currentForm
        .querySelectorAll(".form_input")
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