package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;

public class Query {

    public int div_num;
    public int sch_num;
    public int sch_year;
    public String race;
    public String gender;
    public String disabil;
    public String lep;
    public String disadva;

    private ArrayList<TestDatum> data;

    public Query(HttpServletRequest request) {
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
        try {
            // set the query parameters
            Connection db = Database.open();
            PreparedStatement st = db.prepareStatement(sql);
            st.setInt(1, div_num);
            st.setInt(2, sch_num);
            //st.setInt(3, sch_year);
            st.setString(4, race);
            st.setString(5, gender);
            st.setString(6, disabil);
            st.setString(7, lep);
            st.setString(8, disadva);

            // execute query, save results
           // ResultSet rs = st.executeQuery();
            data = new ArrayList<>();
            for(int year=0; year<14; year++){
                st.setInt(3, 2000+year);
                ResultSet rs = st.executeQuery();
                for (int row = 0; row < 5; row++) {
                    if (rs.next()) {
                        data.add(new TestDatum(rs.getString(1), rs.getInt(2), 2000+year));
                    }
                }
                rs.close();
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
