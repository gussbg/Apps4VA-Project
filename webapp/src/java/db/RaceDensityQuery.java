package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

public class RaceDensityQuery {

    public int div_num;
    public int sch_num;
    public int sch_year;
    public int grade_num;
    public String race;
    public String gender;
    public String disabil;
    public String lep;
    public String disadva;
    public int all_races_count;

    private ArrayList<RacePercentDatum> data;

    public RaceDensityQuery(HttpServletRequest request) {
        div_num = parseInt(request, "div_num");
        sch_num = parseInt(request, "sch_num");
        sch_year = parseInt(request, "sch_year");
        grade_num = parseInt(request, "grade_num");
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

    public ArrayList<RacePercentDatum> getData() {
        // return cached copy if exists
        if (data != null) {
            return data;
        }
        
        String sql = "SELECT * FROM all_races_enrollment(?, ?, ?, ?, ?, ?, ?, ?)";
        
        try {
            // set the query parameters
            Connection db = Database.open();
            PreparedStatement st = db.prepareStatement(sql);
            st.setInt(1, div_num);
            st.setInt(2, sch_num);
            st.setInt(3, sch_year);
            st.setInt(4, grade_num);
            st.setString(5, gender);
            st.setString(6, disabil);
            st.setString(7, lep);
            st.setString(8, disadva);

            // execute query, save results
            ResultSet rs = st.executeQuery();
            
            data = new ArrayList<>();
            
            if (rs.next() && rs.getString(1).equals("ALL")) {
                all_races_count = rs.getInt(2);
            }
            
            while (rs.next()) {
                data.add(new RacePercentDatum(Integer.parseInt(rs.getString(1)), rs.getInt(2), (double) rs.getInt(2) / all_races_count));
            }
            
            while (rs.next())

            // close database resources
            rs.close();
            db.close();
            return data;
        } catch (SQLException exc) {
            // lazy hack to simplify hw5
            throw new RuntimeException(exc);
        }
    }
}
