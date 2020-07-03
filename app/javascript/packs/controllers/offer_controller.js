import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["name", "brand", "price", "photo", "modal", "store"]

    setModalData() {
        return {
            store: this.storeTarget.dataset.link,
            storeName: this.storeTarget.dataset.name,
            name: this.nameTarget.innerText,
            price: this.priceTarget.innerText,
            brand: this.brandTarget.innerText,
            photo: this.photoTarget.src,
        }
    }

    initModal() {
        const data = this.setModalData()
        const modalController = this.application.getControllerForElementAndIdentifier(
            document.getElementById("offer-modal"),
            "modal"
        );
        modalController.launchModal(data)
    }

}