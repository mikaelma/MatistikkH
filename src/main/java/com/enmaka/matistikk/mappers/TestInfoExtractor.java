package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TestInfo;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.springframework.jdbc.core.ResultSetExtractor;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et TestInfo-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.2.
 */

public class TestInfoExtractor implements ResultSetExtractor<List<TestInfo>>{
    
    @Override
    public List<TestInfo> extractData(ResultSet res) {
        try {
            ArrayList<TestInfo> tests = new ArrayList<>();
            while(res.next()){
                TestInfo ti = new TestInfo();
                ti.setId(res.getInt("test_id"));
                ti.setTeacher(res.getString("email_fk"));
                ti.setProgress(res.getInt("progress"));
                ti.setSize(res.getInt("tasks"));
                tests.add(ti);
            }
            return tests;
        }catch(Exception e) {
            return null;
        }
    }
}
