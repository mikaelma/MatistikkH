package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.Fraction;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 * 
 * Oppretter et Fraction-objekt med data fra et ResultSet.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */
public class FractionMapper implements RowMapper<Fraction>{
    
    @Override
    public Fraction mapRow(ResultSet res, int row){
        try{
            Fraction fraction = new Fraction(res.getInt("Numerator"), res.getInt("Denominator"));
            return fraction;
        }catch(Exception e) {
            return null;
        }
    }
}
