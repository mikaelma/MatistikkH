package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.TeacherInfo;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et TeacherInfo-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class TeacherInfoMapper implements RowMapper<TeacherInfo> {

    @Override
    public TeacherInfo mapRow(ResultSet res, int i) {
        try {
            TeacherInfo ti = new TeacherInfo();
            ti.setUsername(res.getString("email_fk"));
            ti.setFirstName(res.getString("firstname"));
            ti.setLastName(res.getString("lastname"));
            ti.setTestCount(res.getInt("test_count"));
            ti.setSchoolName(res.getString("school_name"));
            return ti;
        }catch(Exception e) {
            return null;
        }
    }
}
