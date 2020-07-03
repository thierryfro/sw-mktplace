import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["name", "brand", "price", "photo", "modal", "store"]


    initModal() {
        debugger    
        const data = {
            store: this.storeTarget.dataset.link,
            storeName: this.storeTarget.dataset.name,
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