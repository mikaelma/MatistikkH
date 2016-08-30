package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TestInfo;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et TestInfo-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class TestInfoMapper implements RowMapper<TestInfo>{

    @Override
    public TestInfo mapRow(ResultSet res, int i) {            
        try{
            TestInfo ti = new TestInfo();
            ti.setId(res.getInt("test_id"));
            ti.setTeacher(res.getString("email_fk"));
            ti.setSize(res.getInt("tasks"));
            ti.setActive(res.getBoolean("active"));
            return ti;
        }catch(Exception e){
            return null;
        }
    }   
}
