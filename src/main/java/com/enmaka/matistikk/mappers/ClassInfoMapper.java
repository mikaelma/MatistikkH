package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.ClassInfo;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et ClassInfo-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class ClassInfoMapper implements RowMapper<ClassInfo>{

    @Override
    public ClassInfo mapRow(ResultSet res, int i){
        try{
            ClassInfo classInfo = new ClassInfo();
            classInfo.setClassId(res.getInt("class_id"));
            classInfo.setClassName(res.getString("class_name"));
            classInfo.setSchoolName(res.getString("school_name"));
            classInfo.setStudents(res.getInt("students"));
            return classInfo;
        }catch(Exception e) {
            return null;
        }
    }
}
