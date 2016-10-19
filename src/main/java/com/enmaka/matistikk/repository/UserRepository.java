package com.enmaka.matistikk.repository;

import com.enmaka.matistikk.objects.Answer;
import com.enmaka.matistikk.objects.ClassInfo;
import com.enmaka.matistikk.objects.SchoolInfo;
import com.enmaka.matistikk.objects.TestStatistics;
import com.enmaka.matistikk.objects.StudentInfo;
import com.enmaka.matistikk.objects.Task;
import com.enmaka.matistikk.objects.TaskAnswer;
import com.enmaka.matistikk.objects.TaskInfo;
import com.enmaka.matistikk.objects.TeacherInfo;
import com.enmaka.matistikk.objects.Test;
import com.enmaka.matistikk.objects.TestInfo;
import com.enmaka.matistikk.objects.TaskStatistics;
import com.enmaka.matistikk.objects.TeacherStatistics;
import com.enmaka.matistikk.users.Student;
import com.enmaka.matistikk.users.Teacher;
import com.enmaka.matistikk.users.User;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen definerer metodene som må implementeres for at kommunikasjon mellom systemet og databasen skal fungere.
 * Hvis man skal bytte database må denne klassen implementeres i klassen som skal kommunisere med databasen.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.8.1.
 */

public interface UserRepository {
    
    //Denne metoden legger til en student
    public boolean addStudent(Student s);
    
    //Denne metoden legger til en lærer
    public boolean addTeacher(Teacher t);
    
    //Denne metoden tar seg av innloggingen til en bruker
    public User login(String username, String password);
    
    //Denne metoden henter ut alle studentene i databasen
    public List<StudentInfo> getAllStudents();
    
    //Denne metoden henter ut alle lærerne i databasen
    public List<TeacherInfo> getAllTeachers();
    
    //Denne metoden henter ut en lærers informasjon basert på innsendt e-postadresse
    public Teacher getTeacher(String email);
    
    //Denne metoden henter ut informasjon om alle oppgaver av innsendt type (øvingsoppgave eller forskningsoppgave)
    public List<TaskInfo> getAllTasks(boolean type);
    
    //Denne metoden genererer et nytt passord for brukeren med innsendt e-postadresse
    public boolean forgotPassword(String username);
    
    //Denne metoden sjekker om det finnes en bruker med innsendt e-postadresse
    public boolean findEmail(String username);
    
    //Denne metoden henter ut passordet til en bruker med innsendt e-postadresse
    public boolean addAnswer(Test test);
    
    //Denne metoden henter ut en besvarelse basert på innsendt e-postadrese, en tests id og en oppgaves id
    public Answer getAnswer(String email, int testId, int taskId);
    
    //Denne metoden legger til en oppgave
    public boolean addTask(Task task, boolean type);
    
    //Denne metoden legger til tegnekoordinatene
    public boolean addCoordinates(int testId, int taskId, int answerId, String email, List<Double> cords);
    
    //Denne metoden henter ut en oppgave med innsendt id
    public Task getTask(int id);
    
    //Denne metoden henter ut informasjon om alle forskningstester som er tilknyttet en klasse id, og som ikke er fullført av innsendt e-postadresse
    public List<TestInfo> getAllTests(String email, int classId);
    
    //Denne metoden henter ut informasjon om alle øvingstester som er tilknyttet en klasse id, og som ikke er fullført av innsendt e-postadresse
    public List<TestInfo> getAllPractiseTests(String email, int classId);
    
    //Denne metoden henter ut informasjon om en oppgave basert på innsendt id
    public TaskInfo getTaskInfoId(int id);
    
    //Denne metoden henter ut en test basert på innsendt id og e-postadresse
    public Test getTest(int id, String email);
    
    //Henter ut tegnekoordinatene som er tilknyttet besvarelsen med innsendt id
    public List<Double> getCoordinates(int id);
    
    //Denne metoden legger til en test
    public int addTest(Test test, List<Integer> taskIds, boolean type);
    
    //Denne metoden endrer passord for innsendt bruker
    public boolean changePassword(String newPassword, User user);
    
    //Denne metoden henter ut passordet til en bruker med innsendt e-postadresse
    public String getPassword(String username);
    
    //Denne metoden tar seg av zippingen av valgte tester
    public String zipTests(List<Integer> testIds);
    
    //Denne metoden tar seg av eksporteringen av en test med innsendt id
    public void exportTest(int id) throws FileNotFoundException, IOException, SQLException;
   
    //Denne metoden sjekker om klassen med innsendt id eksisterer
    public boolean checkClass(int id);
    
    //Henter ut inforamsjon om klassen med innsendt id
    public ClassInfo getSchoolClass(int id);
    
    //Denne metoden henter ut antall besvarte tester basert på innsendt e-postadresse
    public String getTestCount(String username, boolean completed, boolean testable);
   
    //Denne metoden henter ut antall tester laget av læreren med innsendt e-postadresse
    public String getTestMadeCount(String username);
   
    //Denne metoden henter ut statistikken til alle testene av innsendt type (forskningstest eller øvingstest)
    public List<TestStatistics> getStatistics(boolean type);
    
    //Denne metoden henter ut statistikken til alle oppgavene som er tilknyttet innsendt test id
    public List<TaskStatistics> getTestStatistics(int testId);
    
    //Denne metoden henter ut statistikken til alle besvarelsene som er tilknyttet innsendt test id og oppgave id
    public List<TaskAnswer> getTaskStatistics(int testId, int taskId);
    
    //Denne metoden oppdaterer hvilken klasse brukeren med innsendt e-postadresse er tilknyttet
    public boolean updateClassId(int classId, String username);
    
    //Denne metoden henter ut informasjon om alle testene av innsendt type (forskningstest eller øvingstest) som er opprettet av brukeren med innsendt e-postadresse
    public List<TestInfo> getAllTestInfo(boolean type, String username);

    //Denne metoden henter ut alle tester som kan publiseres av læreren med innsendt e-postadresse
    public List<Integer> getTestTeacher(String email);
    
    //Denne metoden oppretter en forbindelse mellom læreren med innsendt e-postadresse og klassene med innsendt id
    public boolean addTeacherClasses(String email, List<Integer> classes);
    
    //Denne metoden henter ut alle klassene som er tilknyttet med læreren med innsendt e-postadresse
    public List<String> getTeacherClass(String email);
    
    //Denne metoden henter ut informasjon om alle klassene som ikke allerede er tilknyttet læreren med innsendt e-postadresse men som er tilknyttet lærerens skole
    public List<ClassInfo> getAllClassesInfo(String email, int schoolId);
    
    //Denne metoden setter aktivstatusen til brukeren med innsendt e-postadresse
    public boolean setUserActive(String email, boolean active);
    
    //Denne metoden henter ut statistikken om lærerene som er tilknyttet testen med innsendt id
    public List<TeacherStatistics> getTestTeachers(int testId);
    
    //Denne metoden legger til en hvilke lærere som kan publisere testen med innsendt test id
    public boolean addTestTeachers(int testId, List<String> teachers);
    
    //Denne metoden sjekker om læreren med innsendt e-postadresse har upuliserte tester
    public boolean checkPublishTests(String email);
    
    //Denne metoden henter de upubliserte testene for læreren med innsendt e-postadresse
    public List<TestInfo> getPublishTests(String email);
    
    //Denne metoden henter ut de klassene som en test kan publiseres til basert på lærerens e-postadresse, lærerens skole og testens id
    public List<ClassInfo> getPublishClasses(String email, int testId, int schoolId);
    
    //Denne metoden publiserer en test til valgte klasser
    public boolean addPublishClasses(String email, int testId, List<Integer> classIds);
    
    //Denne metoden henter ut aktivstatusen til testen med innsendt id
    public boolean getTestActive(int testId);
    
    //Denne metoden setter aktivstatuen til testen med innsendt id
    public boolean setTestActive(int testId, boolean b);
    
    //Denne metoden henter ut statistikken til alle lærerne
    public List<TeacherStatistics> getAllTeacherStatistics();
    
    //Denne metoden henter ut informasjon om alle skolene
    public List<SchoolInfo> getAllSchools();
    
    //Denne metoden legger til en skole med navn lik innsendt skolenavn
    public boolean addSchool(String schoolName);
    
    //Denne metoden henter ut alle klassene som er tilknyttet skolen med innsendt id
    public List<ClassInfo> getAllClasses(int schoolId);
    
    //Denne metoden legger til en klasse tilknyttet skolen med innsendt id
    public boolean addClass(String className, int schoolId);
    
    //Denne metoden henter ut all informasjon om studentene tilknyttet klassen med innsendt id
    public List<StudentInfo> getAllStudentsClass(int classId);
}
