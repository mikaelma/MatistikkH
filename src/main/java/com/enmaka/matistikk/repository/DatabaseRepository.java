package com.enmaka.matistikk.repository;

import com.enmaka.matistikk.mappers.UserMapper;
import com.enmaka.matistikk.mappers.TaskMapper;
import com.enmaka.matistikk.mappers.TaskInfoExtractor;
import com.enmaka.matistikk.mappers.TestMapper;
import com.enmaka.matistikk.mappers.TeacherMapper;
import com.enmaka.matistikk.mappers.StudentMapper;
import com.enmaka.matistikk.mappers.StudentInfoMapper;
import com.enmaka.matistikk.mappers.SchoolInfoMapper;
import com.enmaka.matistikk.mappers.TaskAnswerExtractor;
import com.enmaka.matistikk.mappers.TaskSolutionExtractor;
import com.enmaka.matistikk.mappers.TaskInfoMapper;
import com.enmaka.matistikk.mappers.AnswerMapper;
import com.enmaka.matistikk.mappers.TeacherStatisticsExtractor;
import com.enmaka.matistikk.mappers.ClassInfoMapper;
import com.enmaka.matistikk.mappers.TeacherInfoMapper;
import com.enmaka.matistikk.mappers.TestInfoMapper;
import com.enmaka.matistikk.mappers.TaskStatisticsMapper;
import com.enmaka.matistikk.mappers.TestInfoExtractor;
import com.enmaka.matistikk.mappers.AnswerStatisticsMapper;
import com.enmaka.matistikk.mappers.TestStatisticsMapper;
import com.enmaka.matistikk.email.Mail;
import com.enmaka.matistikk.objects.*;
import com.enmaka.matistikk.service.*;
import com.enmaka.matistikk.users.*;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.Console;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import static java.lang.System.console;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.zeroturnaround.zip.ZipUtil;
import org.zeroturnaround.zip.commons.FileUtils;

/**
 *
 * @author Team ENMAKA
 *
 * Klassen tar for seg kommunikasjon mellom systemet og databasen.
 *
 * For mer informasjon om klassen, se designdokumentet kapittel 4.8.2.
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = {"com.enmaka.matistikk.controllers"})
public class DatabaseRepository implements UserRepository {

    //Her finner man alle SQL-setningene som blir brukt av metodene til å hente, sette inn og oppdatere informasjon i databasen
    private final String sqlAddUser = "INSERT INTO USERS VALUES (?, ?, ?, ?)";
    private final String sqlAddStudentInfo = "INSERT INTO STUDENT_INFO VALUES (?, ?, ?, ?)";
    private final String sqlAddTeacherInfo = "INSERT INTO TEACHER_INFO (EMAIL_FK, FIRSTNAME, LASTNAME, SCHOOL_ID) VALUES(?, ?, ?, ?)";
    private final String sqlSelectAllStudents = "SELECT SI.EMAIL_FK, COUNT(TS.TEST_ID) AS TEST_COUNT, SI.AGE, SI.SEX, S.SCHOOL_NAME, SC.CLASS_NAME, U.ACTIVE FROM STUDENT_INFO SI INNER JOIN USERS U ON SI.EMAIL_FK = U.EMAIL "
            + "LEFT JOIN SCHOOL_CLASS SC ON SI.CLASS_ID = SC.CLASS_ID INNER JOIN SCHOOL S ON SC.SCHOOL_ID = S.SCHOOL_ID "
            + "LEFT JOIN TEST_STUDENT TS ON SI.EMAIL_FK = TS.EMAIL_FK GROUP BY SI.EMAIL_FK, SI.AGE, SI.SEX, S.SCHOOL_NAME, SC.CLASS_NAME, U.ACTIVE";
    private final String sqlGetPassword = "SELECT PASSWORD FROM USERS WHERE EMAIL = ?";
    private final String sqlChangePassword = "UPDATE USERS SET PASSWORD = ? WHERE EMAIL = ?";
    private final String sqlFindEmail = "SELECT COUNT(*) FROM USERS WHERE EMAIL = ?";
    private final String sqlFindUser = "SELECT EMAIL,PASSWORD,DESCRIPTION FROM USERS WHERE EMAIL = ? AND PASSWORD = ? AND ACTIVE = TRUE";
    private final String sqlSelectAllTeachers = "SELECT TI.EMAIL_FK, TI.FIRSTNAME, TI.LASTNAME, COUNT(T.TEST_ID) AS TEST_COUNT, S.SCHOOL_NAME FROM USERS U LEFT JOIN TEST T ON U.EMAIL=T.EMAIL_FK "
            + "INNER JOIN TEACHER_INFO TI ON U.EMAIL=TI.EMAIL_FK INNER JOIN SCHOOL S ON TI.SCHOOL_ID=S.SCHOOL_ID "
            + "WHERE U.DESCRIPTION='Teacher' GROUP BY TI.FIRSTNAME, TI.LASTNAME, TI.EMAIL_FK, S.SCHOOL_NAME";
    private final String sqlSelectTaskInfo = "SELECT T.TASK_ID, T.TASK_TYPE, T.TEXT, FT.NUMERATOR, FT.DENOMINATOR, T.EMAIL_FK FROM TASK T LEFT JOIN FRACTION_TASK FT ON T.TASK_ID = FT.TASK_ID WHERE T.TESTABLE = ?";
    private final String sqlSelectTaskInfoId = "SELECT T.TASK_ID, T.TASK_TYPE, T.TEXT, FT.NUMERATOR, FT.DENOMINATOR, T.EMAIL_FK FROM TASK T LEFT JOIN FRACTION_TASK FT ON T.TASK_ID = FT.TASK_ID WHERE T.TASK_ID = ?";
    private final String sqlSelectStudentInfo = "SELECT * FROM STUDENT_INFO WHERE EMAIL_FK = ?";
    private final String sqlSelectTeacherInfo = "SELECT TI.*, U.ACTIVE FROM TEACHER_INFO TI INNER JOIN USERS U ON TI.EMAIL_FK = U.EMAIL WHERE TI.EMAIL_FK = ?";
    private final String sqlAddAnswer = "INSERT INTO ANSWER(TEST_ID, TASK_ID, TOTAL_TIME, CORRECT, EMAIL_FK, EXPLENATION) VALUES (?, ?, ?, ?, ?, ?)";
    private final String sqlAddFractionAnswer = "INSERT INTO FRACTION_ANSWER(ANSWER_ID, NUMERATOR, DENOMINATOR) VALUES (?, ?, ?)";
    private final String sqlAddStringAnswer = "INSERT INTO STRING_ANSWER(ANSWER_ID, URL) VALUES (?, ?)";
    private final String sqlSelectAnswer = "SELECT A.*, T.TASK_TYPE FROM ANSWER A INNER JOIN TASK T ON A.TASK_ID = T.TASK_ID AND A.EMAIL_FK = ? AND A.TEST_ID = ? AND A.TASK_ID = ?";
    private final String sqlSelectFractionAnswer = "SELECT * FROM FRACTION_ANSWER WHERE ANSWER_ID = ?";
    private final String sqlSelectStringAnswer = "SELECT URL FROM STRING_ANSWER WHERE ANSWER_ID = ?";
    private final String sqlAddTask = "INSERT INTO TASK(TASK_TYPE, TEXT, TESTABLE, EMAIL_FK) VALUES (?, ?, ?, ?)";
    private final String sqlAddFractionTask = "INSERT INTO FRACTION_TASK(TASK_ID, NUMERATOR, DENOMINATOR) VALUES (?, ?, ?)";
    private final String sqlAddStringTask = "INSERT INTO STRING_TASK(TASK_ID, URL) VALUES (?, ?)";
    private final String sqlAddFractionSolution = "INSERT INTO FRACTION_SOLUTION(TASK_ID, NUMERATOR, DENOMINATOR) VALUES (?, ?, ?)";
    private final String sqlAddStringSolution = "INSERT INTO STRING_SOLUTION(TASK_ID, URL) VALUES (?, ?)";
    private final String sqlSelectTask = "SELECT * FROM TASK WHERE TASK.TASK_ID = ?";
    private final String sqlSelectFractionSolution = "SELECT NUMERATOR, DENOMINATOR FROM FRACTION_SOLUTION WHERE TASK_ID = ?";
    private final String sqlSelectStringSolution = "SELECT URL FROM STRING_SOLUTION WHERE TASK_ID = ?";
    private final String sqlSelectStringTask = "SELECT URL FROM STRING_TASK WHERE TASK_ID = ?";
    private final String sqlSelectFractionTask = "SELECT NUMERATOR, DENOMINATOR FROM FRACTION_TASK WHERE TASK_ID = ?";
    private final String sqlSelectTeacherClasses = "SELECT CLASS_ID FROM TEACHER_CLASS WHERE EMAIL_FK = ?";
    private final String sqlSelectTests = "SELECT TE.TEST_ID, TE.EMAIL_FK, TS.PROGRESS, COUNT(TA.TASK_ID) AS TASKS FROM TEST TE INNER JOIN TEST_TASK TT ON TE.TEST_ID = TT.TEST_ID INNER JOIN TASK TA ON TT.TASK_ID = TA.TASK_ID LEFT JOIN "
            + "(SELECT * FROM TEST_STUDENT WHERE EMAIL_FK = ?) TS ON TE.TEST_ID = TS.TEST_ID INNER JOIN TEST_CLASS TC ON TE.TEST_ID = TC.TEST_ID WHERE TE.TEST_ID NOT IN(SELECT TEST_ID FROM TEST_STUDENT TS WHERE"
            + " TS.EMAIL_FK = ? AND TS.COMPLETED = TRUE) AND TC.CLASS_ID = ? AND ACTIVE = TRUE AND TE.TESTABLE = TRUE GROUP BY TE.TEST_ID, TE.EMAIL_FK, TS.PROGRESS";

    private final String sqlSelectPracticeTests = "SELECT TE.TEST_ID, TE.EMAIL_FK, TS.PROGRESS, COUNT(TA.TASK_ID) AS TASKS FROM TEST TE INNER JOIN TEST_TASK TT ON TE.TEST_ID = TT.TEST_ID INNER JOIN TASK TA ON TT.TASK_ID = TA.TASK_ID LEFT JOIN "
            + "(SELECT * FROM TEST_STUDENT WHERE EMAIL_FK = ?) TS ON TE.TEST_ID = TS.TEST_ID INNER JOIN TEST_CLASS TC ON TE.TEST_ID = TC.TEST_ID WHERE TE.TEST_ID NOT IN(SELECT TEST_ID FROM TEST_STUDENT TS WHERE"
            + " TS.EMAIL_FK = ? AND TS.COMPLETED = TRUE) AND TC.CLASS_ID = ? AND ACTIVE = TRUE AND TE.TESTABLE = FALSE GROUP BY TE.TEST_ID, TE.EMAIL_FK, TS.PROGRESS";
    private final String sqlSelectTestTask = "SELECT * FROM TEST_TASK WHERE TEST_ID = ?";
    private final String sqlSelectTest = "SELECT * FROM TEST WHERE TEST_ID = ?";
    private final String sqlAddTest = "INSERT INTO TEST(EMAIL_FK, ACTIVE, TESTABLE) VALUES (?, ?, ?)";
    private final String sqlAddTestTask = "INSERT INTO TEST_TASK VALUES (?, ?)";
    private final String sqlSelectTestUsers = "SELECT A.EMAIL_FK, SUM(A.TOTAL_TIME) AS TEST_TIME FROM ANSWER A INNER JOIN TASK TA ON A.TASK_ID = TA.TASK_ID INNER JOIN TEST_TASK TT ON TA.TASK_ID = TT.TASK_ID WHERE TT.TEST_ID = ? AND A.TEST_ID = TT.TEST_ID GROUP BY A.EMAIL_FK";
    private final String sqlSelectTestUsersResult = "SELECT TT.TASK_ID, A.ANSWER_ID, A.EMAIL_FK, A.CORRECT FROM TEST_STUDENT TS INNER JOIN TEST T ON T.TEST_ID = TS.TEST_ID INNER JOIN TEST_TASK TT ON "
            + "T.TEST_ID = TT.TEST_ID LEFT JOIN (SELECT * FROM ANSWER WHERE EMAIL_FK = ?) A ON TT.TASK_ID = A.TASK_ID WHERE TS.TEST_ID = T.TEST_ID AND TT.TEST_ID = ? GROUP BY TT.TASK_ID, A.ANSWER_ID, A.EMAIL_FK, A.CORRECT";
    private final String sqlSelectTaskSolution = "SELECT TA.TASK_ID, TA.TEXT, TA.TASK_TYPE, FS.NUMERATOR, FS.DENOMINATOR FROM TASK TA LEFT JOIN FRACTION_SOLUTION FS ON TA.TASK_ID = FS.TASK_ID INNER JOIN TEST_TASK TT ON TA.TASK_ID = TT.TASK_ID WHERE TT.TEST_ID = ?";
    private final String sqlSelectTaskSummary = "SELECT A.ANSWER_ID, A.EMAIL_FK, TA.TASK_TYPE, FA.NUMERATOR, FA.DENOMINATOR, A.CORRECT, A.EXPLENATION, A.TOTAL_TIME FROM ANSWER A LEFT JOIN FRACTION_ANSWER FA ON A.ANSWER_ID = FA.ANSWER_ID INNER JOIN TASK TA "
            + "ON A.TASK_ID = TA.TASK_ID INNER JOIN TEST_TASK TT ON TA.TASK_ID = TT.TASK_ID INNER JOIN TEST TE ON TT.TEST_ID = TE.TEST_ID INNER JOIN TEST_STUDENT TS ON TE.TEST_ID = TS.TEST_ID WHERE TS.TEST_ID = ? AND TT.TASK_ID = ? AND A.EMAIL_FK = TS.EMAIL_FK";
    private final String sqlAddTestStudent = "INSERT INTO TEST_STUDENT(TEST_ID, EMAIL_FK, COMPLETED, PROGRESS) VALUES (?, ?, ?, ?)";
    private final String sqlUpdateTestStudent = "UPDATE TEST_STUDENT SET PROGRESS = ? WHERE TEST_ID = ? AND EMAIL_FK = ?";
    private final String sqlUpdateTestStudentComplete = "UPDATE TEST_STUDENT SET COMPLETED = ?, PROGRESS = ? WHERE TEST_ID = ? AND EMAIL_FK = ?";
    private final String sqlAddDrawing = "INSERT INTO DRAWING(ANSWER_ID, FILE_PATH) VALUES (?, ?)";
    private final String sqlCheckAnswer = "SELECT ANSWER_ID FROM ANSWER WHERE TEST_ID = ? AND TASK_ID = ? AND EMAIL_FK = ?";
    private final String sqlUpdateFractionAnswer = "UPDATE FRACTION_ANSWER SET NUMERATOR = ?, DENOMINATOR = ? WHERE ANSWER_ID = ?";
    private final String sqlUpdateAnswer = "UPDATE ANSWER SET TOTAL_TIME = ?, CORRECT = ?, EXPLENATION = ? WHERE ANSWER_ID = ?";
    private final String sqlSelectFractionAnswerId = "SELECT FRACTION_ANSWER_ID FROM FRACTION_ANSWER WHERE ANSWER_ID = ?";
    private final String sqlUpdateFractionAnswers = "UPDATE FRACTION_ANSWER SET NUMERATOR = ?, DENOMINATOR = ? WHERE FRACTION_ANSWER_ID = ?";
    private final String sqlUpdateStringAnswer = "UPDATE STRING_ANSWER SET URL = ? WHERE ANSWER_ID = ?";
    private final String sqlSelectCountTestsTaken = "SELECT COUNT(TS.EMAIL_FK) AS ANTALL_TESTER FROM TEST_STUDENT TS, TEST T WHERE TS.TEST_ID = T.TEST_ID AND TS.EMAIL_FK = ? AND TS.COMPLETED = ? AND T.TESTABLE = ?";
    private final String sqlSelectCountTestsMade = "SELECT COUNT(T.EMAIL_FK) AS ANTALL_TESTER FROM TEST T WHERE T.EMAIL_FK = ?";
    private final String sqlSelectStatistics = "SELECT T.TEST_ID, T.EMAIL_FK, (SELECT COUNT(*) FROM TEST_TASK TT WHERE TT.TEST_ID = T.TEST_ID) TASK_COUNT, (SELECT COUNT(*) FROM TEST_STUDENT TS WHERE TS.TEST_ID = T.TEST_ID) STUDENT_COUNT, "
            + "(SELECT COUNT(*) FROM TEST_TEACHER TET WHERE TET.TEST_ID = T.TEST_ID) TEACHER_COUNT, T.ACTIVE FROM TEST T WHERE T.TESTABLE = ?";
    private final String sqlSelectTestStatistics = "SELECT TA.TASK_ID, COUNT(A.EMAIL_FK) AS USERS, SUM(CASE WHEN A.CORRECT = TRUE THEN 1 ELSE 0 END) AS CORRECT, SUM(CASE WHEN A.CORRECT = FALSE THEN 1 ELSE 0 END) AS WRONG"
            + " FROM TASK TA INNER JOIN TEST_TASK TT ON TA.TASK_ID = TT.TASK_ID INNER JOIN ANSWER A ON TA.TASK_ID = A.TASK_ID WHERE TT.TEST_ID = ? AND A.TEST_ID = TT.TEST_ID GROUP BY TA.TASK_ID";
    private final String sqlSelectTaskStatistics = "SELECT A.EMAIL_FK, A.CORRECT, A.TOTAL_TIME FROM ANSWER A WHERE A.TEST_ID = ? AND A.TASK_ID = ?";
    private final String sqlUpdateClassId = "UPDATE STUDENT_INFO SI SET SI.CLASS_ID = ? WHERE SI.EMAIL_FK = ?";
    private final String sqlCheckClass = "SELECT 1 FROM SCHOOL_CLASS WHERE CLASS_ID = ?";
    private final String sqlSelectClass = "SELECT SC.CLASS_ID, S.SCHOOL_NAME, SC.CLASS_NAME, COUNT(SI.EMAIL_FK) AS STUDENTS FROM SCHOOL_CLASS SC INNER JOIN SCHOOL S ON S.SCHOOL_ID = SC.SCHOOL_ID INNER JOIN STUDENT_INFO SI ON SC.CLASS_ID = SI.CLASS_ID WHERE SC.CLASS_ID = ? GROUP BY SC.CLASS_ID, S.SCHOOL_NAME, SC.CLASS_NAME";
    private final String sqlSelectDrawing = "SELECT FILE_PATH FROM MATISTIKK.DRAWING WHERE ANSWER_ID = ?";
    private final String sqlSelectTestInfo = "SELECT T.TEST_ID, T.EMAIL_FK, (SELECT COUNT(*) FROM TEST_TASK TT WHERE TT.TEST_ID = T.TEST_ID) TASKS, T.ACTIVE FROM TEST T WHERE T.TESTABLE = ? AND T.EMAIL_FK = ?";
    private final String sqlAddTestTeacher = "INSERT INTO TEST_TEACHER VALUES (?, ?, FALSE)";
    private final String sqlAddTeacherClass = "INSERT INTO TEACHER_CLASS VALUES (?, ?)";
    private final String sqlSelectTeacherClass = "SELECT SC.CLASS_NAME FROM SCHOOL_CLASS SC INNER JOIN TEACHER_CLASS TC ON SC.CLASS_ID = TC.CLASS_ID WHERE TC.EMAIL_FK = ?";
    private final String sqlSelectTestTeacher = "SELECT T.TEST_ID FROM TEST T INNER JOIN TEST_TEACHER TT ON T.TEST_ID = TT.TEST_ID WHERE TT.EMAIL_FK = ?";
    private final String sqlSelectClasses = "SELECT SC.CLASS_ID, SC.CLASS_NAME, S.SCHOOL_NAME, COUNT(SI.EMAIL_FK) AS STUDENTS FROM SCHOOL_CLASS SC INNER JOIN SCHOOL S ON S.SCHOOL_ID = SC.SCHOOL_ID LEFT JOIN STUDENT_INFO SI ON SC.CLASS_ID = SI.CLASS_ID WHERE SC.CLASS_ID NOT IN (SELECT CLASS_ID FROM TEACHER_CLASS WHERE EMAIL_FK = ?) AND SC.SCHOOL_ID = ? GROUP BY SC.CLASS_ID, SC.CLASS_NAME, S.SCHOOL_NAME";
    private final String sqlSelectTeacher = "SELECT TI.*, U.ACTIVE FROM TEACHER_INFO TI INNER JOIN USERS U ON TI.EMAIL_FK = U.EMAIL WHERE TI.EMAIL_FK = ?";
    private final String sqlUpdateUserActive = "UPDATE USERS SET ACTIVE = ? WHERE EMAIL = ?";
    private final String sqlSelectTestTeachers = "SELECT TI.EMAIL_FK, TI.FIRSTNAME, TI.LASTNAME, SC.CLASS_NAME, S.SCHOOL_NAME, (SELECT COUNT(TT.TEST_ID) FROM TEST_TEACHER TT WHERE TT.EMAIL_FK = TI.EMAIL_FK) TEST_COUNT FROM TEACHER_INFO TI INNER JOIN TEACHER_CLASS TC ON TI.EMAIL_FK = TC.EMAIL_FK "
            + "INNER JOIN SCHOOL_CLASS SC ON TI.SCHOOL_ID = SC.SCHOOL_ID INNER JOIN SCHOOL S ON S.SCHOOL_ID = TI.SCHOOL_ID WHERE TI.EMAIL_FK NOT IN (SELECT EMAIL_FK FROM TEST_TEACHER WHERE TEST_ID = ?) AND SC.CLASS_ID = TC.CLASS_ID";
    private final String sqlCheckTests = "SELECT COUNT(*) FROM TEST_TEACHER TT WHERE TT.EMAIL_FK = ? AND TT.PUBLISHED = FALSE";
    private final String sqlSelectPublishTests = "SELECT TE.TEST_ID, TE.EMAIL_FK, COUNT(TTA.TASK_ID) AS TASKS, TE.ACTIVE FROM TEST TE INNER JOIN TEST_TEACHER TT  ON TE.TEST_ID = TT.TEST_ID INNER JOIN TEST_TASK TTA ON TE.TEST_ID = TTA.TEST_ID WHERE TT.PUBLISHED = FALSE AND TT.EMAIL_FK = ? GROUP BY TE.TEST_ID, TE.EMAIL_FK, TE.ACTIVE";
    private final String sqlSelectPublishClasses = "SELECT SC.CLASS_ID, S.SCHOOL_NAME, SC.CLASS_NAME, COUNT(SI.EMAIL_FK) AS STUDENTS FROM SCHOOL_CLASS SC INNER JOIN SCHOOL S ON SC.SCHOOL_ID = S.SCHOOL_ID INNER JOIN TEACHER_CLASS TC ON SC.CLASS_ID = TC.CLASS_ID LEFT JOIN STUDENT_INFO SI ON SC.CLASS_ID = SI.CLASS_ID WHERE TC.CLASS_ID IN (SELECT CLASS_ID FROM TEACHER_CLASS WHERE EMAIL_FK = ?)"
            + " AND TC.CLASS_ID NOT IN(SELECT CLASS_ID FROM TEST_CLASS WHERE TEST_ID = ?) AND SC.SCHOOL_ID = ? GROUP BY SC.CLASS_ID, SC.CLASS_NAME, S.SCHOOL_NAME";
    private final String sqlAddTestClass = "INSERT INTO TEST_CLASS VALUES(?, ?)";
    private final String sqlUpdateTestTeacher = "UPDATE TEST_TEACHER SET PUBLISHED = ? WHERE EMAIL_FK = ? AND TEST_ID = ?";
    private final String sqlSelectTestActive = "SELECT ACTIVE FROM TEST WHERE TEST_ID = ?";
    private final String sqlUpdateTestActive = "UPDATE TEST SET ACTIVE = ? WHERE TEST_ID = ?";
    private final String sqlSelectAllClassTeachers = "SELECT TI.EMAIL_FK, TI.FIRSTNAME, TI.LASTNAME, SC.CLASS_NAME, S.SCHOOL_NAME, (SELECT COUNT(TT.TEST_ID) FROM TEST_TEACHER TT WHERE TT.EMAIL_FK = TI.EMAIL_FK) TEST_COUNT FROM TEACHER_INFO TI INNER JOIN TEACHER_CLASS TC ON TI.EMAIL_FK = TC.EMAIL_FK "
            + "INNER JOIN SCHOOL_CLASS SC ON TI.SCHOOL_ID = SC.SCHOOL_ID INNER JOIN SCHOOL S ON S.SCHOOL_ID = TI.SCHOOL_ID WHERE SC.CLASS_ID = TC.CLASS_ID";
    private final String sqlSelectAllSchools = "SELECT S.SCHOOL_ID, S.SCHOOL_NAME, (SELECT COUNT(*) FROM SCHOOL_CLASS SC WHERE SC.SCHOOL_ID = S.SCHOOL_ID) AS CLASS_COUNT FROM SCHOOL S";
    private final String sqlAddSchool = "INSERT INTO SCHOOL(SCHOOL_NAME) VALUES (?)";
    private final String sqlSelectAllClasses = "SELECT SC.CLASS_ID, S.SCHOOL_NAME, SC.CLASS_NAME, (SELECT COUNT(*) FROM STUDENT_INFO SI WHERE SI.CLASS_ID = SC.CLASS_ID) AS STUDENTS FROM SCHOOL_CLASS SC INNER JOIN SCHOOL S ON SC.SCHOOL_ID = S.SCHOOL_ID WHERE SC.SCHOOL_ID = ?";
    private final String sqlAddClass = "INSERT INTO SCHOOL_CLASS(CLASS_NAME, SCHOOL_ID) VALUES (?, ?)";
    private final String sqlSelectStudentsClass = "SELECT SI.EMAIL_FK, COUNT(TS.TEST_ID) AS TEST_COUNT, SI.AGE, SI.SEX, S.SCHOOL_NAME, SC.CLASS_NAME, U.ACTIVE FROM STUDENT_INFO SI INNER JOIN USERS U ON SI.EMAIL_FK = U.EMAIL "
            + "LEFT JOIN SCHOOL_CLASS SC ON SI.CLASS_ID = SC.CLASS_ID INNER JOIN SCHOOL S ON SC.SCHOOL_ID = S.SCHOOL_ID "
            + "LEFT JOIN TEST_STUDENT TS ON SI.EMAIL_FK = TS.EMAIL_FK WHERE SI.CLASS_ID = ? GROUP BY SI.EMAIL_FK, SI.AGE, SI.SEX, S.SCHOOL_NAME, SC.CLASS_NAME, U.ACTIVE";
    /**
     * ******** GRUPPE 6**********
     */
    private final String sqlSelectFunctionAnswerType = "SELECT ANSWER_TYPE FROM FUNCTION_TASK WHERE TASK_ID = ?";
    private final String sqlAddFunctionAnswer = "INSERT INTO FUNCTION_ANSWER(FUNCTION_ANSWER_ID, ANSWER_ID, ANSWER_TEXT, ANSWER_BASE64, ANSWER_GEOLISTENER) VALUES (DEFAULT,?, ?, ?, ?)";
    private final String sqlUpdateFunctionAnswer = "UPDATE FUNCTION_ANSWER SET ANSWER_TEXT = ? WHERE ANSWER_ID = ?";
    private final String sqlSelectFunctionAnswer = "SELECT ANSWER_TEXT, ANSWER_BASE64, ANSWER_GEOLISTENER FROM FUNCTION_ANSWER WHERE ANSWER_ID = ?";
    private final String sqlAddFunctionSolution = "INSERT INTO FUNCTION_SOLUTION(FUNCTION_SOLUTION_ID, TASK_ID, SOLUTION) VALUES(DEFAULT, ?, ?)";
    private final String sqlAddFunctionTask = "INSERT INTO FUNCTION_TASK(FUNCTION_TASK_ID, TASK_ID, ANSWER_TYPE, FUNCTION_OPTIONS, CHECKBOX_EXPLANATION, CHECKBOX_DRAWING, URL, FUNCTION_STRING) VALUES (DEFAULT, ?, ?, ?, ?, ?, ?, ?)";
    private final String sqlSelectFunctionOptions = "SELECT FUNCTION_OPTIONS FROM FUNCTION_TASK WHERE TASK_ID = ?";
    private final String sqlSelectFunctionCheckboxes = "SELECT CHECKBOX_EXPLANATION, CHECKBOX_DRAWING FROM FUNCTION_TASK WHERE TASK_ID = ?";
    private final String sqlSelectFunctionUrl = "SELECT URL FROM FUNCTION_TASK WHERE TASK_ID = ?";
    private final String sqlSelectFunctionString = "SELECT FUNCTION_STRING FROM FUNCTION_TASK WHERE TASK_ID = ?";


    JdbcTemplate jdbcTemplate;
    public String url = "jdbc:derby://localhost:1527/Matistikk"; //[1]: Her skriver man inn adressen til databasen.
    public String username = "matistikk"; //[2]: Databasens brukernavn
    public String password = "matistikk"; //[3]: Databasens passord
    Connection con;
    DriverManagerDataSource dmds;

    public DatabaseRepository() {
    }

    //Dette er metoden som tar seg av å opprette en forbindelse til databasen
    @Bean
    public DataSource dataSource() {
        dmds = new DriverManagerDataSource(url, username, password);
        dmds.setDriverClassName("org.apache.derby.jdbc.ClientDriver"); //[4]: Driveren som skal tas i bruk
        try {
            con = dmds.getConnection(); //Oppretter forbindelsen
            this.jdbcTemplate = new JdbcTemplate(dmds);
        } catch (Exception e) {
        }
        return dmds;
    }

    //Denne metoden konfigurerer DefaultServletHandling
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    //Denne metoden oppretter en instans av UserServiceImpl
    @Bean
    public UserService studentService() {
        return new UserServiceImpl();
    }

    //Denne metoden legger til en student
    @Override
    public boolean addStudent(Student student) {
        String password = Mail.generate(); //Genererer et passord for studenten
        String description = "Student";
        Integer classId = null;
        int i = jdbcTemplate.update(sqlAddUser,
                new Object[]{student.getUsername(),
                    password,
                    description,
                    true});
        int j = jdbcTemplate.update(sqlAddStudentInfo,
                new Object[]{student.getUsername(),
                    student.age,
                    student.sex,
                    classId});
        if (i > 0 && j > 0) {
            Mail.sendEmail(student.getUsername(), password); //Sender passord via e-post til studentens e-postadresse
            return true;
        }
        return false;
    }

    //Denne metoden legger til en lærer
    @Override
    public boolean addTeacher(Teacher teacher) {
        String password = Mail.generate(); //Genererer et passord for læreren
        String description = "Teacher";
        int i = jdbcTemplate.update(sqlAddUser,
                new Object[]{teacher.getUsername(),
                    password,
                    description,
                    true});
        int j = jdbcTemplate.update(sqlAddTeacherInfo,
                new Object[]{teacher.getUsername(),
                    teacher.getFirstName(),
                    teacher.getLastName(),
                    teacher.getSchoolId()});
        if (i > 0 && j > 0) {
            Mail.sendEmail(teacher.getUsername(), password); //Sender passord via e-post til studentens e-postadresse
            return true;
        }
        return false;
    }

    //Denne metoden tar seg av innloggingen til en bruker
    @Override
    public User login(String username, String password) {
        User u;
        try {
            u = jdbcTemplate.queryForObject(sqlFindUser, new Object[]{username, password}, new UserMapper()); //Sjekker om brukeren med oppgitt brukernavn og passord finnes
            if (u instanceof Student) {
                u = (Student) jdbcTemplate.queryForObject(sqlSelectStudentInfo, new Object[]{u.getUsername()}, new StudentMapper());
            }
            if (u instanceof Teacher) {
                u = (Teacher) jdbcTemplate.queryForObject(sqlSelectTeacherInfo, new Object[]{u.getUsername()}, new TeacherMapper());
            }
        } catch (Exception e) {
            u = null;
        }
        return u;
    }

    //Denne metoden henter ut alle studentene i databasen
    @Override
    public List<StudentInfo> getAllStudents() {
        return jdbcTemplate.query(sqlSelectAllStudents, new StudentInfoMapper());
    }

    //Denne metoden henter ut alle lærerne i databasen
    @Override
    public List<TeacherInfo> getAllTeachers() {
        return jdbcTemplate.query(sqlSelectAllTeachers, new TeacherInfoMapper());
    }

    //Denne metoden henter ut en lærers informasjon basert på innsendt e-postadresse
    @Override
    public Teacher getTeacher(String email) {
        return (Teacher) jdbcTemplate.queryForObject(sqlSelectTeacher, new Object[]{email}, new TeacherMapper());
    }

    //Denne metoden genererer et nytt passord for brukeren med innsendt e-postadresse
    @Override
    public boolean forgotPassword(String username) {
        String password = Mail.generate(); //Genererer et passord for brukeren
        int i = jdbcTemplate.update(sqlChangePassword, new Object[]{password, username});
        if (i > 0) {
            Mail.sendEmail(username, password); //Sender e-posten til brukeren
            return true;
        } else {
            return false;
        }
    }

    //Denne metoden sjekker om det finnes en bruker med innsendt e-postadresse
    @Override
    public boolean findEmail(String username) {
        int i = jdbcTemplate.queryForObject(sqlFindEmail, new Object[]{username}, Integer.class);
        if (i > 0) {
            return true;
        }
        return false;
    }

    //Denne metoden endrer passord for innsendt bruker
    @Override
    public boolean changePassword(String newPassword, User user) {
        int i = jdbcTemplate.update(sqlChangePassword, new Object[]{newPassword, user.getUsername()});
        return i == 1;
    }

    //Denne metoden henter ut passordet til en bruker med innsendt e-postadresse
    @Override
    public String getPassword(String username) {
        String password = jdbcTemplate.queryForObject(sqlGetPassword, new Object[]{username}, String.class);
        return password;
    }

    //Denne metoden legger til en besvarelse
    @Override
    public boolean addAnswer(Test test) {
        try {
            Answer answer = test.getCurrentTask().getAnswer();
            PreparedStatement check = con.prepareStatement(sqlCheckAnswer);
            check.setInt(1, test.getId());
            check.setInt(2, test.getCurrentTask().getId());
            check.setString(3, answer.getEmail());
            ResultSet res = check.executeQuery(); //Sjekker her om oppgaven allerede er besvart
            if (res != null && res.next()) { //Hvis oppgaven allerede er besvart må vi oppdatere besvarelsen
                int id = res.getInt("answer_id");
                int i = jdbcTemplate.update(sqlUpdateAnswer, new Object[]{answer.getTime(), answer.isCorrect(), answer.getExplenation(), id}); //Oppdaterer besvarelsen
                if (i == 0) {
                    return false;
                }
                //Sjekker hvilken type oppgave besvarelsen tilhører
                if (answer instanceof AnswerSingleFraction) {
                    i = jdbcTemplate.update(sqlUpdateFractionAnswer, new Object[]{((AnswerSingleFraction) answer).getValue().getNumerator(), ((AnswerSingleFraction) answer).getValue().getDenominator(), id}); //Må oppdatere brøken assosiert med besvarelsen
                    if (i == 0) {
                        return false;
                    }
                } else if (answer instanceof AnswerMultipleFractions) {
                    SqlRowSet srs = jdbcTemplate.queryForRowSet(sqlSelectFractionAnswerId, new Object[]{id});
                    List<Integer> answerIds = new ArrayList<>();
                    while (srs.next()) {
                        answerIds.add(srs.getInt("fraction_answer_id"));
                    }
                    for (int j = 0; j < ((AnswerMultipleFractions) answer).getValue().length; j++) {
                        i = jdbcTemplate.update(sqlUpdateFractionAnswers, new Object[]{((AnswerMultipleFractions) answer).getValue()[j].getNumerator(), ((AnswerMultipleFractions) answer).getValue()[j].getDenominator(), answerIds.get(j)});
                        if (i == 0) {
                            return false;
                        }
                    }

                } else if (answer instanceof AnswerString) {
                    i = jdbcTemplate.update(sqlUpdateStringAnswer, new Object[]{((AnswerString) answer).getValue(), id});
                    if (i == 0) {
                        return false;
                    }
                } else if (answer instanceof AnswerFunction) {
                    i = jdbcTemplate.update(sqlUpdateFunctionAnswer, new Object[]{((AnswerFunction) answer).getValue(), id});
                    if (i == 0) {
                        return false;
                    }
                }
                addCoordinates(test.getId(), test.getCounter() + 1, id, answer.getEmail(), answer.getCoordinates()); //Legger til koordinatene for besvarelsen
                i = 0;
                if (!test.isStarted()) {
                    i = jdbcTemplate.update(sqlAddTestStudent, new Object[]{test.getId(), answer.getEmail(), false, test.getCounter() + 1});
                } else if (test.getCounter() == (test.getLength() - 1)) {
                    i = jdbcTemplate.update(sqlUpdateTestStudentComplete, new Object[]{true, test.getCounter() + 1, test.getId(), answer.getEmail()});
                } else if (test.getCounter() > 0 && test.getCounter() < (test.getLength() - 1)) {
                    i = jdbcTemplate.update(sqlUpdateTestStudent, new Object[]{test.getCounter() + 1, test.getId(), answer.getEmail()});
                }
                if (i == 0) {
                    return false;
                }

                return true;

            } else {
                PreparedStatement prep = con.prepareStatement(sqlAddAnswer, Statement.RETURN_GENERATED_KEYS);
                prep.setInt(1, test.getId());
                prep.setInt(2, test.getCurrentTask().getId());
                prep.setDouble(3, answer.getTime());
                prep.setBoolean(4, answer.isCorrect());
                prep.setString(5, answer.getEmail());
                prep.setString(6, answer.getExplenation());
                prep.execute();
                res = prep.getGeneratedKeys();
                if (res != null && res.next()) {
                    answer.setId(res.getInt(1));
                }
                if (answer.getTaskId() == 0) {
                    return false;
                }
                //Sjekker hvilken type oppgave besvarelsen tilhører
                if (answer instanceof AnswerSingleFraction) {
                    int i = jdbcTemplate.update(sqlAddFractionAnswer, new Object[]{answer.getId(), ((AnswerSingleFraction) answer).getValue().getNumerator(), ((AnswerSingleFraction) answer).getValue().getDenominator()});
                    if (i == 0) {
                        return false;
                    }
                } else if (answer instanceof AnswerMultipleFractions) {
                    for (int j = 0; j < ((AnswerMultipleFractions) answer).getValue().length; j++) {
                        int i = jdbcTemplate.update(sqlAddFractionAnswer, new Object[]{answer.getId(), ((AnswerMultipleFractions) answer).getValue()[j].getNumerator(), ((AnswerMultipleFractions) answer).getValue()[j].getDenominator()});
                        if (i == 0) {
                            return false;
                        }
                    }

                } else if (answer instanceof AnswerString) {
                    int i = jdbcTemplate.update(sqlAddStringAnswer, new Object[]{answer.getId(), ((AnswerString) answer).getValue()});
                    if (i == 0) {
                        return false;
                    }
                } else if (answer instanceof AnswerFunction) {
                    int i = jdbcTemplate.update(sqlAddFunctionAnswer, new Object[]{answer.getId(), ((AnswerFunction) answer).getValue(), ((AnswerFunction) answer).getGeoBase64(), ((AnswerFunction) answer).getGeoListener()});
                    if (i == 0) {
                        return false;
                    }
                }
                addCoordinates(test.getId(), test.getCounter() + 1, answer.getId(), answer.getEmail(), answer.getCoordinates());
                int i = 0;
                if (test.getCounter() == 0) {
                    boolean b = test.getLength() == 1;
                    i = jdbcTemplate.update(sqlAddTestStudent, new Object[]{test.getId(), answer.getEmail(), b, test.getCounter() + 1});
                } else if (test.getCounter() == (test.getLength() - 1)) {
                    i = jdbcTemplate.update(sqlUpdateTestStudentComplete, new Object[]{true, test.getCounter() + 1, test.getId(), answer.getEmail()});
                } else if (test.getCounter() > 0 && test.getCounter() < (test.getLength() - 1)) {
                    i = jdbcTemplate.update(sqlUpdateTestStudent, new Object[]{test.getCounter() + 1, test.getId(), answer.getEmail()});
                }
                if (i == 0) {
                    return false;
                }
            }
            return true;
        } catch (Exception e) {
        }
        return false;
    }

    //Denne metoden henter ut en besvarelse basert på innsendt e-postadrese, en tests id og en oppgaves id
    @Override
    public Answer getAnswer(String email, int testId, int taskId) {

        ResultSet res;
        Answer answer = null;
        SqlRowSet srs;
        try {
            answer = jdbcTemplate.queryForObject(sqlSelectAnswer, new Object[]{email, testId, taskId}, new AnswerMapper());
            //Sjekker hvilken type oppgave besvarelsen tilhører
            if (answer instanceof AnswerSingleFraction) {
                srs = jdbcTemplate.queryForRowSet(sqlSelectFractionAnswer, new Object[]{answer.getId()});
                Fraction f = null;
                while (srs.next()) {
                    f = new Fraction(srs.getInt("numerator"), srs.getInt("denominator"));
                }
                ((AnswerSingleFraction) answer).setValue(f);

            } else if (answer instanceof AnswerMultipleFractions) {
                ArrayList<Fraction> fractionList = new ArrayList<>();
                srs = jdbcTemplate.queryForRowSet(sqlSelectFractionAnswer, new Object[]{answer.getId()});
                while (srs.next()) {
                    Fraction f = new Fraction(srs.getInt("numerator"), srs.getInt("denominator"));
                    fractionList.add(f);
                }
                Fraction[] fractions = new Fraction[fractionList.size()];
                fractions = fractionList.toArray(fractions);
                ((AnswerMultipleFractions) answer).setFractions(fractions);
            } else if (answer instanceof AnswerString) {
                String s = null;
                srs = jdbcTemplate.queryForRowSet(sqlSelectStringAnswer, new Object[]{answer.getId()});
                while (srs.next()) {
                    s = srs.getString("url");
                }
                ((AnswerString) answer).setValue(s);
            } /**
             * ***** GRUPPE 6 *****
             */
            else if (answer instanceof AnswerFunction) {
                String s = null;
                String a = null;
                String g = null;
                srs = jdbcTemplate.queryForRowSet(sqlSelectFunctionAnswer, new Object[]{answer.getId()});
                while (srs.next()) {
                    s = srs.getString("answer_text");
                    a = srs.getString("answer_base64");
                    g = srs.getString("answer_geolistener");
                }
                ((AnswerFunction) answer).setValue(s);
                ((AnswerFunction) answer).setGeoBase64(a);
                ((AnswerFunction) answer).setGeoListener(g);
            }

        } catch (Exception e) {
        }
        return answer;
    }

    //Denne metoden legger til en oppgave
    @Override
    public boolean addTask(Task task, boolean type) {
        try {
            PreparedStatement prep = con.prepareStatement(sqlAddTask, Statement.RETURN_GENERATED_KEYS);
            ResultSet res;
            //Sjekker hvilken oppgavetype oppgaven er
            if (task instanceof Arithmetic) {
                prep.setInt(1, 1);
                prep.setString(2, task.getText());
                prep.setBoolean(3, type);
                prep.setString(4, task.getUsername());
                prep.execute();
                res = prep.getGeneratedKeys();
                if (res != null && res.next()) {
                    task.setId(res.getInt(1));
                }
                if (task.getId() == 0) {
                    return false;
                }
                Fraction f = ((Arithmetic) task).getSolution();
                int i = jdbcTemplate.update(sqlAddFractionSolution, new Object[]{task.getId(), f.getNumerator(), f.getDenominator()});
                if (i != 0) {
                    return true;
                }
            } else if (task instanceof SingleChoice) {
                prep.setInt(1, 2);
                prep.setString(2, task.getText());
                prep.setBoolean(3, type);
                prep.setString(4, task.getUsername());
                prep.execute();
                res = prep.getGeneratedKeys();
                if (res != null && res.next()) {
                    task.setId(res.getInt(1));
                }
                if (task.getId() == 0) {
                    return false;
                }
                for (int i = 0; i < ((SingleChoice) task).getChoices().length; i++) {
                    int j = jdbcTemplate.update(sqlAddFractionTask, new Object[]{task.getId(), ((SingleChoice) task).getChoices()[i].getNumerator(), ((SingleChoice) task).getChoices()[i].getDenominator()});
                    if (j == 0) {
                        return false;
                    }
                }
                Fraction f = ((SingleChoice) task).getSolution();
                int i = jdbcTemplate.update(sqlAddFractionSolution, new Object[]{task.getId(), f.getNumerator(), f.getDenominator()});
                if (i != 0) {
                    return true;
                }
            } else if (task instanceof Sort) {
                prep.setInt(1, 3);
                prep.setString(2, task.getText());
                prep.setBoolean(3, type);
                prep.setString(4, task.getUsername());
                prep.execute();
                res = prep.getGeneratedKeys();
                if (res != null & res.next()) {
                    task.setId(res.getInt(1));
                }
                if (task.getId() == 0) {
                    return false;
                }
                for (int i = 0; i < ((Sort) task).getFractions().length; i++) {
                    int j = jdbcTemplate.update(sqlAddFractionTask, new Object[]{task.getId(), ((Sort) task).getFractions()[i].getNumerator(), ((Sort) task).getFractions()[i].getDenominator()});
                    if (j == 0) {
                        return false;
                    }
                }
                Fraction[] solution = ((Sort) task).getSolution();
                for (int i = 0; i < solution.length; i++) {
                    int j = jdbcTemplate.update(sqlAddFractionSolution, new Object[]{task.getId(), solution[i].getNumerator(), solution[i].getDenominator()});
                    if (j == 0) {
                        return false;
                    }
                }
                return true;
            } else if (task instanceof NumberLine) {
                prep.setInt(1, 4);
                prep.setString(2, task.getText());
                prep.setBoolean(3, type);
                prep.setString(4, task.getUsername());
                prep.execute();
                res = prep.getGeneratedKeys();
                if (res != null && res.next()) {
                    task.setId(res.getInt(1));
                }
                if (task.getId() == 0) {
                    return false;
                }

                Fraction f = ((NumberLine) task).getSolution();
                int i = jdbcTemplate.update(sqlAddFractionSolution, new Object[]{task.getId(), f.getNumerator(), f.getDenominator()});
                if (i != 0) {
                    return true;
                }
            } else if (task instanceof Figures) {
                prep.setInt(1, 5);
                prep.setString(2, task.getText());
                prep.setBoolean(3, type);
                prep.setString(4, task.getUsername());
                prep.execute();
                res = prep.getGeneratedKeys();
                if (res != null && res.next()) {
                    task.setId(res.getInt(1));
                }
                if (task.getId() == 0) {
                    return false;
                }
                int j = jdbcTemplate.update(sqlAddStringTask, new Object[]{task.getId(), ((Figures) task).getFigureUrl()});
                if (j == 0) {
                    return false;
                }
                int i = jdbcTemplate.update(sqlAddStringSolution, new Object[]{task.getId(), ((Figures) task).getSolutionUrl()});
                if (i != 0) {
                    return true;
                }

                ///*****************GRUPPE 6 REDIGERER*************************//
            } else if (task instanceof Function) {
                prep.setInt(1, 6);
                prep.setString(2, task.getText());
                prep.setBoolean(3, type);
                prep.setString(4, task.getUsername());
                prep.execute();
                res = prep.getGeneratedKeys();
                if (res != null && res.next()) {
                    task.setId(res.getInt(1));
                }
                if (task.getId() == 0) {
                    return false;
                }
                if (((Function) task).getAnswerType() == 2) {
                    for (int i = 0; i < ((Function) task).getChoices().size(); i++) {

                        int j = jdbcTemplate.update(sqlAddFunctionTask, new Object[]{task.getId(), ((Function) task).getAnswerType(), ((Function) task).getChoices().get(i),
                            ((Function) task).isChecked1(), ((Function) task).isChecked2(), ((Function) task).getUrl(), ((Function) task).getFunctionstring()});


                        if (j == 0) {
                            return false;
                        }
                    }
                } else {
                    int j = jdbcTemplate.update(sqlAddFunctionTask, new Object[]{task.getId(), ((Function) task).getAnswerType(), null,
                        ((Function) task).isChecked1(), ((Function) task).isChecked2(), ((Function) task).getUrl(), ((Function) task).getFunctionstring()});

                    if (j == 0) {
                        return false;
                    }
                }

                int i = jdbcTemplate.update(sqlAddFunctionSolution, new Object[]{task.getId(), ((Function) task).getSolution()});
                if (i != 0) {
                    return true;
                }
            }

        } catch (Exception e) {
        }
        return false;
    }

    //Denne metoden henter ut informasjon om alle oppgaver av innsendt type (øvingsoppgave eller forskningsoppgave)
    @Override
    public List<TaskInfo> getAllTasks(boolean type) {
        return jdbcTemplate.query(sqlSelectTaskInfo, new Object[]{type}, new TaskInfoExtractor());
    }

    //Denne metoden henter ut en oppgave med innsendt id
    @Override
    public Task getTask(int id) {
        Task task = null;
        SqlRowSet srs;
        try {
            task = (Task) jdbcTemplate.queryForObject(sqlSelectTask, new Object[]{id}, new TaskMapper());
            //Sjekker hvilken oppgavetype oppgaven er
            if (task instanceof Arithmetic) {
                srs = jdbcTemplate.queryForRowSet(sqlSelectFractionSolution, new Object[]{id});
                while (srs.next()) {
                    ((Arithmetic) task).setSolution(new Fraction(srs.getInt("numerator"), srs.getInt("denominator")));
                }
            } else if (task instanceof SingleChoice) {
                srs = jdbcTemplate.queryForRowSet(sqlSelectFractionTask, new Object[]{id});
                ArrayList<Fraction> list = new ArrayList<>();
                while (srs.next()) {
                    list.add(new Fraction(srs.getInt("numerator"), srs.getInt("denominator")));
                }
                srs = jdbcTemplate.queryForRowSet(sqlSelectFractionSolution, new Object[]{id});
                Fraction solution = null;
                while (srs.next()) {
                    solution = new Fraction(srs.getInt("numerator"), srs.getInt("denominator"));
                }
                Fraction[] choices = new Fraction[list.size()];
                choices = list.toArray(choices);
                ((SingleChoice) task).setChoices(choices);
                ((SingleChoice) task).setSolution(solution);
            } else if (task instanceof Sort) {
                srs = jdbcTemplate.queryForRowSet(sqlSelectFractionTask, new Object[]{id});
                ArrayList<Fraction> choicesList = new ArrayList<>();
                while (srs.next()) {
                    choicesList.add(new Fraction(srs.getInt("numerator"), srs.getInt("denominator")));
                }
                srs = jdbcTemplate.queryForRowSet(sqlSelectFractionSolution, new Object[]{id});
                ArrayList<Fraction> solutionList = new ArrayList<>();
                while (srs.next()) {
                    solutionList.add(new Fraction(srs.getInt("numerator"), srs.getInt("denominator")));
                }
                Fraction[] choices = new Fraction[choicesList.size()];
                choices = choicesList.toArray(choices);
                Fraction[] solution = new Fraction[solutionList.size()];
                solution = solutionList.toArray(solution);
                ((Sort) task).setFractions(choices);
                ((Sort) task).setSolution(solution);
            } else if (task instanceof NumberLine) {
                srs = jdbcTemplate.queryForRowSet(sqlSelectFractionSolution, new Object[]{id});
                while (srs.next()) {
                    ((NumberLine) task).setSolution(new Fraction(srs.getInt("numerator"), srs.getInt("denominator")));
                }
            } else if (task instanceof Figures) {
                srs = jdbcTemplate.queryForRowSet(sqlSelectStringTask, new Object[]{id});
                while (srs.next()) {
                    ((Figures) task).setFigureUrl(srs.getString("url"));
                }
                srs = jdbcTemplate.queryForRowSet(sqlSelectStringSolution, new Object[]{id});
                while (srs.next()) {
                    ((Figures) task).setSolutionUrl(srs.getString("url"));
                }
            } /**
             * ***** GRUPPE 6 *******
             */
            else if (task instanceof Function) {
                srs = jdbcTemplate.queryForRowSet(sqlSelectFunctionAnswerType, new Object[]{id});
                while (srs.next()) {
                    ((Function) task).setAnswerType(srs.getInt("answer_type"));
                }
                srs = jdbcTemplate.queryForRowSet(sqlSelectFunctionCheckboxes, new Object[]{id});
                while (srs.next()) {
                    boolean b = srs.getBoolean("checkbox_explanation");
                    if (b){
                        ((Function) task).setExplanationChecked();
                    }
                    else{
                        ((Function) task).setExplanationUnchecked();
                    }
                    
                    boolean b1 = srs.getBoolean("checkbox_drawing");
                    if (b1){
                        ((Function) task).setDrawingChecked();
                    }
                    else{
                        ((Function) task).setDrawingUnchecked();
                    }
                }
                ArrayList<String> list = new ArrayList<>();
                srs = jdbcTemplate.queryForRowSet(sqlSelectFunctionOptions, new Object[]{id});
                while (srs.next()) {

                    list.add(srs.getString("function_options"));
                }
                ((Function) task).setChoices(list);
                
                srs = jdbcTemplate.queryForRowSet(sqlSelectFunctionUrl, new Object[]{id});
                while (srs.next()) {
                    ((Function) task).setUrl(srs.getString("url"));
                }
                srs = jdbcTemplate.queryForRowSet(sqlSelectFunctionString, new Object[]{id});
                while (srs.next()) {
                    ((Function) task).setFunctionstring(srs.getString("function_string"));
                }
            }
        } catch (Exception e) {
        }
        return task;
    }

    //Denne metoden henter ut informasjon om alle forskningstester som er tilknyttet en klasse id, og som ikke er fullført av innsendt e-postadresse
    @Override
    public List<TestInfo> getAllTests(String email, int classId) {
        return jdbcTemplate.query(sqlSelectTests, new Object[]{email, email, classId}, new TestInfoExtractor());
    }

    //Denne metoden henter ut informasjon om alle øvingstester som er tilknyttet en klasse id, og som ikke er fullført av innsendt e-postadresse
    @Override
    public List<TestInfo> getAllPractiseTests(String email, int classId) {
        return jdbcTemplate.query(sqlSelectPracticeTests, new Object[]{email, email, classId}, new TestInfoExtractor());
    }

    //Denne metoden henter ut informasjon om en oppgave basert på innsendt id
    @Override
    public TaskInfo getTaskInfoId(int id) {
        return jdbcTemplate.queryForObject(sqlSelectTaskInfoId, new Object[]{id}, new TaskInfoMapper());
    }

    //Denne metoden henter ut en test basert på innsendt id og e-postadresse
    @Override
    public Test getTest(int id, String email) {
        Test test = null;
        SqlRowSet srs;
        try {
            test = (Test) jdbcTemplate.queryForObject(sqlSelectTest, new Object[]{id}, new TestMapper());
            srs = jdbcTemplate.queryForRowSet(sqlSelectTestTask, new Object[]{id});
            ArrayList<Task> taskIdList = new ArrayList<>();
            int counter = 0;
            while (srs.next()) {
                Task t = getTask(srs.getInt("task_id")); //Henter ut oppgave tilknyttet testen
                Answer a = null;
                try {
                    a = getAnswer(email, id, t.getId()); //Henter ut besvarelse tilknyttet testen
                } catch (NullPointerException e) {

                }
                if (a != null) {
                    t.setAnswer(a); //Legger til besvarelsen i oppgaven
                    counter++;
                }
                taskIdList.add(t); //Legger til oppgaven i en liste
            }
            Task[] tasks = new Task[]{};
            tasks = taskIdList.toArray(tasks);
            test.setTasks(tasks); //Legger til oppgavene
            test.setCounter(counter);
        } catch (Exception e) {
        }
        return test;
    }

    //Denne metoden legger til en test
    @Override
    public int addTest(Test test, List<Integer> taskIds, boolean type) {
        int testId = 0;
        try {
            PreparedStatement prep = con.prepareStatement(sqlAddTest, Statement.RETURN_GENERATED_KEYS);
            prep.setString(1, test.getTeacher());
            prep.setBoolean(2, test.isActive());
            prep.setBoolean(3, type);
            prep.execute();
            ResultSet res = prep.getGeneratedKeys();
            while (res != null && res.next()) {
                testId = res.getInt(1);
                test.setId(testId);
            }
            for (int i = 0; i < taskIds.size(); i++) {
                int j = jdbcTemplate.update(sqlAddTestTask, new Object[]{test.getId(), taskIds.get(i)});
                if (j == 0) {
                    return 0;
                }
            }
            if (!type) {
                SqlRowSet srs = jdbcTemplate.queryForRowSet(sqlSelectTeacherClasses, new Object[]{test.getTeacher()});
                while (srs.next()) {
                    int k = jdbcTemplate.update(sqlAddTestClass, new Object[]{test.getId(), srs.getInt("class_id")});
                }
            }
        } catch (Exception e) {
        }
        return testId;
    }

    //Denne metoden tar seg av eksporteringen av en test med innsendt id
    @Override
    public void exportTest(int id) throws FileNotFoundException, IOException, SQLException {
        Workbook wb = new HSSFWorkbook();
        Sheet testSheet = wb.createSheet("Oversikt"); //Lager et Excel-ark som skal inneholde den generelle oversikten for testen.

        int testRow = 1;
        int column = 1;
        Row testIdRow = testSheet.createRow(0);
        Cell testIdCell = testIdRow.createCell(0);
        testIdCell.setCellValue("Test " + id);
        Row testHeaderRow = testSheet.createRow(testRow);
        Cell emailTestCell = testHeaderRow.createCell(0);
        emailTestCell.setCellValue("Brukernavn");
        SqlRowSet srs = jdbcTemplate.queryForRowSet(sqlSelectTestUsers, new Object[]{id}); //Henter ut alle brukerne som har tatt testen
        testRow++;
        while (srs.next()) { //Går gjennom alle brukerne og henter ut deres resultat i testen
            Row testDataRow = testSheet.createRow(testRow);
            int correct = 0;
            int wrong = 0;
            String s = srs.getString("email_fk");
            column = 1;
            Cell emailTestDataCell = testDataRow.createCell(0);
            emailTestDataCell.setCellValue(s);
            SqlRowSet srset = jdbcTemplate.queryForRowSet(sqlSelectTestUsersResult, new Object[]{s, id}); //Henter ut resultatet for hver oppgave i testen for hver enkelt bruker.

            while (srset.next()) {
                Cell taskTestHeaderCell = testHeaderRow.createCell(column);
                taskTestHeaderCell.setCellValue("Oppgave " + srset.getInt("task_id"));
                Cell taskTestDataCell = testDataRow.createCell(column);

                boolean b = srset.getBoolean("correct");
                if (b) { //Setter her de verdiene som kan eksporteres til andre programmer, og summerer antall riktige og gale svar for hver bruker.
                    taskTestDataCell.setCellValue("1");
                    correct++;
                } else {
                    taskTestDataCell.setCellValue("0");
                    wrong++;
                }

                testSheet.autoSizeColumn(column);
                column++;
            }

            /*Her settes annen relevant informasjon som antall riktige og gale svar, samt den totale tiden brukeren har brukt på hele testen. */
            Cell correctTestDataCell = testDataRow.createCell(column);
            correctTestDataCell.setCellValue(correct);
            Cell wrongTestDataCell = testDataRow.createCell(column + 1);
            wrongTestDataCell.setCellValue(wrong);
            Cell timeTestDataCell = testDataRow.createCell(column + 2);
            timeTestDataCell.setCellValue(srs.getDouble("test_time"));
            testRow++;
        }

        Cell correctTestDataCell = testHeaderRow.createCell(column);
        correctTestDataCell.setCellValue("Antall korrekt");
        Cell wrongTestDataCell = testHeaderRow.createCell(column + 1);
        wrongTestDataCell.setCellValue("Antall feil");
        Cell timeTestDataCell = testHeaderRow.createCell(column + 2);
        timeTestDataCell.setCellValue("Tid brukt i sekunder");

        testSheet.autoSizeColumn(0);
        testSheet.autoSizeColumn(column);
        testSheet.autoSizeColumn(column + 1);
        testSheet.autoSizeColumn(column + 2);

        /* Har nå satt all informasjon som skal være i test-oversikten. Tar da for oss de individuelle oppgavene. */
        List<TaskSolution> taskSolutions = jdbcTemplate.query(sqlSelectTaskSolution, new Object[]{id}, new TaskSolutionExtractor());
        int task = 1;
        for (TaskSolution ts : taskSolutions) {
            int taskRow = 0;
            Sheet taskSheet = wb.createSheet("Oppgave" + task);
            Row taskHeaderRow = taskSheet.createRow(taskRow);
            Cell taskTextHeaderCell = taskHeaderRow.createCell(0);
            taskTextHeaderCell.setCellValue(ts.getText());
            Cell solutionHeaderCell = taskHeaderRow.createCell(1);
            solutionHeaderCell.setCellValue(ts.getSolutionString());
            List<TaskAnswer> taskAnswers = jdbcTemplate.query(sqlSelectTaskSummary, new Object[]{id, ts.getId()}, new TaskAnswerExtractor());

            taskRow++;
            taskHeaderRow = taskSheet.createRow(taskRow);
            Cell emailTaskHeaderCell = taskHeaderRow.createCell(0);
            emailTaskHeaderCell.setCellValue("Brukernavn");
            Cell answerHeaderCell = taskHeaderRow.createCell(1);
            answerHeaderCell.setCellValue("Svar");
            Cell correctHeaderCell = taskHeaderRow.createCell(2);
            correctHeaderCell.setCellValue("Korrekt");
            Cell explenationHeaderCell = taskHeaderRow.createCell(3);
            explenationHeaderCell.setCellValue("Forklaring");
            Cell timeHeaderCell = taskHeaderRow.createCell(4);
            timeHeaderCell.setCellValue("Tid brukt i sekunder");

            taskRow++;
            for (TaskAnswer ta : taskAnswers) {
                Row dataRow = taskSheet.createRow(taskRow);
                Cell emailDataCell = dataRow.createCell(0);
                emailDataCell.setCellValue(ta.getEmail());
                Cell answerDataCell = dataRow.createCell(1);
                answerDataCell.setCellValue(ta.getAnswerString());
                Cell correctDataCell = dataRow.createCell(2);
                correctDataCell.setCellValue(ta.getCorrect());
                Cell explenationDataCell = dataRow.createCell(3);
                explenationDataCell.setCellValue(ta.getExplenation());
                Cell timeDataCell = dataRow.createCell(4);
                timeDataCell.setCellValue(ta.getTime());
                taskRow++;
            }
            taskSheet.autoSizeColumn(0);
            taskSheet.autoSizeColumn(1);
            taskSheet.autoSizeColumn(2);
            taskSheet.autoSizeColumn(3);
            taskSheet.autoSizeColumn(4);

            task++;
        }
        String outputDirPath = "D:/Dokumenter/Documents/Matistikk/Test" + id; //[5]: Setter hvor på serveren filen skal lagres
        File dir = new File(outputDirPath);
        if (!dir.exists()) {
            if (!dir.mkdirs()) {
            }
        }
        outputDirPath += "/Test" + id + ".xls";
        File file = new File(outputDirPath);
        if (file.exists()) {
            file.delete();
        }
        FileOutputStream out = new FileOutputStream(outputDirPath);
        wb.write(out);
        out.close();
    }

    /*
     Denne metoden tar seg av zippingen av valgte tester.
    
     Koden tar i bruk biblioteket ZeroTurnaround ZIP Library som man finner på: https://github.com/zeroturnaround/zt-zip [Besøkt 23.05.16]
     */
    @Override
    public String zipTests(List<Integer> testIds) {
        String path = "";
        String dstPath = "D:\\Dokumenter\\Documents\\Matistikk\\ZipFolder"; //[6]: Midlertidig mappestruktur som vil tas i bruk av .zip-filen
        try {
            File file = new File("D:\\Dokumenter\\Documents\\Matistikk\\Matistikk.zip"); //[7]: Setter hvor på serveren .zip-filen skal lagres
            if (file.exists()) {
                file.delete();
            }
            File dst = new File(dstPath);
            for (Integer id : testIds) {
                exportTest(id);
                try {
                    copyFolder(new File("D:\\Dokumenter\\Documents\\Matistikk\\Test" + id), dst); //[8]: Kopiering av mappe
                } catch (IOException e) {
                }
            }
            ZipUtil.pack(dst, file);
            path = "D:\\Dokumenter\\Documents\\Matistikk\\Matistikk.zip"; //[9]: Sier hvor på serveren .zip-filen er lagret
            FileUtils.deleteDirectory(dst);
        } catch (Exception e) {

        }
        return path;
    }

    /*
     Denne metoden er en hjelpemetode for zipping av statistikk.
    
     Hentet fra: http://www.mkyong.com/java/how-to-copy-directory-in-java/ [Besøkt: 23.05.15]
     */
    static void copyFolder(File src, File dest) throws IOException {
        if (src.isDirectory()) {
            if (!dest.exists()) {
                dest.mkdir();
            }
            String files[] = src.list();

            for (String file : files) {
                File srcFile = new File(src, file);
                File destFile = new File(dest, file);
                copyFolder(srcFile, destFile);
            }
        } else {
            InputStream in = new FileInputStream(src);
            OutputStream out = new FileOutputStream(dest);

            byte[] buffer = new byte[4096];

            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }

            in.close();
            out.close();
        }
    }

    //Denne metoden sjekker om klassen med innsendt id eksisterer
    @Override
    public boolean checkClass(int id) {
        try {
            int i = jdbcTemplate.queryForObject(sqlCheckClass, new Object[]{id}, Integer.class);
            return i == 1;
        } catch (Exception e) {
            return false;
        }
    }

    //Henter ut inforamsjon om klassen med innsendt id
    @Override
    public ClassInfo getSchoolClass(int id) {
        return jdbcTemplate.queryForObject(sqlSelectClass, new Object[]{id}, new ClassInfoMapper());
    }

    //Henter ut tegnekoordinatene som er tilknyttet besvarelsen med innsendt id
    @Override
    public List<Double> getCoordinates(int answerId) {
        List<Double> list = null;
        BufferedReader br = null;
        try {
            String s = jdbcTemplate.queryForObject(sqlSelectDrawing, new Object[]{answerId}, String.class); //Henter ut plasseringen til filen med tegnekoordinatene på serveren
            String currentLine;
            if (s != null) {
                br = new BufferedReader(new FileReader(s));
                list = new ArrayList<Double>(); //Oppretter listen med koordinatene
                while ((currentLine = br.readLine()) != null) {
                    list.add(Double.parseDouble(currentLine)); //Legger til koordinatene i listen
                }
            }
        } catch (Exception e) {
        } finally {
            try {
                if (br != null) {
                    br.close();
                }
            } catch (Exception e) {

            }
        }
        return list;
    }

    //Denne metoden legger til tegnekoordinatene
    @Override
    public boolean addCoordinates(int testId, int taskId, int answerId, String email, List<Double> cords) {
        FileWriter fw = null;
        BufferedWriter bw = null;
        try {
            boolean b = false;
            String s = "D:\\Dokumenter\\Documents\\Matistikk\\Test" + testId + "\\Test" + testId + "\\Oppgave" + taskId + "\\" + email; //[10]: Velger hvor på serveren .txt-filen med koordinatene skal lagres
            File dir = new File(s);
            if (!dir.exists()) {
                if (!dir.mkdirs()) {
                    return false;
                }
            }
            String path = s + "\\tegning.txt";
            File file = new File(dir, "tegning.txt"); //Oppretter tegnekoordinatfilen
            if (file.exists()) {
                file.delete();
            }
            file = new File(dir, "tegning.txt");
            fw = new FileWriter(file);
            bw = new BufferedWriter(fw);
            for (int i = 0; i < cords.size(); i++) {
                bw.write(cords.get(i).toString());
                bw.newLine();
            }
            try {
                jdbcTemplate.update(sqlAddDrawing, new Object[]{answerId, path}); //Legger til plasseringen på .txt-filen i databasen
            } catch (Exception e) {
            }
            return true;
        } catch (Exception e) {
            return false;
        } finally {
            try {
                bw.close();
                fw.close();
            } catch (IOException ex) {

            }
        }
    }

    //Denne metoden henter ut antall besvarte tester basert på innsendt e-postadresse
    @Override
    public String getTestCount(String username, boolean completed, boolean testable) {
        return jdbcTemplate.queryForObject(sqlSelectCountTestsTaken, new Object[]{username, completed, testable}, String.class);
    }

    //Denne metoden henter ut antall tester laget av læreren med innsendt e-postadresse
    @Override
    public String getTestMadeCount(String username) {
        String s = jdbcTemplate.queryForObject(sqlSelectCountTestsMade, new Object[]{username}, String.class);
        return s;
    }

    //Denne metoden henter ut statistikken til alle testene av innsendt type (forskningstest eller øvingstest)
    @Override
    public List<TestStatistics> getStatistics(boolean type) {
        return jdbcTemplate.query(sqlSelectStatistics, new Object[]{type}, new TestStatisticsMapper());
    }

    //Denne metoden henter ut statistikken til alle oppgavene som er tilknyttet innsendt test id
    @Override
    public List<TaskStatistics> getTestStatistics(int testId) {
        return jdbcTemplate.query(sqlSelectTestStatistics, new Object[]{testId}, new TaskStatisticsMapper());
    }

    //Denne metoden henter ut statistikken til alle besvarelsene som er tilknyttet innsendt test id og oppgave id
    @Override
    public List<TaskAnswer> getTaskStatistics(int testId, int taskId) {
        return jdbcTemplate.query(sqlSelectTaskStatistics, new Object[]{testId, taskId}, new AnswerStatisticsMapper());
    }

    //Denne metoden oppdaterer hvilken klasse brukeren med innsendt e-postadresse er tilknyttet
    @Override
    public boolean updateClassId(int classId, String username) {
        int i = jdbcTemplate.update(sqlUpdateClassId, new Object[]{classId, username});
        return i > 1;
    }

    //Denne metoden henter ut informasjon om alle testene av innsendt type (forskningstest eller øvingstest) som er opprettet av brukeren med innsendt e-postadresse
    @Override
    public List<TestInfo> getAllTestInfo(boolean type, String username) {
        return jdbcTemplate.query(sqlSelectTestInfo, new Object[]{type, username}, new TestInfoMapper());
    }

    //Denne metoden henter ut alle tester som kan publiseres av læreren med innsendt e-postadresse
    @Override
    public List<Integer> getTestTeacher(String email) {
        return (List<Integer>) jdbcTemplate.queryForList(sqlSelectTestTeacher, new Object[]{email}, Integer.class);
    }

    //Denne metoden oppretter en forbindelse mellom læreren med innsendt e-postadresse og klassene med innsendt id
    @Override
    public boolean addTeacherClasses(String email, List<Integer> classes) {
        for (Integer i : classes) {
            int j = jdbcTemplate.update(sqlAddTeacherClass, new Object[]{email, i});
            if (j == 0) {
                return false;
            }
        }
        return true;
    }

    //Denne metoden henter ut alle klassene som er tilknyttet med læreren med innsendt e-postadresse
    @Override
    public List<String> getTeacherClass(String email) {
        return (List<String>) jdbcTemplate.queryForList(sqlSelectTeacherClass, new Object[]{email}, String.class);
    }

    //Denne metoden henter ut informasjon om alle klassene som ikke allerede er tilknyttet læreren med innsendt e-postadresse men som er tilknyttet lærerens skole
    @Override
    public List<ClassInfo> getAllClassesInfo(String email, int schoolId) {
        return (List<ClassInfo>) jdbcTemplate.query(sqlSelectClasses, new Object[]{email, schoolId}, new ClassInfoMapper());
    }

    //Denne metoden setter aktivstatusen til brukeren med innsendt e-postadresse
    @Override
    public boolean setUserActive(String email, boolean active) {
        int i = jdbcTemplate.update(sqlUpdateUserActive, new Object[]{active, email});
        return i == 1;
    }

    //Denne metoden henter ut statistikken om lærerene som er tilknyttet testen med innsendt id
    @Override
    public List<TeacherStatistics> getTestTeachers(int testId) {
        return jdbcTemplate.query(sqlSelectTestTeachers, new Object[]{testId}, new TeacherStatisticsExtractor());
    }

    //Denne metoden legger til en hvilke lærere som kan publisere testen med innsendt test id
    @Override
    public boolean addTestTeachers(int testId, List<String> teachers) {
        for (String s : teachers) {
            int i = jdbcTemplate.update(sqlAddTestTeacher, new Object[]{testId, s});
            if (i == 0) {
                return false;
            }
        }
        return true;
    }

    //Denne metoden sjekker om læreren med innsendt e-postadresse har upuliserte tester
    @Override
    public boolean checkPublishTests(String email) {
        boolean b = false;
        try {
            b = jdbcTemplate.queryForObject(sqlCheckTests, new Object[]{email}, Integer.class) > 0;
        } catch (Exception e) {
        }
        return b;
    }

    //Denne metoden henter de upubliserte testene for læreren med innsendt e-postadresse
    @Override
    public List<TestInfo> getPublishTests(String email) {
        return jdbcTemplate.query(sqlSelectPublishTests, new Object[]{email}, new TestInfoMapper());
    }

    //Denne metoden henter ut de klassene som en test kan publiseres til basert på lærerens e-postadresse, lærerens skole og testens id
    @Override
    public List<ClassInfo> getPublishClasses(String email, int testId, int schoolId) {
        return jdbcTemplate.query(sqlSelectPublishClasses, new Object[]{email, testId, schoolId}, new ClassInfoMapper());
    }

    //Denne metoden publiserer en test til valgte klasser
    @Override
    public boolean addPublishClasses(String email, int testId, List<Integer> classIds) {
        try {
            for (Integer i : classIds) {
                int j = jdbcTemplate.update(sqlAddTestClass, new Object[]{testId, i});
                if (j == 0) {
                    return false;
                }
            }
            jdbcTemplate.update(sqlUpdateTestTeacher, new Object[]{true, email, testId});
            return true;

        } catch (Exception e) {
            return false;
        }
    }

    //Denne metoden henter ut aktivstatusen til testen med innsendt id
    @Override
    public boolean getTestActive(int testId) {
        return jdbcTemplate.queryForObject(sqlSelectTestActive, new Object[]{testId}, Boolean.class);
    }

    //Denne metoden setter aktivstatuen til testen med innsendt id
    @Override
    public boolean setTestActive(int testId, boolean b) {
        return jdbcTemplate.update(sqlUpdateTestActive, new Object[]{b, testId}) > 0;
    }

    //Denne metoden henter ut statistikken til alle lærerne
    @Override
    public List<TeacherStatistics> getAllTeacherStatistics() {
        return jdbcTemplate.query(sqlSelectAllClassTeachers, new TeacherStatisticsExtractor());
    }

    //Denne metoden henter ut informasjon om alle skolene
    @Override
    public List<SchoolInfo> getAllSchools() {
        return jdbcTemplate.query(sqlSelectAllSchools, new SchoolInfoMapper());
    }

    //Denne metoden legger til en skole med navn lik innsendt skolenavn
    @Override
    public boolean addSchool(String schoolName) {
        return jdbcTemplate.update(sqlAddSchool, new Object[]{schoolName}) != 0;
    }

    //Denne metoden henter ut alle klassene som er tilknyttet skolen med innsendt id
    @Override
    public List<ClassInfo> getAllClasses(int schoolId) {
        return jdbcTemplate.query(sqlSelectAllClasses, new Object[]{schoolId}, new ClassInfoMapper());
    }

    //Denne metoden legger til en klasse tilknyttet skolen med innsendt id
    @Override
    public boolean addClass(String className, int schoolId) {
        return jdbcTemplate.update(sqlAddClass, new Object[]{className, schoolId}) != 0;
    }

    //Denne metoden henter ut all informasjon om studentene tilknyttet klassen med innsendt id
    @Override
    public List<StudentInfo> getAllStudentsClass(int classId) {
        return jdbcTemplate.query(sqlSelectStudentsClass, new Object[]{classId}, new StudentInfoMapper());
    }
}
 