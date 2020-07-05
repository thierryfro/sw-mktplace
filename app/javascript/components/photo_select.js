const photoPreviews = document.querySelectorAll('.preview');
const mainPhoto = document.querySelector('.main_photo');
const dropDownIcon = document.querySelector('.arrow_down');
const detailsDiv = document.querySelector('.details');

const photoSelector = () => {

  photoPreviews.forEach(photo => {
    photo.addEventListener('click', (event) => {
      mainPhoto.src = event.currentTarget.src;
    });
  })
}

const dropDown = () => {
  if(dropDownIcon) {
    dropDownIcon.addEventListener('click', () => {
      detailsDiv.classList.toggle('details_open')
      detailsDiv.classList.toggle('details')
    })
  }
}

export { photoSelector, dropDown };
