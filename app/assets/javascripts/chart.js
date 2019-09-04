document.addEventListener('turbolinks:load',function(){
  var ctx = document.getElementById("myChart").getContext('2d');
  var myChart = new Chart(ctx, {
      type: 'line',
      data: {
          labels: ["19年3月","4月","5月","6月","7月"],
          datasets: [{
              data: [1,2,10,0,5],
              backgroundColor: 'rgba(255, 99, 132, 0.7)',
              borderColor: 'rgba(255, 50, 132, 0.9)',
              fill: true
          }]
      },
      options: {
        responsive: true,
        legend: {
          display: false
        },
        title:  {
          display: true,
          fontSize: 18,
          text: "読書グラフ"
        },
        scales: {                          //軸設定
          yAxes: [{                      //y軸設定
              display: true,             //表示設定
              scaleLabel: {              //軸ラベル設定
                 display: false,          //表示設定
                 labelString: '縦軸ラベル',  //ラベル
                 fontSize: 18               //フォントサイズ
              },
              ticks: {                      //最大値最小値設定
                  min: 0,                   //最小値
                  max: 10,                  //最大値
                  fontSize: 18,             //フォントサイズ
                  stepSize: 5               //軸間隔
              },
          }],
          xAxes: [{                         //x軸設定
              display: true,                //表示設定
              barPercentage: 0.4,           //棒グラフ幅
              categoryPercentage: 0.4,      //棒グラフ幅
              scaleLabel: {                 //軸ラベル設定
                 display: false,             //表示設定
                 labelString: '横軸ラベル',  //ラベル
                 fontSize: 18               //フォントサイズ
              },
              ticks: {
                  fontSize: 18             //フォントサイズ
              },
          }],
        },
        layout: {                             //レイアウト
          padding: {                          //余白設定
              left: 100,
              right: 50,
              top: 0,
              bottom: 0
          }
        }
      }
  });
})