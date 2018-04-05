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
                <li><a class="active" href="index.html">Home</a></li>
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
        <br>
    <center>
        <h1>Query</h1>
        <form method="get">
            <p>
                Division and School:
            </p>
                <select id="div_num" name="div_num" size="10" onchange="update_sch();" style = "width: 225px"></select>
                <select id="sch_num" name="sch_num" size="10" style = "width: 225px"></select>
                <script>
                    // initialize drop-down lists
                    update_div();
                    update_sch();
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
                Gender:
                <select id="gender" name="gender">
                    <option value="ALL">ALL</option>
                    <option value="F">Female</option>
                    <option value="M">Male</option>
                </select>
            </p>
            <p>
                Disability:
                <select id="disabil" name="disabil">
                    <option value="ALL">ALL</option>
                    <option value="Y">Yes</option>
                    <option value="N">No</option>
                </select>
                LEP:
                <select id="lep" name="lep">
                    <option value="ALL">ALL</option>
                    <option value="Y">Yes</option>
                    <option value="N">No</option>
                </select>
                Disadvantaged:
                <select id="disadva" name="disadva">
                    <option value="ALL">ALL</option>
                    <option value="Y">Yes</option>
                    <option value="N">No</option>
                </select>
            </p>
            <p>
                <input type="submit">
            </p>

        </form>

        <%
            // if the form was submitted
            if (request.getParameter("div_num") != null) {
                Query query = new Query(request);
                QueryAll queryall = new QueryAll(request);
                RaceDensityQuery rquery = new RaceDensityQuery(request);
        %>
        <script>
            document.getElementById("div_num").value = "<%= queryall.div_num%>";
            document.getElementById("sch_num").value = "<%= queryall.sch_num%>";
            document.getElementById("sch_year").value = "<%= queryall.sch_year%>";
            document.getElementById("race").value = "<%= queryall.race%>";
            document.getElementById("gender").value = "<%= queryall.gender%>";
            document.getElementById("disabil").value = "<%= queryall.disabil%>";
            document.getElementById("lep").value = "<%= queryall.lep%>";
            document.getElementById("disadva").value = "<%= queryall.disadva%>";
            document.getElementById("div_num").value = "<%= query.div_num%>";
            document.getElementById("sch_num").value = "<%= query.sch_num%>";
            document.getElementById("sch_year").value = "<%= query.sch_year%>";
            document.getElementById("race").value = "<%= query.race%>";
            document.getElementById("gender").value = "<%= query.gender%>";
            document.getElementById("disabil").value = "<%= query.disabil%>";
            document.getElementById("lep").value = "<%= query.lep%>";
            document.getElementById("disadva").value = "<%= query.disadva%>";
            document.getElementById("div_num").value = "<%= rquery.div_num%>";
            document.getElementById("sch_num").value = "<%= rquery.sch_num%>";
            document.getElementById("sch_year").value = "<%= rquery.sch_year%>";
            document.getElementById("grade_num").value = "<%= rquery.grade_num%>";
            document.getElementById("race").value = "<%= rquery.race%>";
            document.getElementById("gender").value = "<%= rquery.gender%>";
            document.getElementById("disabil").value = "<%= rquery.disabil%>";
            document.getElementById("lep").value = "<%= rquery.lep%>";
            document.getElementById("disadva").value = "<%= rquery.disadva%>";
        </script>
        <br>
        <br>
        <h1>Results</h1>
        <table style="text-align: center">
            <thead>
                <tr bgcolor="lightyellow">
                    <th>School Year</th>
                    <th>ENGR</th>
                    <th>ENGW</th>
                    <th>HIST</th>
                    <th>MATH</th>
                    <th>SCI</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<TestDatum> testdata = query.getData();
                    ArrayList<TestDatum> alldata = queryall.getData();
                    ArrayList<RacePercentDatum> rdata = rquery.getData();

                    if ((testdata.size() != 0) && (alldata.size() != 0) && (rdata.size() != 0)) {
                        int printyr = 0;
                        int odd = 0;
                        int tablesubj = 1;
                        int pryr = 0;

                        for (int i = 0; i < testdata.size(); i++) {
                            if (printyr == 0) {
                                if (odd == 0) {
                                    out.println("<tr class=\"odd\">");
                                    odd = 1;
                                } else {
                                    out.println("<tr class=\"even\">");
                                    odd = 0;
                                }
                                out.println("<td>" + testdata.get(i).getYear() + "</td>");
                            }
                            if ((tablesubj == 1) && ((testdata.get(i).getSubject()).equals("ENGR"))) {
                                out.println("<td>" + testdata.get(i).getScore() + "</td>");
                            } else if ((tablesubj == 2) && ((testdata.get(i).getSubject()).equals("ENGW"))) {
                                out.println("<td>" + testdata.get(i).getScore() + "</td>");
                            } else if ((tablesubj == 3) && ((testdata.get(i).getSubject()).equals("HIST"))) {
                                out.println("<td>" + testdata.get(i).getScore() + "</td>");
                            } else if ((tablesubj == 4) && ((testdata.get(i).getSubject()).equals("MATH"))) {
                                out.println("<td>" + testdata.get(i).getScore() + "</td>");
                            } else if ((tablesubj == 5) && ((testdata.get(i).getSubject()).equals("SCI"))) {
                                out.println("<td>" + testdata.get(i).getScore() + "</td>");
                            } else {
                                out.println("<td> NULL </td>");
                                i--;
                            }
                            printyr++;
                            if (printyr == 5) {
                                printyr = 0;
                                out.println("</tr>");
                            }
                            tablesubj++;
                            if (tablesubj == 6) {
                                tablesubj = 1;
                            }
                        }


                %>
            </tbody>
        </table>
            <br>
            <br>
        <h1>Chart for 
            <script>
                if(document.getElementById("gender").value != 'ALL'){
                    if(document.getElementById("gender").value == 'F')
                        document.write(" female, ");
                    if(document.getElementById("gender").value == 'M')
                        document.write(" male, ")
                }
                if(document.getElementById("disabil").value != 'ALL'){
                    if(document.getElementById("disabil").value == 'Y');
                        document.write( "disabled, "); 
                    if(document.getElementById("disabil").value == 'N')
                        document.write(" non-disabled, ");
                }
                if(document.getElementById("disadva").value != 'ALL'){
                    if(document.getElementById("disadva").value == 'Y');
                        document.write( " economically disadvantaged, "); 
                    if(document.getElementById("disadva").value == 'N');
                        document.write( " non-economically disadvantaged, "); 
                }
                if(document.getElementById("lep").value != 'ALL'){
                    if(document.getElementById("lep").value == 'Y');
                        document.write( " Limited English Proficiency, "); 
                }
               if(document.getElementById("race").value == 1)
                   document.write("American Indian/ Native Alaskan"); 
               else if(document.getElementById("race").value == 2)
                   document.write("Asian");
               else if(document.getElementById("race").value == 3)
                   document.write("Black or African-American");
               else if(document.getElementById("race").value == 4)
                   document.write("Hispanic");
               else if(document.getElementById("race").value == 5)
                   document.write("White");
               else if(document.getElementById("race").value == 6)
                   document.write("Native Hawaiian or Pacific Islander");
               else if(document.getElementById("race").value == 99)
                   document.write("2+ races");
            </script>
            students
        </h1>
        <p>Click on the links inside the tabbed menu:</p>

        <ul id="tabs" class="tab">
            <li><a class="tablinks" onclick="openSubject(event, 'ENGR')">ENGR</a></li>
            <li><a class="tablinks" onclick="openSubject(event, 'ENGW')">ENGW</a></li>
            <li><a class="tablinks" onclick="openSubject(event, 'HIST')">HIST</a>
            </li>
            <li><a class="tablinks" onclick="openSubject(event, 'MATH')">MATH</a>
            </li>
            <li><a class="tablinks" onclick="openSubject(event, 'SCI')">SCI</a></li>
        </ul>

        <div id="ENGR" class="tabcontent">
            <div id="chart_div1" style="width: 700px; height: 350px;"></div>
            <script type="text/javascript">
                var chart1Data, chart1Options, chart1;
                function drawChart1() {
                    
                    chart1Data = new google.visualization.DataTable();

                    chart1Data.addColumn('string', 'sch_year');
                    chart1Data.addColumn('number', 'SCI');
                    chart1Data.addColumn('number', 'SCI-Average');
                    chart1Data.addRows([
                <%                printyr = 0;
                    int testdatacount = 0;
                    int otheryr = 0;
                    int tempyear = 0;
                    int countrow = 0;
                    int countsubj = 1;
                    int allrowscore = 0;
                    TestDatum row = testdata.get(0);
                    tempyear = row.getYear();
                    TestDatum allrow;
                    out.print("['" + row.getYear() + "'");
                    for (int i = 0; i < alldata.size(); i++) {
                        row = testdata.get(testdatacount);
                        allrow = alldata.get(i);
                        allrowscore = 0;
                        if ((countrow == 0) && (tempyear != row.getYear())) {
                            out.print("['" + row.getYear() + "'");
                            tempyear = row.getYear();
                            countsubj = 1;
                        }
                        if ((row.getSubject()).equals("ENGR") && (printyr != 1)) {
                            out.print("," + row.getScore());
                            countrow++;
                            printyr = 1;
                        } else if ((allrow.getSubject().equals("ENGR")) && (printyr != 1)) {
                            out.print(",null");
                            countrow++;
                            printyr = 0;
                        }
                        if (!(row.getSubject()).equals(allrow.getSubject())) {
                            testdatacount--;
                        }
                        if ((row.getYear() == allrow.getYear()) && (allrow.getSubject().equals("ENGR"))) {
                            allrowscore = allrow.getScore();
                            out.print("," + allrowscore);
                            countrow++;
                            otheryr = 1;
                        } else if ((alldata.size() < testdata.size()) && (otheryr != 1)) {
                            out.print(",null");
                            countrow++;
                            otheryr = 0;
                        }
                        if (countrow == 2) {
                            out.print("],");
                            countrow = 0;
                            printyr = 0;
                            otheryr = 0;
                        }
                        countsubj++;
                        testdatacount++;
                    }
                %>
                    ]);

                    chart1Options = {
                        interpolateNulls: false,
                        hAxis: {
                            title: 'Year'
                        },
                        vAxis: {
                            title: 'Score'
                        },
                    };

                    chart1 = new google.visualization.LineChart(document.getElementById('chart_div1'));
                    chart1.draw(chart1Data, chart1Options );
                }
            </script>
        </div>

        <div id="ENGW" class="tabcontent">
            <div id="chart_div2" style="width: 700px; height: 350px;"></div>
            <script type="text/javascript">
                var chart2Data, chart2Options, chart2;
                function drawChart2() {
                    
                    chart2Data = new google.visualization.DataTable();

                    chart2Data.addColumn('string', 'sch_year');
                    chart2Data.addColumn('number', 'SCI');
                    chart2Data.addColumn('number', 'SCI-Average');
                    chart2Data.addRows([
                <%
                    printyr = 0;
                    testdatacount = 0;
                    otheryr = 0;
                    tempyear = 0;
                    countrow = 0;
                    countsubj = 1;
                    allrowscore = 0;
                    row = testdata.get(0);
                    tempyear = row.getYear();
                    out.print("['" + row.getYear() + "'");
                    for (int i = 0; i < alldata.size(); i++) {
                        row = testdata.get(testdatacount);
                        allrow = alldata.get(i);
                        allrowscore = 0;
                        if ((countrow == 0) && (tempyear != row.getYear())) {
                            out.print("['" + row.getYear() + "'");
                            tempyear = row.getYear();
                            countsubj = 1;
                        }
                        if ((row.getSubject()).equals("ENGW") && (printyr != 1)) {
                            out.print("," + row.getScore());
                            countrow++;
                            printyr = 1;
                        } else if ((allrow.getSubject().equals("ENGW")) && (printyr != 1)) {
                            out.print(",null");
                            countrow++;
                            printyr = 0;
                        }
                        if (!(row.getSubject()).equals(allrow.getSubject())) {
                            testdatacount--;
                        }
                        if ((row.getYear() == allrow.getYear()) && (allrow.getSubject().equals("ENGW"))) {
                            allrowscore = allrow.getScore();
                            out.print("," + allrowscore);
                            countrow++;
                            otheryr = 1;
                        } else if ((alldata.size() < testdata.size()) && (otheryr != 1)) {
                            out.print(",null");
                            countrow++;
                            otheryr = 0;
                        }
                        if (countrow == 2) {
                            out.print("],");
                            countrow = 0;
                            printyr = 0;
                            otheryr = 0;
                        }
                        countsubj++;
                        testdatacount++;
                    }
                %>
                    ]);

                    chart2Options = {
                        interpolateNulls: false,
                        hAxis: {
                            title: 'Year'
                        },
                        vAxis: {
                            title: 'Score'
                        },
                    };

                    chart2 = new google.visualization.LineChart(document.getElementById('chart_div2'));
                    chart2.draw(chart2Data, chart2Options );
                }
            </script>
        </div>

        <div id="HIST" class="tabcontent">
            <div id="chart_div3" style="width: 700px; height: 350px;"></div>
            <script type="text/javascript">
                var chart3Data, chart3Options, chart3;
                function drawChart3() {
                    chart3Data = new google.visualization.DataTable();

                    chart3Data.addColumn('string', 'sch_year');
                    chart3Data.addColumn('number', 'SCI');
                    chart3Data.addColumn('number', 'SCI-Average');
                    chart3Data.addRows([
                <%
                    printyr = 0;
                    testdatacount = 0;
                    otheryr = 0;
                    tempyear = 0;
                    countrow = 0;
                    countsubj = 1;
                    allrowscore = 0;
                    row = testdata.get(0);
                    tempyear = row.getYear();
                    out.print("['" + row.getYear() + "'");
                    for (int i = 0; i < alldata.size(); i++) {
                        row = testdata.get(testdatacount);
                        allrow = alldata.get(i);
                        allrowscore = 0;
                        if ((countrow == 0) && (tempyear != row.getYear())) {
                            out.print("['" + row.getYear() + "'");
                            tempyear = row.getYear();
                            countsubj = 1;
                        }
                        if (((row.getSubject()).equals("HIST")) && (printyr != 1)) {
                            out.print("," + row.getScore());
                            countrow++;
                            printyr = 1;
                        } else if ((allrow.getSubject().equals("HIST")) && (printyr != 1)) {
                            out.print(",null");
                            countrow++;
                            printyr = 0;
                        }
                        if (!(row.getSubject()).equals(allrow.getSubject())) {
                            testdatacount--;
                        }
                        if ((row.getYear() == allrow.getYear()) && (allrow.getSubject().equals("HIST"))) {
                            allrowscore = allrow.getScore();
                            out.print("," + allrowscore);
                            countrow++;
                            otheryr = 1;
                        } else if ((alldata.size() < testdata.size()) && (otheryr != 1)) {
                            out.print(",null");
                            countrow++;
                            otheryr = 0;
                        }
                        if (countrow == 2) {
                            out.print("],");
                            countrow = 0;
                            printyr = 0;
                            otheryr = 0;
                        }
                        countsubj++;
                        testdatacount++;
                    }
                %>
                    ]);

                    chart3Options = {
                        interpolateNulls: false,
                        hAxis: {
                            title: 'Year'
                        },
                        vAxis: {
                            title: 'Score'
                        },
                    };

                    chart3 = new google.visualization.LineChart(document.getElementById('chart_div3'));
                    chart3.draw(chart3Data, chart3Options );
                }
            </script>
        </div>

        <div id="MATH" class="tabcontent">
            <div id="chart_div4" style="width: 700px; height: 350px;"></div>
            <script type="text/javascript">
                var chart4Data, chart4Options, chart4;
                function drawChart4() {
                    chart4Data = new google.visualization.DataTable();

                    chart4Data.addColumn('string', 'sch_year');
                    chart4Data.addColumn('number', 'SCI');
                    chart4Data.addColumn('number', 'SCI-Average');
                    chart4Data.addRows([
                <%
                    printyr = 0;
                    testdatacount = 0;
                    otheryr = 0;
                    tempyear = 0;
                    countrow = 0;
                    countsubj = 1;
                    allrowscore = 0;
                    row = testdata.get(0);
                    tempyear = row.getYear();
                    out.print("['" + row.getYear() + "'");
                    for (int i = 0; i < alldata.size(); i++) {
                        row = testdata.get(testdatacount);
                        allrow = alldata.get(i);
                        allrowscore = 0;
                        if ((countrow == 0) && (tempyear != row.getYear())) {
                            out.print("['" + row.getYear() + "'");
                            tempyear = row.getYear();
                            countsubj = 1;
                        }
                        if (((row.getSubject()).equals("MATH")) && (printyr != 1)) {
                            out.print("," + row.getScore());
                            countrow++;
                            printyr = 1;
                        } else if ((allrow.getSubject().equals("MATH")) && (printyr != 1)) {
                            out.print(",null");
                            countrow++;
                            printyr = 0;
                        }
                        if (!(row.getSubject()).equals(allrow.getSubject())) {
                            testdatacount--;
                        }
                        if ((row.getYear() == allrow.getYear()) && (allrow.getSubject().equals("MATH"))) {
                            allrowscore = allrow.getScore();
                            out.print("," + allrowscore);
                            countrow++;
                            otheryr = 1;
                        } else if ((alldata.size() < testdata.size()) && (otheryr != 1)) {
                            out.print(",null");
                            countrow++;
                            otheryr = 0;
                        }
                        if (countrow == 2) {
                            out.print("],");
                            countrow = 0;
                            printyr = 0;
                            otheryr = 0;
                        }
                        countsubj++;
                        testdatacount++;
                    }
                %>
                    ]);

                    chart4Options = {
                        interpolateNulls: false,
                        hAxis: {
                            title: 'Year'
                        },
                        vAxis: {
                            title: 'Score'
                        },
                    };

                    chart4 = new google.visualization.LineChart(document.getElementById('chart_div4'));
                    chart4.draw(chart4Data, chart4Options );
                }
            </script>
        </div>

        <div id="SCI" class="tabcontent">
            <div id="chart_div5" style="width: 700px; height: 350px;"></div>
            <script type="text/javascript">
                var chart5Data, chart5Options, chart5;
                function drawChart5() {
                    chart5Data= new google.visualization.DataTable();

                    chart5Data.addColumn('string', 'sch_year');
                    chart5Data.addColumn('number', 'SCI');
                    chart5Data.addColumn('number', 'SCI-Average');
                    chart5Data.addRows([
                <%
                    printyr = 0;
                    testdatacount = 0;
                    otheryr = 0;
                    tempyear = 0;
                    countrow = 0;
                    countsubj = 1;
                    allrowscore = 0;
                    row = testdata.get(0);
                    tempyear = row.getYear();
                    out.print("['" + row.getYear() + "'");
                    for (int i = 0; i < alldata.size(); i++) {
                        row = testdata.get(testdatacount);
                        allrow = alldata.get(i);
                        allrowscore = 0;
                        if ((countrow == 0) && (tempyear != row.getYear())) {
                            out.print("['" + row.getYear() + "'");
                            tempyear = row.getYear();
                            countsubj = 1;
                        }
                        if (((row.getSubject()).equals("SCI")) && (printyr != 1)) {
                            out.print("," + row.getScore());
                            countrow++;
                            printyr = 1;
                        } else if ((allrow.getSubject().equals("SCI")) && (printyr != 1)) {
                            out.print(",null");
                            countrow++;
                            printyr = 0;
                        }
                        if (!(row.getSubject()).equals(allrow.getSubject())) {
                            testdatacount--;
                        }
                        if ((row.getYear() == allrow.getYear()) && (allrow.getSubject().equals("SCI"))) {
                            allrowscore = allrow.getScore();
                            out.print("," + allrowscore);
                            countrow++;
                            otheryr = 1;
                        } else if ((alldata.size() < testdata.size()) && (otheryr != 1)) {
                            out.print(",null");
                            countrow++;
                            otheryr = 0;
                        }
                        if (countrow == 2) {
                            out.print("],");
                            countrow = 0;
                            printyr = 0;
                            otheryr = 0;
                        }
                        countsubj++;
                        testdatacount++;
                    }
                %>
                    ]);

                    chart5Options = {
                        interpolateNulls: false,
                        hAxis: {
                            title: 'Year'
                        },
                        vAxis: {
                            title: 'Score'
                        },
                    };

                    chart5 = new google.visualization.LineChart(document.getElementById('chart_div5'));
                    chart5.draw(chart5Data, chart5Options)
                }
            </script>
        </div>

        <script type="text/javascript">
            google.charts.load('current', {packages: ['corechart', 'line']});
            google.charts.setOnLoadCallback(drawChart1);
            google.charts.setOnLoadCallback(drawChart2);
            google.charts.setOnLoadCallback(drawChart3);
            google.charts.setOnLoadCallback(drawChart4);
            google.charts.setOnLoadCallback(drawChart5);
            
            var obj = document.getElementById('tabs');
            obj.addEventListener("click", function() {
                chart1.draw(chart1Data, chart1Options);
                chart2.draw(chart2Data, chart2Options);
                chart3.draw(chart3Data, chart3Options);
                chart4.draw(chart4Data, chart4Options);
                chart5.draw(chart5Data, chart5Options);
                
            })
        </script>

        <script>
            function openSubject(evt, subject) {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tabcontent.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }
                document.getElementById(subject).style.display = "block";
                evt.currentTarget.className += " active";
            }
        </script>
<br>
            <br>
        <h1> Race Composition Chart
            <script>
              document.write(document.getElementById("sch_year").value);
          </script>
          :
        </h1>
        <div id="piechart" style="width: 900px; height: 500px;"></div>

        <script type="text/javascript">
            google.charts.setOnLoadCallback(drawChart);

            function drawChart() {

                var racedata = google.visualization.arrayToDataTable([
                    ['Race', 'Density'],
            <%
                for (RacePercentDatum rrow : rdata) {
                    out.println("['" + rrow.getRace() + "'," + rrow.getDensity() + "],");
                }
            %>
                ]);

                var options = {
                    title: 'Race Density'
                };

                var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                chart.draw(racedata, options);
            }
        </script> 

        <%
                } else {
                    out.print("<p> There is no result for this query. </p>");
                }
            }
        %>            
    </center>
    </body>
</html>