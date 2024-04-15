import "@hotwired/turbo-rails"
import "controllers"
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
