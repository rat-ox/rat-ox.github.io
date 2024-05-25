document.addEventListener('DOMContentLoaded', function() {
    fetch('urls.json')
        .then(response => response.json())
        .then(data => {
            const tableBody = document.getElementById('url-table-body');
            data.urls.forEach((urlData, index) => {
                const row = document.createElement('tr');
                const numberCell = document.createElement('td');
                numberCell.textContent = index + 1;
                row.appendChild(numberCell);
                
                const urlCell = document.createElement('td');
                const link = document.createElement('a');
                link.href = urlData.url;
                link.textContent = urlData.url;
                urlCell.appendChild(link);
                row.appendChild(urlCell);
                
                const remarkCell = document.createElement('td');
                remarkCell.textContent = urlData.remark;
                row.appendChild(remarkCell);
                
                tableBody.appendChild(row);
            });
        });
});
