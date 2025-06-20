import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "input", "messages"]

  connect() {
    console.log("Chat controller connected")
    this.scrollToBottom()
    
    if (this.hasFormTarget) {
      this.formTarget.addEventListener('ajax:success', this.handleSuccess.bind(this))
    }
  }
  
  scrollToBottom() {
    if (this.hasMessagesTarget) {
      this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight
    }
  }
  
  handleSuccess(event) {
    if (this.hasInputTarget) {
      this.inputTarget.value = ''
      this.inputTarget.focus()
    }
    
    setTimeout(() => {
      this.scrollToBottom()
    }, 100)
  }
}