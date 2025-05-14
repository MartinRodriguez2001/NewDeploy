document.addEventListener('turbo:load', function() {
  // Código para manejar notificaciones
  console.log('Script de notificaciones cargado');

  // Animación para las notificaciones no leídas
  const unreadNotifications = document.querySelectorAll('.notification-badge');
  
  unreadNotifications.forEach(badge => {
    badge.classList.add('pulse');
  });

  // Función para actualizar la interfaz cuando se marca como leída
  document.querySelectorAll('[data-notification-action="mark-read"]').forEach(button => {
    button.addEventListener('click', function() {
      const notificationElement = this.closest('.notification-item');
      notificationElement.classList.remove('unread');
      notificationElement.querySelector('.notification-badge')?.remove();
    });
  });
}); 