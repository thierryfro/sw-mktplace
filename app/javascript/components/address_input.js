import axios from 'axios'
import places from 'places.js';

const fillFormLocation = (resp) => {
  const { postcode, locale_names, city } = resp
  zipcode_field.value = postcode
  street_field.value = locale_names[0]
  city_field.value = city[0]
}

const fillForm = (resp) => {
  const {
    postcode,
    name,
    city
  } = resp
  street_field.value = name
  zipcode_field.value = postcode
  city_field.value = city
}


const submitForm = () => {
  const searchForm = document.getElementById('address-search')
  searchForm.submit()
}

const callApi = (lat, lng) => {
  const url = `https://places-dsn.algolia.net/1/places/reverse?aroundLatLng=${lat},${lng}&hitsPerPage=1&language=pt`
  axios.get(url)
    .then((resp) => {
      fillFormLocation(resp.data.hits[0])
      submitForm()
    })
}

const buildTemplate = (suggestion) => {
  const {
    name, city
  } = suggestion
  const citySug = city ? `, ${city}` : ""
  return `${name} ${citySug}`;
}

const initLocateButton = () => {
  let button = document.querySelector('#locate-me');

  if (button) {
    /* If the user does a click on the Locate me button, do a reverse query */
    button.addEventListener('click', function (e) {
      e.preventDefault();
      let buttonText = document.querySelector('.location-text');
  
      buttonText.innerText = 'Localizando, aguarde um momento...';
  
      navigator.geolocation.getCurrentPosition((response) => {
        var coords = response.coords;
        var lat = coords.latitude.toFixed(6);
        var lng = coords.longitude.toFixed(6);
        callApi(lat, lng)
      }, (e) => {
        console.log(e)
      },
        { enableHighAccuracy: false, maximumAge: Infinity, timeout: 60000 }
      );
    });
  }
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

    placesAutoComplete.on('change', (resp) => {
      fillForm(resp.suggestion)
      submitForm()
    });

    initLocateButton()
  }

};

export { initAddressInput };



