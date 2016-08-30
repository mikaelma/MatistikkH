package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TaskStatistics;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et TaskStatistics-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class TaskStatisticsMapper implements RowMapper<TaskStatistics> {
    
    @Override
    public TaskStatistics mapRow(ResultSet res, int i) {
        try {
            TaskStatistics ts = new TaskStatistics();
            ts.setTaskId(res.getInt("task_id"));
            ts.setStudents(res.getInt("users"));
            ts.setCorrect(res.getInt("correct"));
            ts.setWrong(res.getInt("wrong"));
            return ts;
        }catch(Exception e) {
            return null;
        }
    }
}
