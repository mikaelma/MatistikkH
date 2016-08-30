package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.users.Teacher;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et Teacher-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class TeacherMapper implements RowMapper<Teacher>{

    @Override
    public Teacher mapRow(ResultSet res, int i) {
        try{
            Teacher teacher = new Teacher();
            teacher.setUsername(res.getString("email_fk"));
            teacher.setFirstName(res.getString("firstname"));
            teacher.setLastName(res.getString("lastname"));
            teacher.setSchoolId(res.getInt("school_id"));
            teacher.setDescription("Teacher");
            teacher.setActive(res.getBoolean("active"));
            return teacher;
        }catch(Exception e){
            return null;
        }
    }
}
