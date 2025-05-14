import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = ["input", "container"]
  
  connect() {
    this.subscribeToChannel()
    this.scrollToBottom()
  }
  
  disconnect() {
    if (this.subscription) {
      this.subscription.unsubscribe()
    }
  }
  
  subscribeToChannel() {
    const userId = window.location.pathname.split('/').pop()
    this.subscription = consumer.subscriptions.create(
      { channel: "DirectMessageChannel", user_id: userId },
      { received: this.handleMessage.bind(this) }
    )
  }
  
  handleMessage(data) {
    const messageHtml = this.buildMessageHtml(data)
    this.containerTarget.insertAdjacentHTML('beforeend', messageHtml)
    this.scrollToBottom()
  }
  
  buildMessageHtml(data) {
    const isSent = data.sender_id === this.currentUserId
    return `
      <div class="message ${isSent ? 'sent' : 'received'}">
        <div class="message-content">
          ${data.content}
          <small class="text-muted">
            ${this.formatTime(data.created_at)}
          </small>
        </div>
      </div>
    `
  }
  
  formatTime(timestamp) {
    const date = new Date(timestamp)
    return date.toLocaleTimeString()
  }
  
  scrollToBottom() {
    this.containerTarget.scrollTop = this.containerTarget.scrollHeight
  }
  
  submit(event) {
    event.preventDefault()
    const form = event.target
    const formData = new FormData(form)
    
    fetch(form.action, {
      method: 'POST',
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'application/json'
      }
    }).then(response => {
      if (response.ok) {
        this.inputTarget.value = ''
      }
    })
  }
  
  get currentUserId() {
    return document.querySelector('meta[name="current-user-id"]').content
  }
} 