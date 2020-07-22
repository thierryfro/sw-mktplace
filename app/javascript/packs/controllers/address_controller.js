import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = [];

  connect() {
    console.log('oi')
  }

  closeModal() {
    this.element.classList.remove("open");
  }

  launchModal() {
    this.element.classList.add("open");
  }
}