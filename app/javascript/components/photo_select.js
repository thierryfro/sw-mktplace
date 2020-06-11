const photoPreviews = document.querySelectorAll('.preview');
const mainPhoto = document.querySelector('.main_photo');


const photoSelector = () => {

  photoPreviews.forEach(photo => {
    photo.addEventListener('click', (event) => {

      mainPhoto.src = event.currentTarget.src;

    });
  })
}


export { photoSelector };
