package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.Fraction;
import com.enmaka.matistikk.objects.TaskSolution;
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
 * Oppretter et TaskSolution-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.2.
 */

public class TaskSolutionExtractor implements ResultSetExtractor<List<TaskSolution>>{

    @Override
    public List<TaskSolution> extractData(ResultSet res) {
        Map<Integer, TaskSolution> map = new HashMap<>();
        TaskSolution ts = null;
        try{
            while(res.next()){
                Integer in = res.getInt("task_id");
                ts = map.get(in);
                if(ts == null){
                    ts = new TaskSolution();
                    ts.setId(in);
                    ts.setText(res.getString("text"));
                    map.put(in, ts);
                }
                if(res.getInt("task_type")<5){
                    map.get(in).addSolution(new Fraction(res.getInt("numerator"), res.getInt("denominator")));
                }
            }
        }catch(Exception e){
            return null;
        }
        return new ArrayList<TaskSolution>(map.values());
    }   
}
