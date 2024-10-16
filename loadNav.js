function loadNav() {
    fetch('nav.html')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(data => {
            document.getElementById('nav-placeholder').innerHTML = data;
        })
        .catch(error => {
            console.error('Error loading nav.html:', error);
            document.getElementById('nav-placeholder').innerHTML = '<p>Error loading navigation menu.</p>';
        });
}

document.addEventListener('DOMContentLoaded', loadNav);
