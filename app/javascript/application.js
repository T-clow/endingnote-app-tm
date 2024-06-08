import "@hotwired/turbo-rails";
import "controllers";
import { Turbo } from "@hotwired/turbo-rails";
Turbo.start();

document.addEventListener("turbo:load", function() {
    resetNavbar();
    setupNavbarToggle();
});

function resetNavbar() {
    const navbarCollapse = document.querySelector('.navbar-collapse');
    if (navbarCollapse && navbarCollapse.classList.contains('show')) {
        navbarCollapse.classList.remove('show');
    }
}

function setupNavbarToggle() {
    const navbarToggler = document.querySelector('.navbar-toggler');
    if (navbarToggler) {
        navbarToggler.removeEventListener('click', toggleNavbar);
        navbarToggler.addEventListener('click', toggleNavbar);
    }
}

function toggleNavbar() {
    const navbarCollapse = document.querySelector('.navbar-collapse');
    if (navbarCollapse) {
        navbarCollapse.classList.toggle('show');
    }
}

import { createApp } from "vue";

document.addEventListener("turbo:load", function() {
  const vueAppElement = document.querySelector("#vue-app");
  if (vueAppElement) {
    const App = createApp({
      data() {
        return {
          message: 'Hello Vue'
        }
      }
    });

    App.mount(vueAppElement);
  }
});

import "charts/bar_chart";
import "password_toggle"

