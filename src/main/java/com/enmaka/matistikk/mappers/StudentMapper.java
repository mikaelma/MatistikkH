package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.users.Student;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et Student-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class StudentMapper implements RowMapper<Student> {
    
    public Student mapRow(ResultSet rs, int i) throws SQLException {
        Student s = new Student();
        s.setUsername(rs.getString("email_fk"));
        s.setAge(rs.getInt("age"));
        s.setSex(rs.getBoolean("sex"));
        s.setClassId(rs.getInt("class_id"));
        s.setDescription("Student");
        return s;
    }
}
