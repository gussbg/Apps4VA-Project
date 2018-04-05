<%@page import="java.util.*, db.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>SOL Test Scores</title>
        <link href="hw4-sol.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script src="js/divsch.js"></script>
        
    </head>
    <body id="chart">
        <div class ="chartmenu">
            <ul>
          <li><a href="index.html">Home</a></li>
          <li><a href="about.html">About Data</a></li>
          <li class="dropdown">
            <a href="#" class="dropbtn">Charts</a>
            <div class="dropdown-content">
              <a href="chartdetails.html">Chart Details</a>
              <a href="test.jsp">Charts and Graphs</a>
              <a href="scatter.jsp">Scatter Plot</a>
            </div>
          </li>
          <li><a href="team.html">Team</a></li>
        </ul>
        </div>
        <center>
        <br>
        <center>
        <h1>Query</h1>
        <form method="get">
            <p>
                Division:
            </p>
                <select id="div_num" name="div_num" size="10" style = "width: 225px"></select>
                <script>
                    // initialize drop-down lists
                    update_div();
                </script>
                </p>
                <p>
                School Year:
                <select id="sch_year" name="sch_year">
                    <option value="2006">2006</option>
                    <option value="2007">2007</option>
                    <option value="2008">2008</option>
                    <option value="2009">2009</option>
                    <option value="2010">2010</option>
                    <option value="2011">2011</option>
                    <option value="2012">2012</option>
                    <option value="2013">2013</option>
                    <option value="2014">2014</option>
                </select>

                Race:
                <select id="race" name="race">
                    <option value="ALL">ALL</option>
                    <option value="0">Unspecified</option>
                    <option value="1">Indian/Alaska</option>
                    <option value="2">Asian</option>
                    <option value="3">Black</option>
                    <option value="4">Hispanic</option>
                    <option value="5">White</option>
                    <option value="6">Hawaiian</option>
                    <option value="99">2+ Races</option>
                </select>
            </p>
            <p>
                <input type="submit">
            </p>
        </form>

        <%
            // if the form was submitted
            if (request.getParameter("div_num") != null) {
                ScatterQuery squery = new ScatterQuery(request);
                RaceDensityQuery rquery = new RaceDensityQuery(request);
        %>
        <script>
            document.getElementById("div_num").value = "<%= squery.div_num %>";
            document.getElementById("sch_year").value = "<%= squery.sch_year %>";
            document.getElementById("race").value = "<%= squery.race %>";
            document.getElementById("div_num").value = "<%= rquery.div_num %>";
            document.getElementById("sch_num").value = "<%= rquery.sch_num %>";
            document.getElementById("sch_year").value = "<%= rquery.sch_year %>";
            document.getElementById("race").value = "<%= rquery.race %>";
        </script>

        <h1>Chart</h1>
        <%
                    ArrayList<TestDatum> testdata = squery.getData();
                    ArrayList<RacePercentDatum> rdata = rquery.getData();
        %>
        <p>
                Subject:
                <select id="subject" name="subject">
                    <option value="1">ENGR</option>
                    <option value="2">ENGW</option>
                    <option value="3">HIST</option>
                    <option value="4">MATH</option>
                    <option value="5">SCI</option>
                </select>
        </p>
        <p>
            <button type="button" value="click" name="button_dropdown">
        </p>
                
        
        <div id="chart_div1" style="width: 700px; height: 350px;"></div>
        <div id="chart_div2" style="width: 700px; height: 350px;"></div>
        <div id="chart_div3" style="width: 700px; height: 350px;"></div>
        <div id="chart_div4" style="width: 700px; height: 350px;"></div>
        <div id="chart_div5" style="width: 700px; height: 350px;"></div>

        <script type="text/javascript">
             google.charts.load('current', {packages: ['corechart', 'line']});
            google.charts.setOnLoadCallback(drawChart1);
            google.charts.setOnLoadCallback(drawChart2);
            google.charts.setOnLoadCallback(drawChart3);
            google.charts.setOnLoadCallback(drawChart4);
            google.charts.setOnLoadCallback(drawChart5);
            function drawChart1() {
                var data = new google.visualization.DataTable();

                data.addColumn('number', 'Diversity Percentage');
                data.addColumn('number', 'ENGR');
                data.addRows([
            <%
                    TestDatum row;
                    RacePercentDatum rprow;
                    for (int i = 0; i < testdata.size(); i++) { 
                        rprow = rdata.get(i);
                        row = testdata.get(i);
                        if((rprow.getRace()).equals(squery.race))
                            out.print("[" + rprow.getDensity() + ",");
                        
                    }   
                    
            %>
                ]);

                var options = {
                    interpolateNulls: true,
                    hAxis: {
                        title: 'Year'
                    },
                    vAxis: {
                        title: 'Score'
                    },
                };

                var chart1 = new google.visualization.LineChart(document.getElementById('chart_div1'));
                chart1.draw(data, options);
            }
            
            function drawChart2() {
                var data = new google.visualization.DataTable();

                data.addColumn('string', 'sch_year');
                data.addColumn('number', 'ENGW');
                data.addColumn('number', 'ENGW-Average');
                data.addRows([
            <%
               
            %>
                ]);

                var options = {
                    interpolateNulls: true,
                    hAxis: {
                        title: 'Year'
                    },
                    vAxis: {
                        title: 'Score'
                    },
                };

                var chart2 = new google.visualization.LineChart(document.getElementById('chart_div2'));
                chart2.draw(data, options);
            }
            
            function drawChart3() {
                var data = new google.visualization.DataTable();

                data.addColumn('string', 'sch_year');
                data.addColumn('number', 'HIST');
                data.addColumn('number', 'HIST-Average');
                data.addRows([
            <%
                
            %>
                ]);

                var options = {
                    interpolateNulls: true,
                    hAxis: {
                        title: 'Year'
                    },
                    vAxis: {
                        title: 'Score'
                    },
                };

                var chart3 = new google.visualization.LineChart(document.getElementById('chart_div3'));
                chart3.draw(data, options);
            }
            
            function drawChart4() {
                var data = new google.visualization.DataTable();

                data.addColumn('string', 'sch_year');
                data.addColumn('number', 'MATH');
                data.addColumn('number', 'MATH-Average');
                data.addRows([
            <%
               
            %>
                ]);

                var options = {
                    interpolateNulls: true,
                    hAxis: {
                        title: 'Year'
                    },
                    vAxis: {
                        title: 'Score'
                    },
                };

                var chart4 = new google.visualization.LineChart(document.getElementById('chart_div4'));
                chart4.draw(data, options);
            }
            
            function drawChart5() {
                var data = new google.visualization.DataTable();

                data.addColumn('string', 'sch_year');
                data.addColumn('number', 'SCI');
                data.addColumn('number', 'SCI-Average');
                data.addRows([
            <%
                
            %>
                ]);

                var options = {
                    interpolateNulls: true,
                    hAxis: {
                        title: 'Year'
                    },
                    vAxis: {
                        title: 'Score'
                    },
                };

                var chart5 = new google.visualization.LineChart(document.getElementById('chart_div5'));
                chart5.draw(data, options);
            }


        </script>

        <%
            }
        %>            
        </center>
    </body>
</html>

