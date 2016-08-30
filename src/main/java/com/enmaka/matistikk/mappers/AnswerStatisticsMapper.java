package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TaskAnswer;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENAMAKA
 * 
 * Oppretter et TaskAnswer-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class AnswerStatisticsMapper implements RowMapper<TaskAnswer> {
    
    @Override
    public TaskAnswer mapRow(ResultSet res, int i) {
        try {
            TaskAnswer ta = new TaskAnswer();
            ta.setEmail(res.getString("email_fk"));
            boolean b = res.getBoolean("correct");
            String s = "";
            if(b) {
                s = "Riktig";
            } else {
                s = "Feil";
            }
            ta.setCorrect(s);
            ta.setTime(res.getDouble("total_time"));
            return ta;
        }catch(Exception e) {
            return null;
        }
    }
}
