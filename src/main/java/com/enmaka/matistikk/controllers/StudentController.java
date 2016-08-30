package com.enmaka.matistikk.controllers;

import com.enmaka.matistikk.objects.*;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.enmaka.matistikk.service.UserService;
import com.enmaka.matistikk.ui.TestFormBackingBean;
import com.enmaka.matistikk.users.Student;
import com.enmaka.matistikk.users.User;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen har metoder for å håndtere kall fra brukertypen Student.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.4.4.
 */

@Controller
public class StudentController {
    
    @Autowired
    private UserService userService;
    private Test test = new Test();
    
    @RequestMapping(value = "testview", method = RequestMethod.GET)
    public String testView(@ModelAttribute TestFormBackingBean backingBean, HttpSession session) {
        if(!LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        String email = ((Student)session.getAttribute("user")).getUsername();
        int classId = ((Student)session.getAttribute("user")).getClassId();
        backingBean.setAllTestableTests(userService.getAllTests(email, classId));
        backingBean.setAllPractiseTests(userService.getAllPractiseTests(email, classId));
        return "tests";
    }
    
    @RequestMapping(value = "gettest")
    public String startTestView(HttpSession session, HttpServletRequest request, Model model) {
        if(!LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        String s = request.getParameter("chosenTest");
        if(s == null){
            return "redirect:/";
        }
        test = userService.getTest(Integer.parseInt(s), ((Student) session.getAttribute("user")).getUsername());
        model.addAttribute("test", test);
        test.getCurrentTask().startTime();
        if(test.getCurrentTask() instanceof Arithmetic){
            return "arithmetictask";
        }else if(test.getCurrentTask() instanceof SingleChoice){
            return "singlechoicetask";
        }else if(test.getCurrentTask() instanceof Sort){
            return "sorttask";
        }else if(test.getCurrentTask() instanceof NumberLine){
            return "numberlinetask";
        }else if(test.getCurrentTask() instanceof Figures){
            return "figurestask";
        }else{
            return "tests";
        }
    }
    
    @RequestMapping(value = "joinclass")
    public String joinClass(@ModelAttribute ClassInfo chosenClass, HttpSession session, Model model) {
        if(!LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        boolean b = userService.checkClass(chosenClass.getClassId());
        if(b == false) {
            String message = "ERROR: Klassen eksisterer ikke!";
            model.addAttribute("message", message);
        } else {
            userService.updateClassId(chosenClass.getClassId(), ((User)session.getAttribute("user")).getUsername());
            chosenClass = userService.getSchoolClass(chosenClass.getClassId());
            
            String username = ((User)session.getAttribute("user")).getUsername();
            String testCompleteCount = userService.getTestCount(username, true, true);
            String testIncompleteCount = userService.getTestCount(username, false, true);
            String practiseTestCompleteCount = userService.getTestCount(username, true, false);
            String practiseTestIncompleteCount = userService.getTestCount(username, false, false);
            
            String message = "Du er nå lagt til i " + chosenClass.getSchoolClass();  
            model.addAttribute("message", message);
            model.addAttribute("testCompleteCount", testCompleteCount);
            model.addAttribute("testIncompleteCount", testIncompleteCount);
            model.addAttribute("practiseTestCompleteCount", practiseTestCompleteCount);
            model.addAttribute("practiseTestIncompleteCount", practiseTestIncompleteCount);
            ((Student)session.getAttribute("user")).setClassId(chosenClass.getClassId());
        }        
        return "mypage";
    }
    
    @RequestMapping(value = "nexttask")
    public String nextTaskView(@RequestParam String button, HttpSession session, HttpServletRequest request, Model model){
        test.getCurrentTask().endTime();
        if(!LoginController.validate(session, "Student")){
            return "redirect:/";
        }
        String c = request.getParameter("drawCords");
        StringTokenizer st = new StringTokenizer(c, ",");
        List<Double> cords = new ArrayList<>();
        while(st.hasMoreTokens()){
            cords.add(Double.parseDouble(st.nextToken()));
        }
        String s = request.getParameter("answer");
        String d = request.getParameter("description");
        if(button.equals("previous")){
            test.previousTask();
        }else if(test.getCurrentTask() instanceof Arithmetic || test.getCurrentTask() instanceof SingleChoice || test.getCurrentTask() instanceof NumberLine){
            st = new StringTokenizer(s, "/");
            int num = Integer.parseInt(st.nextToken());
            int den = Integer.parseInt(st.nextToken());
            Answer asf = new AnswerSingleFraction(new Fraction(num, den), d, ((Student) session.getAttribute("user")).getUsername(), (Integer) test.getCurrentTask().getId());
            asf.setCoordinates(cords);
            asf.setTime(test.getCurrentTask().getTime());
            test.setAnswer(asf);
        }else if(test.getCurrentTask() instanceof Sort){
            st = new StringTokenizer(s, "|");
            System.out.println(s);
            ArrayList<Fraction> fr = new ArrayList<>();
            while(st.hasMoreTokens()) {
                StringTokenizer st2 = new StringTokenizer(st.nextToken(), "/");
                int num = Integer.parseInt(st2.nextToken());
                int den = Integer.parseInt(st2.nextToken());
                fr.add(new Fraction(num, den));
            }
            Fraction[] fractions = new Fraction[]{};
            fractions = fr.toArray(fractions);
            Answer amf = new AnswerMultipleFractions(fractions, d, ((Student) session.getAttribute("user")).getUsername(), (Integer) test.getCurrentTask().getId());
            amf.setCoordinates(cords);
            amf.setTime(test.getCurrentTask().getTime());
            test.setAnswer(amf);
        }else if(test.getCurrentTask() instanceof Figures){
            Answer as = new AnswerString(d, ((Student) session.getAttribute("user")).getUsername(), (Integer) test.getCurrentTask().getId(), s);
            as.setCoordinates(cords);
            as.setTime(test.getCurrentTask().getTime());
            test.setAnswer(as);
        }
        if(button.equals("next")){
            userService.addAnswer(test);
            test.setStarted(true);
            if(test.getCounter() < test.getLength()-1){
                test.nextTask();
            }else{
                return "tests";
            }
        }
        model.addAttribute("test", test);
        test.getCurrentTask().startTime();
        if(test.getCurrentTask() instanceof Arithmetic){
            return "arithmetictask";
        }else if(test.getCurrentTask() instanceof SingleChoice){
            return "singlechoicetask";
        }else if(test.getCurrentTask() instanceof Sort){
            return "sorttask";
        }else if(test.getCurrentTask() instanceof NumberLine){
            return "numberlinetask";
        }else if(test.getCurrentTask() instanceof Figures){
            return "figurestask";
        }
        return "tests";
    }    
}
