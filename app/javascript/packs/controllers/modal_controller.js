import { Controller } from 'stimulus'

export default class extends Controller {
    static targets = ["name", "brand", "price", "photo"]

    hello() {
        console.log({
            name: this.nameTarget.innerText,
            price: this.priceTarget.innerText,
            brand: this.brandTarget.innerText,
            photo: this.photoTarget.innerText,
        })
    }
}