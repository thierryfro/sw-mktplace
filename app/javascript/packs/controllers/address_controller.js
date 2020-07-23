import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['modal'];

  closeModal() {
    this.modalTarget.classList.remove("open");
  }

  launchModal() {
    this.modalTarget.classList.add("open");
  }
}