package com.enmaka.matistikk.controllers;

import com.enmaka.matistikk.objects.UserLogin;
import com.enmaka.matistikk.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.enmaka.matistikk.users.Student;
import com.enmaka.matistikk.users.User;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;

/**
 *
 * @author Team ENMAKA
 * 
 * Klassen har metoder for å håndtere kall som skjer før en brukertype er logget inn.
 * 
 * For mer informasjon om klassen, se designdokumentet kapittel 4.4.2.
 */

@Controller
public class LoginController {
    
    @Autowired
    private UserService userService;
    
    @RequestMapping(value="login", method = RequestMethod.POST)
    public String loginMainPage(UserLogin ul, BindingResult error, HttpSession session) {
        if(error.hasErrors()) {
            return "login";
        }
        
        User user = userService.login(ul.getUsername(), ul.getPassword());
        if(user==null) {
            session.invalidate();
            return "login";
        } else {
            session.setAttribute("user", user);
        }
        return "redirect:/";
    }
    
    @RequestMapping(value="newuser", method=RequestMethod.POST)
    public String newUser(@ModelAttribute("student") Student student, Model model, BindingResult error) {
        if(error.hasErrors()){
            return "login";
        }
        
        if (!userService.findEmail(student.getUsername())) {
            userService.addStudent(student);
            model.addAttribute("message", "Passord er sendt til:\n" + student.getUsername());
            return "login";
        } else {
            return "redirect:/";
        }
    }
    
    @RequestMapping(value="forgotpassword", method = RequestMethod.POST)
    public String sendPassword(@ModelAttribute("student") Student student, BindingResult error){
        if(error.hasErrors()){
            return "redirect:/";
        }
        if(userService.findEmail(student.getUsername())) {
            if(!userService.forgotPassword(student.getUsername())) {
                return "redirect:/";  
            }
        } else {
            // TODO: Feilmelding for epost ikke i bruk
            return "redirect:/";
        }
        // TODO: Bekreftelse på endret passord    
        return "login";
    }
    @RequestMapping(value="passwordsent", method = RequestMethod.POST)
    public String passwordSent(@ModelAttribute Student student){
        return "redirect:/";
    }
    
    @RequestMapping(value = "logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    /* 
    Kode hentet fra teamets SCRUM-prosjekt våren 2015. 
    */
    
    public static boolean validate(HttpSession session) {
        User user = (User)session.getAttribute("user");
        if(user != null) {
            return true;
        }
        session.invalidate();
        return false;
    }
    
    public static boolean validate(HttpSession session, String usertype) {
        User user = (User)session.getAttribute("user");
        
        if(user != null) {
            switch (usertype) {
                case "Admin":
                    if(user.getDescription().equals("Admin")) {
                        return true;
                    }   break;
                case "Teacher":
                    if(user.getDescription().equals("Teacher")) {
                        return true;
                    }   break;
                case "Student":
                    if(user.getDescription().equals("Student")) {
                        return true;
                    }   break;
            }
        }
        return false;
    }
}
