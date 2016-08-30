package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TestStatistics;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENAMAKA
 * 
 * Oppretter et TestStatistics-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class TestStatisticsMapper implements RowMapper<TestStatistics> {
    
    @Override
    public TestStatistics mapRow(ResultSet res, int i) {
        try{
            TestStatistics s = new TestStatistics();
            s.setTestId(res.getInt("test_id"));
            s.setUsername(res.getString("email_fk"));
            s.setTaskCount(res.getInt("task_count"));
            s.setStudentCount(res.getInt("student_count"));
            s.setTeacherCount(res.getInt("teacher_count"));
            s.setActive(res.getBoolean("active"));
            return s;
        }catch(Exception e) {
            return null;
        }
    }
}
