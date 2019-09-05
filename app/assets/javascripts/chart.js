document.addEventListener('turbolinks:load',function(){
    var ctx = document.getElementById("read_chart").getContext('2d');

    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [gon.year_month[5],gon.year_month[4],gon.year_month[3],gon.year_month[2],gon.year_month[1],gon.year_month[0]],
            datasets: [{
                data: [gon.reads[0][1],gon.reads[1][1],gon.reads[2][1],gon.reads[3][1],gon.reads[4][1],gon.reads[5][1]],
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
            text: "読書量グラフ"
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
                    max: gon.max,                  //最大値
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
                left: 50,
                right: 80,
                top: 0,
                bottom: 0
            }
          }
        }
    });
})