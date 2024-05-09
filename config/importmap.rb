pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "video_validation", to: "video_validation.js"
pin "map"
pin "vue", to: "https://cdn.jsdelivr.net/npm/vue@3.2.41/dist/vue.esm-browser.js"
pin "chart.js" # @4.4.2
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.2
pin "charts/bar_chart", to: "charts/bar_chart.js"
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.3.0/dist/chart.js"

