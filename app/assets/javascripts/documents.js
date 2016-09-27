$(document).ready(function(){
    $.each($('.tag-chart'), function(){
        var $chart = $(this);
        var chartId = $chart.attr('tag-data-id');

        $chart.highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: null
            },
            xAxis: {
                categories: $.map(tagData[chartId], function(tag) { return tag.label })
            },
            yAxis: {
                visible: false
            },
            plotOptions: {
                series: {
                    dataLabels: {
                        enabled: true
                    },
                    pointPadding: 0,
                    groupPadding: 0
                }
            },
            series: [{
                data: $.map(tagData[chartId], function(tag) { return tag.count }),
                showInLegend: false
            }]
        });
    });
});
