package com.enmaka.matistikk.service;

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
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import com.enmaka.matistikk.repository.UserRepository;
import com.enmaka.matistikk.users.Teacher;
import com.enmaka.matistikk.users.User;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen tar seg de metodene som brukes til å kommunisere mellom controllerne og klassen som implementerer UserRepository.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.9.2.
 */

public class UserServiceImpl implements UserService {
    private UserRepository repo;
    
    //Denne metoden setter UserRepository
    @Autowired
    public void setRepository(UserRepository repo){
        this.repo = repo;
    }
    
    //Denne metoden legger til en student

    /**
     *
     * @param s
     * @return
     * @throws NoSuchAlgorithmException
     * @throws InvalidKeySpecException
     */
    @Override
    public boolean addStudent(Student s) throws NoSuchAlgorithmException,InvalidKeySpecException {
        return repo.addStudent(s);
    }
    
    //Denne metoden legger til en lærer
    @Override
    public boolean addTeacher(Teacher t) throws NoSuchAlgorithmException, InvalidKeySpecException {
        return repo.addTeacher(t);
    }
    
    //Denne metoden tar seg av innloggingen til en bruker
    @Override
    public User login(String username, String password)throws NoSuchAlgorithmException,InvalidKeySpecException {
        return repo.login(username, password);
    }
    
    //Denne metoden henter ut alle studentene i databasen
    @Override
    public List<StudentInfo> getAllStudents() {
        return repo.getAllStudents();
    }
    
    //Denne metoden henter ut alle lærerne i databasen
    @Override
    public List<TeacherInfo> getAllTeachers() {
        return repo.getAllTeachers();
    }
    
    //Denne metoden henter ut en lærers informasjon basert på innsendt e-postadresse
    @Override
    public Teacher getTeacher(String email){
        return repo.getTeacher(email);
    }
    
    //Denne metoden henter ut informasjon om alle oppgaver av innsendt type (øvingsoppgave eller forskningsoppgave)
    @Override
    public List<TaskInfo> getAllTasks(boolean type){
        return repo.getAllTasks(type);
    }
    
    //Denne metoden genererer et nytt passord for brukeren med innsendt e-postadresse
    @Override
    public boolean forgotPassword(String username) throws NoSuchAlgorithmException, InvalidKeySpecException {
        return repo.forgotPassword(username);
    }
    
    //Denne metoden sjekker om det finnes en bruker med innsendt e-postadresse
    @Override
    public boolean findEmail(String username) {
        return repo.findEmail(username);
    }

    //Denne metoden henter ut passordet til en bruker med innsendt e-postadresse
    @Override
    public boolean addAnswer(Test test){
        return repo.addAnswer(test);
    }
    
    //Denne metoden henter ut en besvarelse basert på innsendt e-postadrese, en tests id og en oppgaves id
    @Override
    public Answer getAnswer(String email, int testId, int taskId) {
        return repo.getAnswer(email, testId, taskId);
    }

    //Denne metoden legger til en oppgave
    @Override
    public boolean addTask(Task task, boolean type) {
        return repo.addTask(task, type);
    }

    //Denne metoden henter ut en oppgave med innsendt id
    @Override
    public Task getTask(int id) {
        return repo.getTask(id);
    }

    //Denne metoden henter ut informasjon om alle forskningstester som er tilknyttet en klasse id, og som ikke er fullført av innsendt e-postadresse
    @Override
    public List<TestInfo> getAllTests(String email, int classId) {
        return repo.getAllTests(email, classId);
    }
    
    //Denne metoden henter ut informasjon om alle øvingstester som er tilknyttet en klasse id, og som ikke er fullført av innsendt e-postadresse
    @Override
    public List<TestInfo> getAllPractiseTests(String email, int classId){
        return repo.getAllPractiseTests(email, classId);
    }
    
    //Denne metoden henter ut informasjon om en oppgave basert på innsendt id
    @Override
    public TaskInfo getTaskInfoId(int id) {
        return repo.getTaskInfoId(id);
    }
    
    //Denne metoden henter ut en test basert på innsendt id og e-postadresse
    @Override
    public Test getTest(int id, String email) {
        return repo.getTest(id, email);
    }

    //Denne metoden legger til en test
    @Override
    public int addTest(Test test, List<Integer> taskIds, boolean type) {
        return repo.addTest(test, taskIds, type);
    }
    
    //Denne metoden endrer passord for innsendt bruker
    @Override
    public boolean changePassword(String newPassword, User user) throws NoSuchAlgorithmException, InvalidKeySpecException {
        return repo.changePassword(newPassword, user);
    }
    
    //Denne metoden henter ut passordet til en bruker med innsendt e-postadresse
    @Override
    public String getPassword(String username) {
        return repo.getPassword(username);
    }
    
    //Denne metoden tar seg av zippingen av valgte tester
    @Override
     public String zipTests(List<Integer> testIds){
         return repo.zipTests(testIds);
     }
    
    //Henter ut tegnekoordinatene som er tilknyttet besvarelsen med innsendt id
    @Override
    public List<Double> getCoordinates(int id){
        return repo.getCoordinates(id);
    }
    
    //Denne metoden legger til tegnekoordinatene
    @Override
    public boolean addCoordinates(int testId, int taskId, int answerId, String email, List<Double> cords) {
        return repo.addCoordinates(testId, taskId, answerId, email, cords);
    }
    
    //Denne metoden sjekker om klassen med innsendt id eksisterer
    @Override
    public boolean checkClass(int id){
        return repo.checkClass(id);
    }
    
    //Henter ut inforamsjon om klassen med innsendt id
    @Override
    public ClassInfo getSchoolClass(int id){
        return repo.getSchoolClass(id);
    }
    
    //Denne metoden henter ut antall besvarte tester basert på innsendt e-postadresse
    @Override
    public String getTestCount(String username, boolean completed, boolean testable) {
        return repo.getTestCount(username, completed, testable);
    }
    
    //Denne metoden henter ut antall tester laget av læreren med innsendt e-postadresse
    @Override
    public String getTestMadeCount(String username) {
        return repo.getTestMadeCount(username);
    }
    
    //Denne metoden henter ut statistikken til alle testene av innsendt type (forskningstest eller øvingstest)
    @Override
    public List<TestStatistics> getStatistics(boolean type) {
        return repo.getStatistics(type);
    }
    
    //Denne metoden henter ut statistikken til alle oppgavene som er tilknyttet innsendt test id
    @Override
    public List<TaskStatistics> getTestStatistics(int testId) {
        return repo.getTestStatistics(testId);
    }
    
    //Denne metoden henter ut statistikken til alle besvarelsene som er tilknyttet innsendt test id og oppgave id
    @Override
    public List<TaskAnswer> getTaskStatistics(int testId, int taskId) {
        return repo.getTaskStatistics(testId, taskId);
    }
    
    //Denne metoden oppdaterer hvilken klasse brukeren med innsendt e-postadresse er tilknyttet
    @Override
    public boolean updateClassId(int classId, String username) {
        return repo.updateClassId(classId, username);
    }
    
    //Denne metoden henter ut informasjon om alle testene av innsendt type (forskningstest eller øvingstest) som er opprettet av brukeren med innsendt e-postadresse
    @Override
    public List<TestInfo> getAllTestInfo(boolean type, String username){
        return repo.getAllTestInfo(type, username);
    }
    
    //Denne metoden henter ut alle tester som kan publiseres av læreren med innsendt e-postadresse
    @Override
    public List<Integer> getTestTeacher(String email){
        return repo.getTestTeacher(email);
    }
    
    //Denne metoden oppretter en forbindelse mellom læreren med innsendt e-postadresse og klassene med innsendt id
    @Override
    public boolean addTeacherClasses(String email, List<Integer> classes){
        return repo.addTeacherClasses(email, classes);
    }
    
    //Denne metoden henter ut alle klassene som er tilknyttet med læreren med innsendt e-postadresse
    @Override
    public List<String> getTeacherClass(String email){
        return repo.getTeacherClass(email);
    }
    
    //Denne metoden henter ut informasjon om alle klassene som ikke allerede er tilknyttet læreren med innsendt e-postadresse men som er tilknyttet lærerens skole
    @Override
    public List<ClassInfo> getAllClassesInfo(String email, int schoolId){
        return repo.getAllClassesInfo(email, schoolId);
    }
    
    //Denne metoden setter aktivstatusen til brukeren med innsendt e-postadresse
    @Override
    public boolean setUserActive(String email, boolean active){
        return repo.setUserActive(email, active);
    }
    
    //Denne metoden henter ut statistikken om lærerene som er tilknyttet testen med innsendt id
    @Override
    public List<TeacherStatistics> getTestTeachers(int testId){
        return repo.getTestTeachers(testId);
    }
    
    //Denne metoden legger til en hvilke lærere som kan publisere testen med innsendt test id
    @Override
    public boolean addTestTeachers(int testId, List<String> teachers){
        return repo.addTestTeachers(testId, teachers);
    }
    
    //Denne metoden sjekker om læreren med innsendt e-postadresse har upuliserte tester
    @Override
    public boolean checkPublishTests(String email){
        return repo.checkPublishTests(email);
    }
    
    //Denne metoden henter de upubliserte testene for læreren med innsendt e-postadresse
    @Override
    public List<TestInfo> getPublishTests(String email){
        return repo.getPublishTests(email);
    }
    
    //Denne metoden henter ut de klassene som en test kan publiseres til basert på lærerens e-postadresse, lærerens skole og testens id
    @Override
    public List<ClassInfo> getPublishClasses(String email, int testId, int schoolId){
        return repo.getPublishClasses(email, testId, schoolId);
    }
    
    //Denne metoden publiserer en test til valgte klasser
    @Override
    public boolean addPublishClasses(String email, int testId, List<Integer> classIds){
        return repo.addPublishClasses(email, testId, classIds);
    }
    
    //Denne metoden henter ut aktivstatusen til testen med innsendt id
    @Override
    public boolean getTestActive(int testId){
        return repo.getTestActive(testId);
    }
    
    //Denne metoden setter aktivstatuen til testen med innsendt id
    @Override
    public boolean setTestActive(int testId, boolean b){
        return repo.setTestActive(testId, b);
    }
    
    //Denne metoden setter teststatusen til alle testene med de test idene i listen
    @Override
    public boolean updateTests(List<TestInfo> testInfo){
        if(testInfo == null || testInfo.isEmpty()) return true;
        boolean b = true;
        for(TestInfo ti : testInfo){
            if(ti.isActive()){
                b = repo.setTestActive(ti.getId(), true);
            }else{
                b = repo.setTestActive(ti.getId(), false);
            }
            if(!b) return false;
        }
        return true;
    }
    
    //Denne metoden henter ut statistikken til alle lærerne
    @Override
    public List<TeacherStatistics> getAllTeacherStatistics(){
        return repo.getAllTeacherStatistics();
    }
    
    //Denne metoden henter ut informasjon om alle skolene
    @Override
    public List<SchoolInfo> getAllSchools(){
        return repo.getAllSchools();
    }
    
    //Denne metoden legger til en skole med navn lik innsendt skolenavn
    @Override
    public boolean addSchool(String schoolName){
        return repo.addSchool(schoolName);
    }
    
    //Denne metoden henter ut alle klassene som er tilknyttet skolen med innsendt id
    @Override
    public List<ClassInfo> getAllClasses(int schoolId){
        return repo.getAllClasses(schoolId);
    }
    
    //Denne metoden legger til en klasse tilknyttet skolen med innsendt id
    @Override
    public boolean addClass(String className, int schoolId){
        return repo.addClass(className, schoolId);
    }
    
    //Denne metoden henter ut all informasjon om studentene tilknyttet klassen med innsendt id
    @Override
    public List<StudentInfo> getAllStudentsClass(int classId){
        return repo.getAllStudentsClass(classId);
    }
}
