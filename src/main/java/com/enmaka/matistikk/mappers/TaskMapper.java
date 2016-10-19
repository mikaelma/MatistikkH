package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.*;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et Task-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class TaskMapper implements RowMapper<Task>{

    @Override
    public Task mapRow(ResultSet res, int i) {
        try {
            int type = res.getInt("task_type");
            Task task = null;
            switch(type){
                case 1:
                task = new Arithmetic(res.getInt("task_id"), res.getString("text"));
                break;

                case 2:
                task = new SingleChoice(res.getInt("task_id"), res.getString("text")); 
                break;

                case 3:
                task = new Sort(res.getInt("task_id"), res.getString("text"));
                break;

                case 4:
                task = new NumberLine(res.getInt("task_id"), res.getString("text"));
                break;

                case 5:
                task = new Figures(res.getInt("task_id"), res.getString("text"));
                break;
                
                case 6:
                task = new Function(res.getInt("task_id"), res.getString("text"));
                break;
            }
            return task;
        }catch(Exception e) {
            return null;
        }
    }
}
