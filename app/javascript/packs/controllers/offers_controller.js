import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["name", "brand", "price", "photo", "modal"]


    initModal() {
        const data = {
            name: this.nameTarget.innerText,
            price: this.priceTarget.innerText,
            brand: this.brandTarget.innerText,
            photo: this.photoTarget.src,
        }
        const modalController = this.application.getControllerForElementAndIdentifier(
            this.modalTarget,
            "modal"
        );
        modalController.open(data)
    }
}