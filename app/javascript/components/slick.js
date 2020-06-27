import $ from "jquery";
import "slick-carousel";

const initSlicker = () => {
  const slider = document.getElementById("cart-slider");
  if (slider) {
    $(".slider-wrapper").slick({
      slidesToShow: 3,
      slidesToScroll: 1,
      autoplay: true,
      autoplaySpeed: 2000,
      nextArrow: false,
      prevArrow: false,
      responsive: [
        {
          breakpoint: 1024,
          settings: {
                slidesToShow: 3,
                infinite: true,
          },
        },
        {
          breakpoint: 600,
          settings: {
            slidesToShow: 2,
          },
        },
        {
          breakpoint: 300,
          settings: 1, // destroys slick
        },
      ],
    });
  }
};

export { initSlicker };
