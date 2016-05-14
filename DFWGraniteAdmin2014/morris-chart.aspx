<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="morris-chart.aspx.cs" Inherits="DFWGraniteAdmin2014.morris_chart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <!-- Bootstrap Core CSS -->
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">

    <!-- Morris Charts CSS -->
    <link href="/admin2014/css/plugins/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
    <link href="/admin2014/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->



        <!-- jQuery Version 1.11.0 -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">

                <div class="row">
                    <div class="col-lg-12">
                        <div class="panel panel-green">
                            <div class="panel-heading">
                                <h3 class="panel-title"><i class="fa fa-bar-chart-o"></i> Area Line Graph Example with Tooltips</h3>
                            </div>
                            <div class="panel-body">
                                <div id="morris-area-chart"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /.row -->

        <div class="row">
  <div id="area-example"></div>
  <div id="area-new-table"></div>
    <table id="students">
                     <thead>
        <tr>
            <th>Name</th>
            <th>Age</th>
            <th>Grade</th>
        </tr>
    </thead>
    <tbody>
        <tr class="student">
            <td>2011-10-01</td>
            <td>45</td>
            <td>16.5</td>        
        </tr>
        <tr class="student">
            <td>2011-10-02</td>
            <td>28</td>
            <td>14</td>        
        </tr>
        <tr class="student">
            <td>2011-10-03</td>
            <td>36</td>
            <td>19</td>        
        </tr>
    </tbody>
                  </table>
  </br>
  <button id="run">Create 2nd Chart</button>
<script id="jsbin-javascript">
    /*
     * Load data from Html Table
     *
     * Morris.Js Area Chart
     */
    Morris.Area({
        element: 'area-example',
        data: [{ "name": "2012-10-01", "age": 23 }, { "name": "2012-10-02", "age": 32 }, { "name": "2012-10-03", "age": 21 }],
        xkey: 'name',
        ykeys: ['age'],
        labels: ['Age']
    });

    /*
     * Create 2nd chart
     *
     * Ultimately when then page loads, I would like
     * for the data from the html table to be displayed
     * in the morris area chart...
     * I am using a button for temporary testing.
     * One of the issues is when u click the button, a new chart is added, eventhough you can't see it - i do not want that.
     *
     *
     */

    $('#run').click(function () {

        var data = $('table#students tbody tr').map(function (index) {
            var cols = $(this).find('td');
            return {

                name: cols[0].innerHTML,
                age: (cols[1].innerHTML + '') * 1 // parse int
                //  grade: (cols[2].innerHTML + '') * 1 // parse int
            };
        }).get();
        alert(JSON.stringify(data));
        var xyz = JSON.stringify(data);
        //  alert(xyz);

        Morris.Area({
            element: 'area-new-table',
            data: $.parseJSON(xyz),
            xkey: 'name',
            ykeys: ['age'],
            labels: ['Name']

        });

    });

</script>
        </div>

    </form>

     <!-- Bootstrap Core JavaScript -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

    <!-- Morris Charts JavaScript -->
    <script src="/admin2014/Scripts/plugins/morris/raphael.min.js"></script>
    <script src="/admin2014/Scripts/plugins/morris/morris.min.js"></script>
    <script src="/admin2014/Scripts/plugins/morris/morris-data.js"></script>

    <script>
        /*
 * Load data from Html Table
 *
 * Morris.Js Area Chart
 */

        /*
         * Create 2nd chart
         *
         * Ultimately when then page loads, I would like
         * for the data from the html table to be displayed
         * in the morris area chart...
         * I am using a button for temporary testing.
         * One of the issues is when u click the button, a new chart is added, eventhough you can't see it - i do not want that.
         *
         *
         */



    </script>
</body>
</html>
