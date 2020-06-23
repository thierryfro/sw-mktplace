const initFilter = () => {
  const filter = document.querySelector(".content .filter");
  if (filter) {
    const sidebar = document.querySelector(".content .sidebar");
    filter.addEventListener("click", () => {
        sidebar.classList.toggle('toggled')
        filter.classList.toggle("toggled");
    });
  }
};

export { initFilter };
