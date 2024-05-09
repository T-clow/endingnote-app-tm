import { Chart, BarController, BarElement, CategoryScale, LinearScale, Title } from "chart.js";

Chart.register(BarController, BarElement, CategoryScale, LinearScale, Title);

document.addEventListener("turbo:load", () => {
  const canvas = document.getElementById('myBarChart');
  if (canvas) {
    const ctx = canvas.getContext('2d');

    const ageLabels = Array.from({ length: 71 }, (_, i) => `${i + 30}`);

    const insuranceAmounts = ageLabels.map(age => {
      const ageNumber = parseInt(age, 10);
      return ageNumber <= 60 ? 8000 : 1000;
    });

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
          max: 8000,
          title: {
            display: true,
            text: '保険金額（万円）'
          },
          ticks: {
            callback: (value) => `${value} 万円`
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

    new Chart(ctx, {
      type: 'bar',
      data: data,
      options: options
    });
  }
});
