document.addEventListener('DOMContentLoaded', function() {
  fetch('footer.html')
    .then(response => response.text())
    .then(data => {
      document.getElementById('footer-placeholder').innerHTML = data;

      // Get the last modified time of the files in the same directory
      const scriptPath = document.currentScript.src;
      const scriptDirectory = scriptPath.substring(0, scriptPath.lastIndexOf('/'));

      fetch(scriptDirectory)
        .then(response => response.text())
        .then(directoryListing => {
          const parser = new DOMParser();
          const doc = parser.parseFromString(directoryListing, 'text/html');
          const fileEntries = Array.from(doc.querySelectorAll('pre'));

          let latestModified = new Date(0);
          fileEntries.forEach(entry => {
            const match = entry.textContent.match(/(\d{4}-\d{2}-\d{2} \d{2}:\d{2})/);
            if (match) {
              const fileModifiedTime = new Date(match[1]);
              if (fileModifiedTime > latestModified) {
                latestModified = fileModifiedTime;
              }
            }
          });

          const timestampElement = document.createElement('div');
          timestampElement.textContent = `Last updated: ${latestModified.toLocaleString()}`;
          document.getElementById('footer-placeholder').appendChild(timestampElement);
        })
        .catch(error => console.error('Error fetching directory listing:', error));
    });
});
