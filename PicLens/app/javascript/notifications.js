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
}); 