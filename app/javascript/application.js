import "@hotwired/turbo-rails"
import "controllers"
import "map";
import { Turbo } from "@hotwired/turbo-rails"

Turbo.start()

document.addEventListener("turbo:load", function() {
    resetNavbar();
    setupNavbarToggle();
});

function resetNavbar() {
    const navbarCollapse = document.querySelector('.navbar-collapse');
    if (navbarCollapse.classList.contains('show')) {
        navbarCollapse.classList.remove('show');
    }
}

function setupNavbarToggle() {
    const navbarToggler = document.querySelector('.navbar-toggler');
    navbarToggler.removeEventListener('click', toggleNavbar);
    navbarToggler.addEventListener('click', toggleNavbar);
}

function toggleNavbar() {
    const navbarCollapse = document.querySelector('.navbar-collapse');
    navbarCollapse.classList.toggle('show');
}

import { createApp } from "vue";
import * as Controllers from "controllers/application";

document.addEventListener("turbo:load", function() {
  const App = createApp({
    data() {
      return {
        message: 'Hello Vue'
      }
    }
  });

  App.mount("#vue-app");
});
