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
                    cursor: 'pointer',
                    point: {
                        events: {
                            click: function () {
                                $('#' + chartId + '-' + this.category.replace(/\s/g, '-') + '-dialog').dialog();
                            }
                        }
                    },
                    pointPadding: 0,
                    groupPadding: 0
                }
            },
            tooltip: {
                enabled: false
            },
            series: [{
                data: $.map(tagData[chartId], function(tag) { return tag.count }),
                showInLegend: false
            }]
        });
    });
    $('tr:nth-child(odd) > td.tag-frequency > div.tag-chart > div.highcharts-container > svg > rect').attr('fill', '#f2f2f2')
});
