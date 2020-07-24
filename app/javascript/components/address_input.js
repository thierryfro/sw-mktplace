import places from 'places.js';

const submitForm = () => {
  const searchForm = document.getElementById('adress-search')
  searchForm.submit()
}

const buildTemplate = (suggestion) => {
  const {
    name, city
  } = suggestion
  const citySug = city ? `, ${city}` : ""
  return `${name} ${citySug}`;
}

const initLocateButton = (addressInput) => {
  let button = document.querySelector('#locate-me');

  /* If the user does a click on the Locate me button, do a reverse query */
  button.addEventListener('click', function (e) {
    e.preventDefault();
    let buttonText = document.querySelector('.location-text');

    buttonText.innerText = 'Localizando...';

    navigator.geolocation.getCurrentPosition((response) => {
      var coords = response.coords;
      var lat = coords.latitude.toFixed(6);
      var lng = coords.longitude.toFixed(6);
      alert(`${lat}, ${lng}`)
    }, (e) => {
      console.log(e)
    },
      { timeout: 100 });
  });
}

const initAddressInput = () => {
  const addressInput = document.getElementById('new_address');
  if (addressInput) {
    const placesAutoComplete = places({
      container: addressInput,
      language: 'pt', // Receives results in German
      countries: ['br'],
      templates: {
        value: function (suggestion) {
          return buildTemplate(suggestion);
        },
        suggestion: function (suggestion) {
          return buildTemplate(suggestion);
        }
      }
    });

    placesAutoComplete.on('change', (e) => {
      const {
        postcode,
        name,
        city
      } = e.suggestion
      street_field.value = name
      zipcode_field.value = postcode
      city_field.value = city
      submitForm()
    });

    initLocateButton(addressInput)
  }

};

export { initAddressInput };