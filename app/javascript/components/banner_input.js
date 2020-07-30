
const bannerInput = () => {
  const bannerElem = document.querySelector("#banner-search");
  if (bannerElem) {
    bannerElem.addEventListener("click", () => {
      window.location.replace("/offers");
    })
  }
}

export { bannerInput };
