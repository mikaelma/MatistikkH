package com.enmaka.matistikk.mappers;

import com.enmaka.matistikk.objects.Answer;
import com.enmaka.matistikk.objects.AnswerFunction;
import com.enmaka.matistikk.objects.AnswerMultipleFractions;
import com.enmaka.matistikk.objects.AnswerSingleFraction;
import com.enmaka.matistikk.objects.AnswerString;
import java.sql.ResultSet;
import org.springframework.jdbc.core.RowMapper;

/**
 *
 * @author Team ENMAKA
 *
 * Oppretter et Answer-objekt med data fra et ResultSet.
 *
 * For mer informasjon om klassen, se designdokumentet kapittel 4.6.1.
 */
public class AnswerMapper implements RowMapper<Answer> {

    @Override
    public Answer mapRow(ResultSet res, int row) {
        try {
            int taskType = res.getInt("task_type");
            if (taskType == 1 || taskType == 2 || taskType == 4) {
                AnswerSingleFraction answer = new AnswerSingleFraction(res.getString("explenation"), res.getString("email_fk"));
                answer.setId(res.getInt("answer_id"));
                answer.setTime(res.getDouble("total_time"));
                answer.setTaskId(res.getInt("task_id"));
                answer.setCorrect(res.getBoolean("correct"));
                return answer;
            } else if (taskType == 3) {
                AnswerMultipleFractions answer = new AnswerMultipleFractions(res.getString("explenation"), res.getString("email_fk"));
                answer.setId(res.getInt("answer_id"));
                answer.setTime(res.getDouble("total_time"));
                answer.setTaskId(res.getInt("task_id"));
                answer.setCorrect(res.getBoolean("correct"));
                return answer;
            } else if (taskType == 6) {
                AnswerFunction answer = new AnswerFunction(res.getString("explenation"), res.getString("email_fk"));
                answer.setId(res.getInt("answer_id"));
                answer.setTime(res.getDouble("total_time"));
                answer.setTaskId(res.getInt("task_id"));
                answer.setCorrect(res.getBoolean("correct"));
                return answer;
            }
                else{
                AnswerString answer = new AnswerString(res.getString("explenation"), res.getString("email_fk"));
                answer.setId(res.getInt("answer_id"));
                answer.setTime(res.getDouble("total_time"));
                answer.setTaskId(res.getInt("task_id"));
                answer.setCorrect(res.getBoolean("correct"));
                return answer;
            }
            }catch(Exception e) {
            return null;
        }
        }
    }
