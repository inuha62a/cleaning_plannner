document.addEventListener("DOMContentLoaded", function () {
    const checkbox = document.getElementById("show-password-checkbox");
    const password = document.getElementById("password");
    const confirmation = document.getElementById("password_confirmation");
  
    checkbox.addEventListener("change", function () {
      const type = checkbox.checked ? "text" : "password";
      if (password) password.type = type;
      if (confirmation) confirmation.type = type;
    });
  });
  