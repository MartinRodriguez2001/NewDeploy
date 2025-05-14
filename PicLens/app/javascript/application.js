// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import "@popperjs/core"
// import "bootstrap-icons/font/bootstrap-icons.css"
import "./notifications"

// Inicializar los dropdowns de Bootstrap después de cada navegación
document.addEventListener('turbo:load', function() {
  // Inicializar todos los dropdowns
  var dropdownElementList = [].slice.call(document.querySelectorAll('.dropdown-toggle'))
  var dropdownList = dropdownElementList.map(function (dropdownToggleEl) {
    return new bootstrap.Dropdown(dropdownToggleEl)
  })
});
