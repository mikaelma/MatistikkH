package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.Test;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et Test-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class TestMapper implements RowMapper<Test>{
    
    @Override
    public Test mapRow(ResultSet res, int row) {
        try{
            Test test = new Test(res.getInt("test_id"), res.getString("email_fk"), res.getBoolean("active"));
            return test;
        }catch(Exception e){
            return null;
        }
    }
}
