package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.StudentInfo;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et StudentInfo-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class StudentInfoMapper implements RowMapper<StudentInfo>{

    @Override
    public StudentInfo mapRow(ResultSet res, int i){
        try{
            StudentInfo si = new StudentInfo();
            si.setEmail(res.getString("email_fk"));
            si.setTestCount(res.getInt("test_count"));
            si.setAge(res.getInt("age"));
            si.setSex(res.getBoolean("sex"));
            si.setSchool(res.getString("school_name"));
            si.setClassName(res.getString("class_name"));
            si.setActive(res.getBoolean("active"));
            return si;
        }catch(Exception e){
            return null;
        }
    }
}
