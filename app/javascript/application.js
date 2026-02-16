// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  document.querySelectorAll("tr[data-href]").forEach(row => {
    row.addEventListener("click", () => {
      window.location = row.dataset.href
    })
  })
})
