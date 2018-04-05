package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

public class ScatterQuery {

    public int div_num;
    public int sch_num;
    public int sch_year;
    public String race;
    public String gender;
    public String disabil;
    public String lep;
    public String disadva;

    private ArrayList<TestDatum> data;
    private ArrayList<Integer> schooldata;

    public ScatterQuery(HttpServletRequest request) {
        div_num = parseInt(request, "div_num");
        sch_num = parseInt(request, "sch_num");
        sch_year = parseInt(request, "sch_year");
        race = parseStr(request, "race");
        gender = parseStr(request, "gender");
        disabil = parseStr(request, "disabil");
        lep = parseStr(request, "lep");
        disadva = parseStr(request, "disadva");
    }

    private int parseInt(HttpServletRequest request, String name) {
        String str = request.getParameter(name);
        try {
            return Integer.parseInt(str);
        } catch (NumberFormatException exc) {
            return 0;
        }
    }

    private String parseStr(HttpServletRequest request, String name) {
        String str = request.getParameter(name);
        if (str != null) {
            return str;
        } else {
            return "ALL";
        }
    }

    public ArrayList<TestDatum> getData() {
        // return cached copy if exists
        if (data != null) {
            return data;
        }
        String sql = "SELECT * FROM race_avg_sol(?, ?, ?, ?, ?, ?, ?, ?)";
        String sql2 = "SELECT * FROM schoolnum(?)";
        try {
            // set the query parameters
            Connection db = Database.open();
            PreparedStatement st = db.prepareStatement(sql);
            PreparedStatement st2 = db.prepareStatement(sql2);
            st.setInt(1, div_num);
            st2.setInt(1, div_num);
            //st.setInt(2, sch_num);
            st.setInt(3, sch_year);
            st.setString(4, race);
            st.setString(5,"ALL");
            st.setString(6,"ALL");
            st.setString(7,"ALL");
            st.setString(8,"ALL");

            // execute query, save results
           // ResultSet rs = st.executeQuery();
            schooldata = new ArrayList<>();
            ResultSet rs2 = st2.executeQuery();
            while (rs2.next()) {
                schooldata.add(rs2.getInt(1));
            }
            rs2.close();
            
            for(int i=0; i< schooldata.size();i++){
                st.setInt(2,schooldata.get(i));
                ResultSet rs = st.executeQuery();
                if(rs.next())
                    data.add(new TestDatum(rs.getString(1), rs.getInt(2), sch_year));
            }

            // close database resources
            //rs.close();
            st.close();
            db.close();
            return data;
        } catch (SQLException exc) {
            // lazy hack to simplify hw5
            throw new RuntimeException(exc);
        }
    }

}

