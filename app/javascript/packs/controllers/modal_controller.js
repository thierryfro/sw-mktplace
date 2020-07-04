import { Controller } from 'stimulus'

export default class extends Controller {

    static targets = ['name', 'photo', 'price', 'store', 'items'];

    calcPrice(data) {
        const totalCart = parseInt(this.priceTarget.dataset.subtotal) + parseInt(data.price)
        return `R$ ${totalCart.toFixed(2)}`
    }

    countItems() {
        const totalItems = parseInt(this.itemsTarget.dataset.items) + 1
        return `${totalItems} ${totalItems > 1 ? 'items' : 'item' }`
    }

    setContent(data) {
        this.nameTarget.innerText = data.name;
        this.priceTarget.innerText = this.calcPrice(data);
        this.itemsTarget.innerText = this.countItems();
        this.photoTarget.src = data.photo;
        // this.storeTarget.href = data.store;
    }

    launchModal(data) {
        this.setContent(data)
        this.element.classList.add("open");
    }
}