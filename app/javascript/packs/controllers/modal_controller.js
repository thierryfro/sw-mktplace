import { Controller } from 'stimulus'

export default class extends Controller {

    static targets = ['name', 'photo', 'price'];

    setContent(data) {
        this.nameTarget.innerText = data.name;
        this.priceTarget.innerText = data.price;
        this.photoTarget.src = data.photo;
    }

    open(data) {
        debugger
        this.setContent(data)
        this.element.classList.add("open");
    }
}