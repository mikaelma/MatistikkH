package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TaskInfo;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et TaskInfo-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class TaskInfoMapper implements RowMapper<TaskInfo> {

    @Override
    public TaskInfo mapRow(ResultSet res, int i) {
        try {
            TaskInfo ti = new TaskInfo();
            Integer in = res.getInt("task_id");
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
                ti.setTaskType("Funksjon");
                break;
            }
            String s = res.getString("text");
            String u = res.getString("email_fk");
            while(res.next()){
                if(!(res.getString("numerator") == null && res.getString("denominator") == null)) {
                    s += " " + res.getString("numerator") + "/" + res.getString("denominator"); 
                }
            }
            ti.setUsername(u);
            ti.setText(s);
            return ti;
        }catch(Exception e) {
            System.out.println(e);
            return null;
        }
    }
}
