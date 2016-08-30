package com.enmaka.matistikk.controllers;

import com.enmaka.matistikk.service.UserService;
import com.enmaka.matistikk.ui.ClassInfoFormBackingBean;
import com.enmaka.matistikk.ui.TestFormBackingBean;
import com.enmaka.matistikk.users.Teacher;
import com.enmaka.matistikk.users.User;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen har metoder for å håndtere kall fra brukertypen Teacher.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.4.6.
 */

@Controller
public class TeacherController {
    
     @Autowired
    private UserService userService;
    
    @RequestMapping(value = "publishtests")
    public String publishTestView(@ModelAttribute TestFormBackingBean backingBean, HttpServletRequest request, HttpSession session){
        if(!LoginController.validate(session, "Teacher")){
            return "redirect:/";
        }
        backingBean.setAllTests(userService.getPublishTests(((User)session.getAttribute("user")).getUsername()));
        return "publishtests";
    }
    
    @RequestMapping(value = "selectclasses")
    public String selectClasses(@ModelAttribute ClassInfoFormBackingBean backingBean, HttpServletRequest request, HttpSession session, Model model){
        if(!LoginController.validate(session, "Teacher")){
            return "redirect:/";
        }
        String s = request.getParameter("chosenTest");
        int testId = Integer.parseInt(s);
        backingBean.setAllClasses(userService.getPublishClasses(((Teacher)session.getAttribute("user")).getUsername(), testId, ((Teacher)session.getAttribute("user")).getSchoolId()));
        model.addAttribute("testId", testId);
        return "selectclasses";
    }
    
    @RequestMapping(value = "publishclasses")
    public String publishToClasses(@ModelAttribute TestFormBackingBean backingBean, HttpServletRequest request, HttpSession session){
        if(!LoginController.validate(session, "Teacher")){
            return "redirect:/";
        }
        String t = request.getParameter("testId");
        String s = request.getParameter("selected");
        int testId = Integer.parseInt(t);
        StringTokenizer st = new StringTokenizer(s, "|");
        List<Integer> classes = new ArrayList<>();
        while(st.hasMoreTokens()){
            classes.add(Integer.parseInt(st.nextToken()));
        }
        boolean b = userService.addPublishClasses(((User)session.getAttribute("user")).getUsername(), testId, classes);
        backingBean.setAllTests(userService.getPublishTests(((User)session.getAttribute("user")).getUsername()));
        return "publishtests";
    }
    
    
    @RequestMapping(value = "edittest")
    public String editTestsTeacher(@ModelAttribute TestFormBackingBean backingBean, Model model, HttpSession session) {
        if(!LoginController.validate(session, "Teacher")) {
            return "redirect:/";
        }
        userService.updateTests(backingBean.getAllTests());
        return "redirect:edittests";
    }
}
