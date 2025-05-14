import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["list", "counter", "dropdown"]

  connect() {
    this.subscribeToNotifications()
  }

  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
  }

  subscribeToNotifications() {
    this.subscription = consumer.subscriptions.create("NotificationsChannel", {
      received: this.handleNotification.bind(this)
    })
  }

  handleNotification(data) {
    this.updateNotificationCounter()
    this.addNotificationToList(data)
    this.showNotificationToast(data)
  }

  updateNotificationCounter() {
    if (this.hasCounterTarget) {
      const currentCount = parseInt(this.counterTarget.textContent) || 0
      this.counterTarget.textContent = currentCount + 1
      this.counterTarget.classList.remove("d-none")
    }
  }

  addNotificationToList(data) {
    if (this.hasListTarget) {
      const notificationHtml = this.buildNotificationHtml(data)
      this.listTarget.insertAdjacentHTML("afterbegin", notificationHtml)
    }
  }

  showNotificationToast(data) {
    const toast = new bootstrap.Toast(this.buildToastElement(data))
    toast.show()
  }

  buildNotificationHtml(data) {
    return `
      <div class="dropdown-item notification-item ${data.read ? '' : 'unread'}" data-notification-id="${data.id}">
        <div class="d-flex align-items-center">
          <div class="flex-grow-1">
            <p class="mb-1">${data.message}</p>
            <small class="text-muted">${this.formatTime(data.created_at)}</small>
          </div>
          ${!data.read ? '<div class="notification-badge ms-2"></div>' : ''}
        </div>
      </div>
    `
  }

  buildToastElement(data) {
    const toastContainer = document.createElement('div')
    toastContainer.className = 'toast-container position-fixed bottom-0 end-0 p-3'
    toastContainer.innerHTML = `
      <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header">
          <strong class="me-auto">Nueva notificación</strong>
          <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
        <div class="toast-body">
          ${data.message}
        </div>
      </div>
    `
    document.body.appendChild(toastContainer)
    return toastContainer.querySelector('.toast')
  }

  formatTime(timestamp) {
    const date = new Date(timestamp)
    return date.toLocaleTimeString()
  }

  markAsRead(event) {
    const notificationId = event.currentTarget.dataset.notificationId
    fetch(`/notifications/${notificationId}/mark_as_read`, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'application/json'
      }
    }).then(response => {
      if (response.ok) {
        event.currentTarget.classList.remove('unread')
        const badge = event.currentTarget.querySelector('.notification-badge')
        if (badge) badge.remove()
      }
    })
  }
} 