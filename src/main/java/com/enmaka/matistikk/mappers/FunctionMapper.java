/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.Function;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Mikael
 */
public class FunctionMapper implements RowMapper<Function> {
    
    @Override
    public Function mapRow(ResultSet res, int row){
        try{
            Function function = new Function(res.getInt("Answer_type"));
            return function;
        }catch(Exception e){
            return null;   
        }
    }
    
}
