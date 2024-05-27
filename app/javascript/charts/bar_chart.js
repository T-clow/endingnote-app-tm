import { Chart, BarController, BarElement, CategoryScale, LinearScale, Title } from "chart.js";

Chart.register(BarController, BarElement, CategoryScale, LinearScale, Title);

document.addEventListener("turbo:load", () => {
  const chartContainer = document.querySelector('.chart-container');
  if (chartContainer) {
    const currentAge = parseInt(chartContainer.getAttribute('data-age'), 10);
    const insuranceAmounts = JSON.parse(chartContainer.getAttribute('data-insurance-amounts'));

    const canvas = document.getElementById('myBarChart');
    if (canvas) {
      const ctx = canvas.getContext('2d');

      const ageLabels = Array.from({ length: 101 - currentAge }, (_, i) => `${i + currentAge}`);

      const data = {
        labels: ageLabels,
        datasets: [{
          label: '保険金額',
          data: insuranceAmounts,
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1
        }]
      };

      const options = {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          title: {
            display: true,
            text: '年齢ごとの保険金額'
          }
        },
        scales: {
          y: {
            beginAtZero: true,
            title: {
              display: true,
              text: '保険金額（円）'
            },
            ticks: {
              callback: (value) => `${value / 10000}万`
            }
          },
          x: {
            title: {
              display: true,
              text: '年齢'
            },
            ticks: {
              maxRotation: 90,
              minRotation: 45,
              font: {
                size: 10
              }
            }
          }
        }
      };

      if (insuranceAmounts.every(amount => amount === 0)) {
        data.labels = ['0'];
        data.datasets[0].data = [0];
        options.scales.y.ticks.callback = (value) => `${value}`;
        options.scales.x.title.text = '';
        options.plugins.title.text = '保険契約がありません';
      }

      new Chart(ctx, {
        type: 'bar',
        data: data,
        options: options
      });
    }
  } else {
    console.warn('Chart container not found');
  }
});
