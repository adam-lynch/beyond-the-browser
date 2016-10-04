var swiper = new Swiper ('.swiper-container', {
    direction: 'vertical',
    loop: false,
    keyboardControl: true,
    speed: 600,

    // If we need pagination
    //pagination: '.swiper-pagination',

    // Navigation arrows
    //nextButton: '.swiper-button-next',
    //prevButton: '.swiper-button-prev',

    // And if we need scrollbar
    //scrollbar: '.swiper-scrollbar',
});

page('/', '/slide/1');
page('/slide/:nonZeroIndex', function(context){
    swiper.slideTo(parseInt(context.params.nonZeroIndex) - 1);
});
page({ hashbang: true });

swiper.on('onTransitionEnd', function(instance){
    page('/slide/' + ++instance.activeIndex);
});




document.querySelectorAll('code').forEach(function(code){
    hljs.highlightBlock(code);
});




var packageManagersChartCanvas = document.getElementById('packageManagersChart');
new Chart(packageManagersChartCanvas, {
    type: 'bar',
    data: {
        labels: ["CPAN", "GoDoc", "Maven Central", "npm", "nuget", "Packagist", "PyPI", "Rubygems.org"],
        datasets: [
            {
                backgroundColor: "rgba(159, 234, 249, 0.4)",
                borderColor: "#9feaf9",
                borderWidth: 1,
                hoverBackgroundColor: "rgba(159, 234, 249, 0.4)",
                hoverBorderColor: "rgba(159, 234, 249, 1)",
                data: [34297, 128471, 158310, 334290, 64466, 112110, 89975, 123945Updatinh ]
            }
        ]
    },
    options: {
        elements: {
            line: {
                backgroundColor: "#9feaf9",
                borderColor: "#9feaf9",
            }
        },
        legend: {
            display: false,
        },
        scales: {
            xAxes: [{
                gridLines: {
                    color: "#464d72",
                },
                ticks: {
                    beginAtZero: true,
                    fontColor: "#9feaf9",
                    fontFamily: "Roboto",
                }
            }],
            yAxes: [{
                gridLines: {
                    color: "#464d72",
                },
                ticks: {
                    beginAtZero: true,
                    fontColor: "#9feaf9",
                    fontFamily: "Roboto",
                }
            }]
        },
        maintainAspectRatio: false
    }
});