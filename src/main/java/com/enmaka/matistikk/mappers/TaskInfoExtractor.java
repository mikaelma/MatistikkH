package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TaskInfo;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 *
 * @author magnussj
 * 
 * Oppretter et TaskInfo-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.2.
 */

public class TaskInfoExtractor implements ResultSetExtractor<List<TaskInfo>> {

    @Override
    public List<TaskInfo> extractData(ResultSet res) throws SQLException {
        Map<Integer, TaskInfo> map = new HashMap<Integer, TaskInfo>();
        TaskInfo ti = null;
        String s = "";
        while(res.next()){
            Integer in = res.getInt("task_id");
            ti = map.get(in);
            if(ti == null){
                ti = new TaskInfo();
                ti.setId(in);
                int tt = res.getInt("task_type");
                switch(tt){
                    case 1:
                    ti.setTaskType("Aritmetikk");
                    break;

                    case 2:
                    ti.setTaskType("Velg riktig");
                    break;

                    case 3:
                    ti.setTaskType("Sorter");
                    break;
                    
                    case 4:
                    ti.setTaskType("Tallinje");
                    break;
                    
                    case 5:
                    ti.setTaskType("Figurer");
                    break;
                    
                    case 6:
                    ti.setTaskType("Funksjoner");
                    break;
                }
                s = res.getString("text");
                if(!(res.getString("numerator") == null && res.getString("denominator") == null)) {
                    s += " " + res.getString("numerator") + "/" + res.getString("denominator"); 
                }
                ti.setText(s);
                ti.setUsername(res.getString("email_fk"));
                map.put(in, ti);
                }else if(ti.getText() != null){
                    s = ti.getText();
                    if(!(res.getString("numerator") == null && res.getString("denominator") == null)) {
                        s += ", " + res.getString("numerator") + "/" + res.getString("denominator"); 
                    }
                    ti.setText(s);
            }
        }
     return new ArrayList<TaskInfo>(map.values());   
    }

}
