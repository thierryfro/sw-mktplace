import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['modal'];

  getLocation() {
    let currentAddress = navigator
      .geolocation
      .getCurrentPosition((e) => {
        console.log(e)
        let {latitude, longitude} = e.coords
        debugger
      })
  }

  closeModal() {
    this.modalTarget.classList.remove("open");
  }

  launchModal() {
    this.modalTarget.classList.add("open");
  }
}