const dropDownIcon = document.querySelector('.arrow_down');
const detailsDiv = document.querySelector('.details');

const arrowSize = document.querySelector('.arrow_size');
const arrowFlavour = document.querySelector('.arrow_flavour');

const sizeDiv = document.querySelector('.size_div');
const flavourDiv = document.querySelector('.flavour_div');




const dropDownDetails = () => {
  if(dropDownIcon) {
    dropDownIcon.addEventListener('click', () => {
      detailsDiv.classList.toggle('details_open')
      detailsDiv.classList.toggle('details')
    })
  }
}

const dropDownOptions = () => {
  if(arrowSize || arrowFlavour) {
    arrowSize.addEventListener('click', () => {
      sizeDiv.classList.toggle('hide_size_div');
    })

    arrowFlavour.addEventListener('click', () => {
      flavourDiv.classList.toggle('hide_flavour_div');
    })
  }
}


export { dropDownDetails, dropDownOptions };
