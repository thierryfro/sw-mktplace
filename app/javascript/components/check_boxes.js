const styleCheckBoxes = () => {
  const checkBoxes = document.querySelectorAll(".form_check");
  if (checkBoxes) {
      checkBoxes.forEach(checkbox => {
          checkbox.addEventListener('click', (evt) => {
              checkbox.parentElement.classList.toggle("clicked");
          })
      })
  }
};

const activateToggler = () => {
  const togglers = document.querySelectorAll(".sidebar_toggler");
  if (togglers) {
    togglers.forEach((toggler) => {
      toggler.addEventListener("click", (evt) => {
        toggler.innerText = toggler.innerText === "+" ? "-" : "+";
        toggler.parentElement.classList.toggle("active");
      });
    });
  }
} ;

export { styleCheckBoxes, activateToggler };
