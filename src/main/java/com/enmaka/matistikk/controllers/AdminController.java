package com.enmaka.matistikk.controllers;

import com.enmaka.matistikk.objects.SchoolInfo;
import com.enmaka.matistikk.objects.TaskInfo;
import com.enmaka.matistikk.objects.TeacherStatistics;
import com.enmaka.matistikk.service.UserService;
import com.enmaka.matistikk.ui.ClassInfoFormBackingBean;
import com.enmaka.matistikk.ui.SchoolInfoFormBackingBean;
import com.enmaka.matistikk.ui.TestStatisticsFormBackingBean;
import com.enmaka.matistikk.ui.TaskFormBackingBean;
import com.enmaka.matistikk.ui.TeacherStatisticsFormBackingBean;
import com.enmaka.matistikk.ui.UserFormBackingBean;
import com.enmaka.matistikk.users.Teacher;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen har metoder for å håndtere kall fra brukertypen Admin.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.4.1.
 */

@Controller
public class AdminController {
    
    @Autowired
    private UserService userService;
    
    @RequestMapping(value = "alltests")
    public String allTestsView(@ModelAttribute TestStatisticsFormBackingBean backingBean, HttpSession session, Model model){
        if(!LoginController.validate(session, "Admin")){
            return "redirect:/";
        }
        backingBean.setAllTestStatistics(userService.getStatistics(true));
        return "alltests";
    }
    
    @RequestMapping(value = "newteacher", method = RequestMethod.POST)
    public String newTeacher(@ModelAttribute("teacher") Teacher teacher, @ModelAttribute UserFormBackingBean backingBean, Model model, BindingResult error, HttpSession session) {
        if(!LoginController.validate(session, "Admin")) {
            return "redirect:/";
        }
        if(error.hasErrors()){
            return "redirect:/getallusers";
        }
        
        if (userService.addTeacher(teacher)) {
            
            List<SchoolInfo> schools = userService.getAllSchools();
            model.addAttribute("schools", schools);
            backingBean.setAllStudents(userService.getAllStudents());
            backingBean.setAllTeachers(userService.getAllTeachers());
            return "allusers";
        } else {
            return "redirect:getallusers";
        }
    }
    
    @RequestMapping(value = "getallusers", method = RequestMethod.GET)
    public String listUsers(@ModelAttribute UserFormBackingBean backingBean, Model model, HttpSession session) {
        if(!LoginController.validate(session, "Admin")) {
            return "redirect:/";
        }
        List<SchoolInfo> schools = userService.getAllSchools();
        model.addAttribute("schools", schools);
        backingBean.setAllStudents(userService.getAllStudents());
        backingBean.setAllTeachers(userService.getAllTeachers());
        return "allusers";
    }
    
    @RequestMapping(value = "/testclasses")
    public String addTestClass(@ModelAttribute TaskFormBackingBean backingBean, Model model, HttpSession session, HttpServletRequest request){
        if(LoginController.validate(session, "Student")){
            return "redirect:/";
        }
        String tasks = request.getParameter("tasks");
        model.addAttribute("tasks", tasks);
        String c = request.getParameter("selected");
        StringTokenizer st = new StringTokenizer(c, "|");
        List<String> list = new ArrayList<>();
        while(st.hasMoreTokens()){
            list.add(st.nextToken());
        }
        st = new StringTokenizer(tasks,"|");
        List<TaskInfo> ti = new ArrayList<>();
        while(st.hasMoreTokens()){
            ti.add(userService.getTaskInfoId(Integer.parseInt(st.nextToken())));
        }
        backingBean.setSelectedTasks(ti);
        model.addAttribute("teachers", list);
        return "newtest";
    }
    
    @RequestMapping(value = "download", method = RequestMethod.GET)
    public void getFile(HttpServletRequest request, HttpServletResponse response){
        String s = request.getParameter("selectedTests");
        if(s.equals("")){
            
        }else{
            StringTokenizer st = new StringTokenizer(s, "|");
            List<Integer> list = new ArrayList<>();
            while(st.hasMoreTokens()){
                try{
                    int n = Integer.parseInt(st.nextToken());
                    list.add(n);
                }catch(Exception e){

                }
            }
            String path = userService.zipTests(list);
            File file = new File(path);
            OutputStream os = null;
            InputStream is = null;
            try{
                is = new FileInputStream(file);
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");
                os = response.getOutputStream();
                byte[] buffer = new byte[4096];
                int length;
                while((length = is.read(buffer)) != -1){
                    os.write(buffer, 0, length);
                }
            }catch(Exception e){
            }finally{
                try{
                    os.flush();
                    os.close();
                    is.close();
                }catch(Exception e){

                }
            }
        }
    }
    
    @RequestMapping(value = "teacherclass")
    public String editTeacherInfo(@ModelAttribute("classInfoFormBackingBean") ClassInfoFormBackingBean backingBean, HttpServletRequest request, Model model, HttpSession session){
        if(!LoginController.validate(session, "Admin")){
            return "redirect:/";
        }
        String s = request.getParameter("selected");
        String d = request.getParameter("school");
        Teacher t = userService.getTeacher(s);
        backingBean.setAllClasses(userService.getAllClassesInfo(t.getUsername(), t.getSchoolId()));
        List<String> classList = userService.getTeacherClass(t.getUsername());
        String classes = "";
        for(int i = 0; i<classList.size(); i++){
            if(i == 0){
                classes += classList.get(i);
            }else{
                classes += ", " + classList.get(i);
            }
        }
        model.addAttribute("teacherClasses", classes);
        model.addAttribute("teacher", t);
        model.addAttribute("school", d);
        return "teacherclass";
    }
    
    @RequestMapping(value = "activateuser")
    public String setUserActive(@ModelAttribute UserFormBackingBean backingBean, HttpServletRequest request, Model model, HttpSession session){
        if(!LoginController.validate(session, "Admin")){
            return "redirect:/";
        }
        String teacher = request.getParameter("chosenEmail");
        boolean active = Boolean.parseBoolean(request.getParameter("activeValue"));
        boolean b = userService.setUserActive(teacher, active);
        List<SchoolInfo> schools = userService.getAllSchools();
        model.addAttribute("schools", schools);
        backingBean.setAllStudents(userService.getAllStudents());
        backingBean.setAllTeachers(userService.getAllTeachers());
        return "allusers";
    }
    
    @RequestMapping(value = "publishview")
    public String setTestPublish(@ModelAttribute TeacherStatisticsFormBackingBean backingBean, HttpServletRequest request, Model model, HttpSession session){
        if(!LoginController.validate(session, "Admin")){
            return "redirect:/";
        }
        String s = request.getParameter("testId");
        int testId = Integer.parseInt(s);
        List<TeacherStatistics> list = userService.getTestTeachers(testId);
        boolean active = userService.getTestActive(testId);
        model.addAttribute("testId", testId);
        model.addAttribute("active", active);
        backingBean.setAllTeachers(list);
        return "publishview";
    }
    
    @RequestMapping(value = "publishtest")
    public String publishTest(@ModelAttribute TestStatisticsFormBackingBean backingBean, HttpServletRequest request, HttpSession session){
        if(!LoginController.validate(session, "Admin")){
            return "redirect:/";
        }
        String t = request.getParameter("testId");
        String s = request.getParameter("selected");
        int testId = Integer.parseInt(t);
        StringTokenizer st = new StringTokenizer(s, "|");
        List<String> teachers = new ArrayList<>();
        while(st.hasMoreTokens()){
            teachers.add(st.nextToken());
        }
        boolean b = userService.addTestTeachers(testId, teachers);
        backingBean.setAllTestStatistics(userService.getStatistics(true));
        return "alltests";
    }
    
    @RequestMapping(value = "activatetest")
    public String setActiveTest(@ModelAttribute TeacherStatisticsFormBackingBean backingBean, HttpServletRequest request, HttpSession session, Model model){
        if(!LoginController.validate(session, "Admin")){
            return "redirect:/";
        }
        String s = request.getParameter("newActive");
        StringTokenizer st = new StringTokenizer(s, "|");
        int testId = Integer.parseInt(st.nextToken());
        boolean b = st.nextToken().equals("true");
        userService.setTestActive(testId, b);
        return "redirect:alltests";
    }
    
    @RequestMapping(value = "addteacherclasses")
    public String addTeacherClasses(@ModelAttribute UserFormBackingBean backingBean, HttpServletRequest request, Model model, HttpSession session){
        if(!LoginController.validate(session, "Admin")){
            return "redirect:/";
        }
        String s = request.getParameter("selectedClasses");
        String t = request.getParameter("selectedTeacher");
        StringTokenizer st = new StringTokenizer(s, "|");
        List<Integer> classes = new ArrayList<>();
        while(st.hasMoreTokens()){
            classes.add(Integer.parseInt(st.nextToken()));
        }
        boolean b = userService.addTeacherClasses(t, classes);
        List<SchoolInfo> schools = userService.getAllSchools();
        model.addAttribute("schools", schools);
        backingBean.setAllStudents(userService.getAllStudents());
        backingBean.setAllTeachers(userService.getAllTeachers());
        return "allusers";
    }
    
    @RequestMapping(value = "allschools")
    public String getAllSchools(@ModelAttribute SchoolInfoFormBackingBean backingBean, HttpSession session){
        if(!LoginController.validate(session, "Admin")){
            return "redirect://";
        }
        backingBean.setAllSchools(userService.getAllSchools());
        return "allschools";
    }
    @RequestMapping(value = "newschool")
    public String addSchool(@ModelAttribute SchoolInfoFormBackingBean backingBean, HttpSession session, HttpServletRequest request){
        if(!LoginController.validate(session, "Admin")){
            return "redirect://";
        }
        String schoolName = request.getParameter("schoolName");
        boolean b = userService.addSchool(schoolName);
        if(b){
            backingBean.setAllSchools(userService.getAllSchools());
            return "allschools";
        }else{
            return "redirect://";
        }
    }
    
    @RequestMapping(value = "schoolclass")
    public String getClasses(@ModelAttribute ClassInfoFormBackingBean backingBean, HttpSession session, Model model, HttpServletRequest request){
        if(!LoginController.validate(session, "Admin")){
            return "redirect://";
        }
        String s = request.getParameter("selected");
        StringTokenizer st = new StringTokenizer(s, "|");
        int schoolId = Integer.parseInt(st.nextToken());
        String schoolName = st.nextToken();
        backingBean.setAllClasses(userService.getAllClasses(schoolId));
        model.addAttribute("schoolId", schoolId);
        model.addAttribute("schoolName", schoolName);
        return "allclasses";
    }
    
    @RequestMapping(value = "newclass")
    public String addClass(@ModelAttribute ClassInfoFormBackingBean backingBean, HttpSession session, Model model, HttpServletRequest request){
        if(!LoginController.validate(session, "Admin")){
            return "redirect://";
        }
        String className = request.getParameter("className");
        int schoolId = Integer.parseInt(request.getParameter("id"));
        String schoolName = request.getParameter("name");
        boolean b = userService.addClass(className, schoolId);
        if(b){
            backingBean.setAllClasses(userService.getAllClasses(schoolId));
            model.addAttribute("schoolId", schoolId);
            model.addAttribute("schoolName", schoolName);
            return "allclasses";
        }else{
            return "redirect://";
        }
    }
    
    @RequestMapping(value = "studentsclass")
    public String getStudentsClass(@ModelAttribute UserFormBackingBean backingBean, HttpSession session, Model model, HttpServletRequest request){
        if(!LoginController.validate(session, "Admin")){
            return "redirect://";
        }
        String s = request.getParameter("selected");
        StringTokenizer st = new StringTokenizer(s, "|");
        int classId = Integer.parseInt(st.nextToken());
        String className = st.nextToken();
        int schoolId = Integer.parseInt(request.getParameter("schoolId"));
        String schoolName = request.getParameter("schoolName");
        backingBean.setAllStudents(userService.getAllStudentsClass(classId));
        model.addAttribute("className", className);
        model.addAttribute("schoolId", schoolId);
        model.addAttribute("schoolName", schoolName);
        return "allstudentsclass";
    }
}
