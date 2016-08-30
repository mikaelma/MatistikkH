package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TeacherStatistics;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et TeacherStatistics-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.2.
 */

public class TeacherStatisticsExtractor implements ResultSetExtractor<List<TeacherStatistics>>{

    @Override
    public List<TeacherStatistics> extractData(ResultSet res) {
        Map<String, TeacherStatistics> map = new HashMap<>();
        TeacherStatistics ts = null;
        try{
            while(res.next()){
                String s = res.getString("email_fk");
                ts = map.get(s);
                if(ts == null){
                    ts = new TeacherStatistics();
                    ts.setEmail(s);
                    ts.setFirstName(res.getString("firstname"));
                    ts.setLastName(res.getString("lastname"));
                    ts.setSchool(res.getString("school_name"));
                    ts.setTestCount(res.getInt("test_count"));
                    map.put(s, ts);
                }
                map.get(s).addClassName(res.getString("class_name"));
            }
        }catch(Exception e){
            return null;
        }
        return new ArrayList<TeacherStatistics>(map.values());
    }
}
