package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.SchoolInfo;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et SchoolInfo-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class SchoolInfoMapper implements RowMapper<SchoolInfo>{

    @Override
    public SchoolInfo mapRow(ResultSet res, int i) {
        try{
            SchoolInfo si = new SchoolInfo();
            si.setSchoolId(res.getInt("school_id"));
            si.setSchoolName(res.getString("school_name"));
            si.setClassCount(res.getInt("class_count"));
            return si;
        }catch(Exception e){
            return null;
        }
    }
    
}
