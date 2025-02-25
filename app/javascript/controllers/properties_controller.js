import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  delete(event) {
    event.preventDefault(); // Prevent default form submission

    if (confirm("Are you sure you want to delete this property?")) {
      event.target.closest("form").submit(); // Manually submit the form
    }
  }
}
