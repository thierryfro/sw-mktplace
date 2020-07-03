import { Controller } from 'stimulus'

export default class extends Controller {

    static targets = ['name', 'photo', 'price', 'store'];

    setContent(data) {
        this.nameTarget.innerText = data.name;
        this.priceTarget.innerText = data.price;
        this.photoTarget.src = data.photo;
        // this.storeTarget.href = data.store;
    }

    launchModal(data) {
        this.setContent(data)
        this.element.classList.add("open");
    }
}