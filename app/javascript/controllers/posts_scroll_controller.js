import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["list", "pagination"]

  connect() {
    this.loading = false
    window.addEventListener("scroll", this.loadMore.bind(this))
  }

  disconnect() {
    window.removeEventListener("scroll", this.loadMore.bind(this))
  }

  loadMore() {
    if (this.loading) return
    const nextPage = this.paginationTarget?.querySelector("a[rel='next']")
    if (!nextPage) return
    const scrollPosition = window.innerHeight + window.scrollY
    const threshold = document.body.offsetHeight - 300
    if (scrollPosition >= threshold) {
      this.loading = true
      fetch(nextPage.href, { headers: { Accept: "text/vnd.turbo-stream.html" } })
        .then(response => response.text())
        .then(html => {
          this.listTarget.insertAdjacentHTML("beforeend", html)
          this.loading = false
        })
    }
  }
} 