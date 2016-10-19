package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.users.Admin;
import com.enmaka.matistikk.users.Student;
import com.enmaka.matistikk.users.Teacher;
import com.enmaka.matistikk.users.User;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et User-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */

public class UserMapper implements RowMapper<User> {
    
    @Override
    public User mapRow(ResultSet res, int i) {
        try {
            String desc = res.getString("description");
            User u = null;
            switch (desc) {
                case "Student":
                    u = new Student();
                    u.setUsername(res.getString("email"));
                    u.setDescription(desc);
                    break;
                case "Teacher":
                    u = new Teacher();
                    u.setUsername(res.getString("email"));
                    u.setDescription(desc);
                    break;
                case "Admin":
                    u = new Admin();
                    u.setUsername(res.getString("email"));
                    u.setDescription(desc);
                    break;
                default:
                    break;
            }
            return u;
        }catch(Exception e) {
            return null;
        }
    }
}
