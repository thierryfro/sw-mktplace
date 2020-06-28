import noUiSlider from "nouislider";
import wNumb from "wnumb";
import "nouislider/distribute/nouislider.css";

const checkMarkers = (limit, status) => (status === 0 ? limit : status);

const initSlider = () => {
  const formSlider = document.getElementById("form-slider");
  if (formSlider) {

    const [{ start, end, current_start, current_end }] = JSON.parse(
      formSlider.dataset.values
    );

    const currentStart = checkMarkers(start, current_start);
    const currentEnd = checkMarkers(end, current_end);
    if (formSlider) {
      var slider = noUiSlider.create(formSlider, {
        start: [currentStart, currentEnd],
        connect: true,
        tooltips: [true, true],
        range: {
          min: start,
          max: end,
        },
        format: wNumb({
          decimals: 2,
          thousand: ".",
          prefix: "R$",
        }),
      });

      const sidebarForm = document.querySelector("#sidebar_form");
      slider.on("change", function () {
        document
          .getElementById("sliderValueInput")
          .setAttribute("value", slider.get());
        Rails.fire(sidebarForm, "submit");
      });
    }
  }
};

export { initSlider };
