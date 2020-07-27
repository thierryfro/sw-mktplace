/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb
import { initAddressInput } from '../components/address_input';
import { initSelect2 } from "../components/init_select2";
import { initFilter } from "../components/filter_toggler";
import { initSlicker } from "../components/slick";
import { initForms } from "../components/init_forms";
import { initAdminForms, initImageSetter } from "../components/admin_forms";
import { initAdminSidebar } from "../components/admin_sidebar";
import { initDatepicker } from "../components/flatpickr";
import { offerFilter } from "./offer_filter";
import { styleCheckBoxes, activateToggler } from "../components/check_boxes";
import { photoSelector } from "../components/photo_select"
import { viewerJS } from '../components/viewer';
import { initSlider } from "../components/init_slider";
import { dropDownDetails, dropDownOptions } from "../components/dropdown";
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Stimulus auto-load
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"
const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))


initAddressInput();
initDatepicker();
initSelect2();
offerFilter();
styleCheckBoxes();
activateToggler();
photoSelector();
viewerJS();
initFilter();
initSlicker();
initSlider();
initImageSetter();
initForms();
initAdminForms();
initAdminSidebar();
dropDownDetails();
dropDownOptions();



$("form").on("cocoon:after-insert", function () {
  /* apply select2 styling */
  initSelect2();
});
