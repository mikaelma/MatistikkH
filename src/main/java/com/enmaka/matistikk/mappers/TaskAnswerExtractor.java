package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.Fraction;
import com.enmaka.matistikk.objects.TaskAnswer;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et TaskAnswer-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.2.
 */

public class TaskAnswerExtractor implements ResultSetExtractor<List<TaskAnswer>>{

    @Override
    public List<TaskAnswer> extractData(ResultSet res) throws SQLException, DataAccessException {
        Map<Integer, TaskAnswer> map = new HashMap<>();
        TaskAnswer ta = null;
        while(res.next()){
            Integer in = res.getInt("answer_id");
            ta = map.get(in);
            if(ta == null){
                ta = new TaskAnswer();
                ta.setEmail(res.getString("email_fk"));
                String s = "";
                if(res.getBoolean("correct")){
                    s = "Riktig";
                }else{
                    s = "Feil";
                }
                ta.setCorrect(s);
                ta.setExplenation(res.getString("explenation"));
                ta.setTime(res.getDouble("total_time"));
                map.put(in, ta);
            }if(res.getInt("task_type")<5){
                map.get(in).addAnswer(new Fraction(res.getInt("numerator"), res.getInt("denominator")));
            }
        }
        return new ArrayList<TaskAnswer>(map.values());
    }
    
}
