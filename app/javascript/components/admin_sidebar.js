const initAdminSidebar = () => {
    const adminSidebar = document.querySelector('.admin-sidebar')
    if (adminSidebar) {
        const toggler = document.querySelector('.navbar_toggler')
        toggler.addEventListener('click', () => {
            adminSidebar.classList.toggle('toggled')
        })
    }
}

export { initAdminSidebar }