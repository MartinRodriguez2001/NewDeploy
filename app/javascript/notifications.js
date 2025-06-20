document.addEventListener('turbo:load', function() {
  console.log('Script de notificaciones cargado');

  const unreadNotifications = document.querySelectorAll('.notification-badge');
  
  unreadNotifications.forEach(badge => {
    badge.classList.add('pulse');
  });

  document.querySelectorAll('[data-notification-action="mark-read"]').forEach(button => {
    button.addEventListener('click', function() {
      const notificationElement = this.closest('.notification-item');
      notificationElement.classList.remove('unread');
      notificationElement.querySelector('.notification-badge')?.remove();
    });
  });
  
  var dropdownElementList = document.querySelectorAll('.dropdown-toggle');
  var dropdownList = Array.from(dropdownElementList).map(function(element) {
    return new bootstrap.Dropdown(element);
  });
  var notificationsDropdown = document.getElementById('notificationsDropdown');
  if (notificationsDropdown) {
    notificationsDropdown.addEventListener('click', function(e) {
      e.preventDefault();
      e.stopPropagation();
      
      var dropdownInstance = bootstrap.Dropdown.getInstance(notificationsDropdown);
      if (!dropdownInstance) {
        dropdownInstance = new bootstrap.Dropdown(notificationsDropdown);
      }
      
      dropdownInstance.toggle();
    });
    var notificationItems = document.querySelectorAll('.notification-item');
    notificationItems.forEach(function(item) {
      item.addEventListener('click', function(e) {
        e.stopPropagation();
      });
    });
  }
}); 