document.addEventListener('DOMContentLoaded', function () {
  function togglePasswordVisibility(passwordFieldId, iconId) {
    const passwordField = document.getElementById(passwordFieldId);
    const passwordIcon = document.getElementById(iconId);
    const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordField.setAttribute('type', type);
    passwordIcon.classList.toggle('fa-eye');
    passwordIcon.classList.toggle('fa-eye-slash');
  }

  document.getElementById('toggle-password-1').addEventListener('click', function () {
    togglePasswordVisibility('password-1', 'password-icon-1');
  });

  document.getElementById('toggle-password-2').addEventListener('click', function () {
    togglePasswordVisibility('password-2', 'password-icon-2');
  });

  document.getElementById('toggle-password-3').addEventListener('click', function () {
    togglePasswordVisibility('password-3', 'password-icon-3');
  });
});
