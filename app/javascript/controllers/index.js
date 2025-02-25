// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application);

document.addEventListener("DOMContentLoaded", function() {
  var deleteModal = document.getElementById("deleteModal");
  var confirmDeleteButton = document.getElementById("confirmDeleteButton");

  deleteModal.addEventListener("show.bs.modal", function(event) {
    var button = event.relatedTarget; // The button that triggered the modal
    var propertyId = button.getAttribute("data-property-id"); // Get property ID

    // Update the form action dynamically
    confirmDeleteButton.setAttribute("formaction", "/properties/" + propertyId);
  });
});
