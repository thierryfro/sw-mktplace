import places from 'places.js';

const submitForm = () => {
  const searchForm = document.getElementById('banner-search')
  searchForm.submit()
}

const buildTemplate = (suggestion) => {
  const {
    name, city
  } = suggestion
  const citySug = city ? `, ${city}` : ""
  return `${name} ${citySug}`;
}

const initAddressInput = () => {
  const addressInput = document.getElementById('new_address');
  if (addressInput) {
    const placesAutoComplete = places({
      container: addressInput,
      language: 'pt', // Receives results in German
      countries: ['br'],
      templates: {
        value: function(suggestion) {
          return buildTemplate(suggestion);
        },
        suggestion: function(suggestion) {
          return buildTemplate(suggestion);
        }
      }
    });

    placesAutoComplete.on('change', (e) => {
      const {
        postcode,
        name,
        city,
        hit: {
          vilage, locale_names
        }
      } = e.suggestion
      street_field.value = name
      zipcode_field.value = postcode
      debugger
      submitForm()
    });
  }

};

export { initAddressInput };