document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".toggle").forEach(toggle => {
        toggle.addEventListener("click", (event) => {
            event.preventDefault();
            const targetId = toggle.getAttribute("data-target");
            const targetElement = document.getElementById(targetId);
            if (targetElement) {
                targetElement.classList.toggle("hidden");
            }
        });
    });
});
