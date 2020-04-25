import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2:last-of-type').select2();
};

export { initSelect2 };
