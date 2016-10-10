package com.enmaka.matistikk.controllers;

import com.enmaka.matistikk.objects.*;
import com.enmaka.matistikk.service.UserService;
import com.enmaka.matistikk.ui.*;
import com.enmaka.matistikk.users.Student;
import com.enmaka.matistikk.users.Teacher;
import com.enmaka.matistikk.users.User;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author Team ENMAKA
 *
 * Klassen har metoder for å håndtere kall som er felles for brukertypene.
 *
 * For mer informasjon om klassen, se designdokumentet kapittel 4.4.3.
 */
@Controller
public class MainController {

    @Autowired
    private UserService userService;

    @InitBinder
    protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) {
        binder.registerCustomEditor(TaskInfo.class, new TaskEditor(userService));
    }

    @RequestMapping("/")
    public String showStartView(@ModelAttribute UserLogin ul, Model model, HttpSession session, ModelMap mm) {
        if (!LoginController.validate(session)) {
            mm.addAttribute(new Student());
            mm.addAttribute(new UserLogin());
            return "login";
        } else {
            boolean b = false;
            if (LoginController.validate(session, "Teacher")) {
                b = userService.checkPublishTests(((Teacher) session.getAttribute("user")).getUsername());
            }
            model.addAttribute("publishTests", b);
            return "main";
        }
    }

    @RequestMapping(value = "home")
    public String homeView(HttpSession session, Model model) {
        if (!LoginController.validate(session)) {
            return "redirect:/";
        }
        boolean b = false;
        if (LoginController.validate(session, "Teacher")) {
            b = userService.checkPublishTests(((Teacher) session.getAttribute("user")).getUsername());
        }
        model.addAttribute("publishTests", b);
        return "main";
    }

    @RequestMapping(value = "mypageview")
    public String myPageView(HttpSession session, Model model) {
        if (!LoginController.validate(session)) {
            return "redirect:/";
        }
        String username = ((User) session.getAttribute("user")).getUsername();
        String testCompleteCount = userService.getTestCount(username, true, true);
        String testIncompleteCount = userService.getTestCount(username, false, true);
        String practiseTestCompleteCount = userService.getTestCount(username, true, false);
        String practiseTestIncompleteCount = userService.getTestCount(username, false, false);

        model.addAttribute("testCompleteCount", testCompleteCount);
        model.addAttribute("testIncompleteCount", testIncompleteCount);
        model.addAttribute("practiseTestCompleteCount", practiseTestCompleteCount);
        model.addAttribute("practiseTestIncompleteCount", practiseTestIncompleteCount);
        String madeCount = userService.getTestMadeCount(username);
        model.addAttribute("madeCount", madeCount);
        return "mypage";
    }

    @RequestMapping(value = "helpview")
    public String helpView(HttpSession session) {
        if (!LoginController.validate(session)) {
            return "redirect:/";
        }
        return "help";
    }

    @RequestMapping(value = "aboutview")
    public String aboutView(HttpSession session, Model model) {
        if (!LoginController.validate(session)) {
            return "redirect:/";
        }
        return "about";
    }

    @RequestMapping(value = "createtestview", method = RequestMethod.GET)
    public String createTestView(@ModelAttribute TaskFormBackingBean backingBean, HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        String s = ((User) session.getAttribute("user")).getDescription();
        boolean type = false;
        if (s.equals("Admin")) {
            type = true;
        }
        backingBean.setAllTasks(userService.getAllTasks(type));
        return "createtest";
    }

    @RequestMapping(value = "statisticview")
    public String testStatisticsView(@ModelAttribute TestStatisticsFormBackingBean backingBean, HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        String s = ((User) session.getAttribute("user")).getDescription();
        boolean type = false;
        if (s.equals("Admin")) {
            type = true;
        }
        backingBean.setAllTestStatistics(userService.getStatistics(type));
        return "statistics";
    }

    @RequestMapping(value = "teststatistics")
    public String taskStatisticsView(@ModelAttribute TaskStatisticsFormBackingBean backingBean, HttpServletRequest request, Model model, HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        String s = request.getParameter("testId");
        int testId = Integer.parseInt(s);
        backingBean.setAllTaskStatistics(userService.getTestStatistics(testId));
        model.addAttribute("testId", testId);
        return "teststatistics";
    }

    @RequestMapping(value = "taskstatistics")
    public String answerStatisticsView(@ModelAttribute AnswerStatisticsFormBackingBean backingBean, HttpServletRequest request, Model model, HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        String s = request.getParameter("testId");
        String t = request.getParameter("taskId");
        int testId = Integer.parseInt(s);
        int taskId = Integer.parseInt(t);
        backingBean.setAllAnswerStatistics(userService.getTaskStatistics(testId, taskId));
        model.addAttribute("taskId", taskId);
        model.addAttribute("testId", testId);
        return "taskstatistics";
    }

    @RequestMapping(value = "taskstatisticsmore")
    public String answerStatisticsMoreView(HttpServletRequest request, Model model, HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        String s = request.getParameter("taskId");
        String t = request.getParameter("testId");
        String email = request.getParameter("email");
        int taskId = Integer.parseInt(s);
        int testId = Integer.parseInt(t);
        Answer answer = userService.getAnswer(email, testId, taskId);
        List<Double> cords = userService.getCoordinates(answer.getId());
        model.addAttribute("answer", answer);
        model.addAttribute("testId", testId);
        model.addAttribute("cords", cords);
        Task task = userService.getTask(taskId);
        if (task instanceof Arithmetic) {
            return "arithmeticstatistics";
        } else if (task instanceof Figures) {
            return "figuresstatistics";
        } else if (task instanceof NumberLine) {
            return "numberlinestatistics";
        } else if (task instanceof SingleChoice) {
            return "singlechoicestatistics";
        } else if (task instanceof Sort) {
            return "sortstatistics";
        } else {
            return "taskstatistics";
        }
    }

    @RequestMapping(value = "createtaskview")
    public String taskView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "createtask";
    }

    @RequestMapping(value = "arithmeticview")
    public String arithmeticView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "arithmetic";
    }

    @RequestMapping(value = "singlechoiceview")
    public String singleChoiceView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "singlechoice";
    }

    @RequestMapping(value = "sortview")
    public String sortView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "sort";
    }

    @RequestMapping(value = "numberlineview")
    public String numberLineView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "numberline";
    }

    @RequestMapping(value = "figuresview")
    public String figuresView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "figures";
    }

    @RequestMapping(value = "changePW", method = RequestMethod.POST)
    public String changePassword(@ModelAttribute("password") ChangePassword pw, BindingResult result, HttpSession session) {
        if (!LoginController.validate(session)) {
            return "redirect:/";
        }

        if (result.hasErrors()) {
            return "mypage";
        }
        if (!pw.getOldPassword().equals(userService.getPassword(((User) session.getAttribute("user")).getUsername()))) {
            result.rejectValue("oldPassword", "feil1");
        }
        if (!pw.getNewPassword1().equals(pw.getNewPassword2())) {
            result.rejectValue("newPassword2", "feil2");
        }

        if (result.hasErrors()) {
            return "mypage";
        }

        if (!userService.changePassword(pw.getNewPassword1(), (User) session.getAttribute("user"))) {
            return "myPage";
        }

        return "redirect:mypageview";
    }

    @RequestMapping(value = "addarithmetictask", method = RequestMethod.POST)
    public String addArithmetic(@ModelAttribute("arithmetic") Arithmetic arithmetic, Fraction fraction, HttpSession session, BindingResult error) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        if (error.hasErrors()) {
            return "redirect:/";
        }
        String a = ((User) session.getAttribute("user")).getDescription();
        boolean type = false;
        if (a.equals("Admin")) {
            type = true;
        }
        arithmetic.setSolution(fraction);
        arithmetic.setUsername(((User) session.getAttribute("user")).getUsername());
        userService.addTask(arithmetic, type);

        return "redirect:createtestview";
    }

    //*************************************//
    @RequestMapping(value = "addfunctiontask", method = RequestMethod.POST)
    public String addFunction(@ModelAttribute("function") Function function, HttpSession session, BindingResult error, HttpServletRequest request, HttpServletResponse response) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        if (error.hasErrors()) {
            return "redirect:/";
        }
        String a = ((User) session.getAttribute("user")).getDescription();
        boolean type = false;
        if (a.equals("Admin")) {
            type = true;
        }
        String rb = request.getParameter("answer_type");     //Her er jeg usikker. Settes det ikke bare en int-verdi uten å ta noe valg..? Må evt taes senere?
        if (rb.equals("1")) {
            function.setAnswerType(1);
        } else if (rb.equals("2")) {
            function.setAnswerType(2);
        } else if (rb.equals("3")) {
            function.setAnswerType(3);
        }else{
            function.setAnswerType(0);
        }
        System.out.println(function.getAnswerType());

        function.setUsername(((User) session.getAttribute("user")).getUsername());
        userService.addTask(function, type);

        return "redirect:createtestview";
    }

    @RequestMapping(value = "addsinglechoicetask", method = RequestMethod.POST)
    public String addSingleChoice(@ModelAttribute("singleChoice") SingleChoice singleChoice, Fraction fraction, HttpServletRequest request, HttpSession session, BindingResult error) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        if (error.hasErrors()) {
            return "redirect:createtestview";
        }
        String s = request.getParameter("fractionsString");
        StringTokenizer st = new StringTokenizer(s, "|");
        ArrayList<Fraction> fr = new ArrayList<>();
        while (st.hasMoreTokens()) {
            StringTokenizer st2 = new StringTokenizer(st.nextToken(), "/");
            int num = Integer.parseInt(st2.nextToken());
            int den = Integer.parseInt(st2.nextToken());
            fr.add(new Fraction(num, den));
        }
        String a = ((User) session.getAttribute("user")).getDescription();
        boolean type = false;
        if (a.equals("Admin")) {
            type = true;
        }
        Fraction[] newFractions = new Fraction[]{};
        newFractions = fr.toArray(newFractions);
        singleChoice.setChoices(newFractions);
        singleChoice.setSolution(fraction);
        singleChoice.setUsername(((User) session.getAttribute("user")).getUsername());
        userService.addTask(singleChoice, type);

        return "redirect:createtestview";
    }

    @RequestMapping(value = "addsorttask", method = RequestMethod.POST)
    public String addSort(@ModelAttribute("sort") Sort sort, HttpServletRequest request, HttpSession session, BindingResult error) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        if (error.hasErrors()) {
            return "redirect:createtestview";
        }
        String s = request.getParameter("fractionsString");
        StringTokenizer st = new StringTokenizer(s, "|");
        ArrayList<Fraction> fr = new ArrayList<>();
        while (st.hasMoreTokens()) {
            StringTokenizer st2 = new StringTokenizer(st.nextToken(), "/");
            int num = Integer.parseInt(st2.nextToken());
            int den = Integer.parseInt(st2.nextToken());
            fr.add(new Fraction(num, den));
        }

        Fraction[] newFractions = new Fraction[]{};
        newFractions = fr.toArray(newFractions);
        sort.setFractions(newFractions);
        Fraction[] newSolution = newFractions.clone();
        String t = request.getParameter("sorting");
        if (t.equals("stigende")) {
            SortAscOrder sao = new SortAscOrder();
            Arrays.sort(newSolution, sao);
        } else {
            SortDescOrder sdo = new SortDescOrder();
            Arrays.sort(newSolution, sdo);
        }
        String a = ((User) session.getAttribute("user")).getDescription();
        boolean type = false;
        if (a.equals("Admin")) {
            type = true;
        }
        sort.setSolution(newSolution);
        sort.setUsername(((User) session.getAttribute("user")).getUsername());
        userService.addTask(sort, type);

        return "redirect:createtestview";
    }

    @RequestMapping(value = "addnumberlinetask", method = RequestMethod.POST)
    public String addNumberLine(@ModelAttribute("numberline") NumberLine numberline, Fraction fraction, HttpSession session, BindingResult error) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        if (error.hasErrors()) {
            return "redirect:/";
        }
        String a = ((User) session.getAttribute("user")).getDescription();
        boolean type = false;
        if (a.equals("Admin")) {
            type = true;
        }
        numberline.setSolution(fraction);
        numberline.setUsername(((User) session.getAttribute("user")).getUsername());
        userService.addTask(numberline, type);

        return "redirect:createtestview";
    }

    @RequestMapping(value = "addfigurestask", method = RequestMethod.POST)
    public String addFigures(@ModelAttribute("figures") Figures figures, HttpSession session, BindingResult error) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        if (error.hasErrors()) {
            return "redirect:/";
        }
        String a = ((User) session.getAttribute("user")).getDescription();
        boolean type = false;
        if (a.equals("Admin")) {
            type = true;
        }
        figures.setUsername(((User) session.getAttribute("user")).getUsername());
        userService.addTask(figures, type);
        return "redirect:createtestview";
    }

//    Tilbake-knapp: oppretting test
    @RequestMapping(value = "back")
    public String createTestBack(@ModelAttribute("teacherStatisticsFormBackingBean") TeacherStatisticsFormBackingBean teacherBean, HttpServletRequest request, Model model) {
        List<TeacherStatistics> ts = userService.getAllTeacherStatistics();
        String tasks = request.getParameter("back");
        teacherBean.setAllTeachers(ts);
        model.addAttribute("tasks", tasks);
        return "testclasses";
    }

    @RequestMapping(value = "newtest")
    public String newTestView(@ModelAttribute("taskFormBackingBean") TaskFormBackingBean backingBean, TeacherStatisticsFormBackingBean teacherBean, Model model, HttpServletRequest request, HttpSession session, BindingResult error) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        if (error.hasErrors()) {
            return "redirect:/";
        }
        String selected = request.getParameter("selected");
        List<TeacherStatistics> ts = userService.getAllTeacherStatistics();

        List<TaskInfo> ti = backingBean.getSelectedTasks();
        String tasks = "";
        for (TaskInfo info : ti) {
            tasks += info.getId() + "|";
        }
        String a = ((User) session.getAttribute("user")).getDescription();
        boolean b = a.equals("Admin");
        if (selected != null && b) {
            teacherBean.setAllTeachers(ts);
            model.addAttribute("tasks", tasks);
            return "testclasses";
        } else if (selected != null && !b) {
            model.addAttribute("tasks", tasks);
            return "newtest";
        } else {
            String s = ((User) session.getAttribute("user")).getDescription();
            boolean type = false;
            if (s.equals("Admin")) {
                type = true;
            }
            backingBean.setAllTasks(userService.getAllTasks(type));
            return "createtest";
        }
    }

    /*  Sende videre valgte tasks og legge de i en streng.
     Opprette test med tabell av valgte tasks og lærere */
    @RequestMapping(value = "createnewtest")
    public String createNewTestView(@ModelAttribute TaskFormBackingBean backingBean, HttpSession session, HttpServletRequest request, Model model) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        Test test = new Test();
        String t = request.getParameter("testtasks");
        String d = ((User) session.getAttribute("user")).getDescription();

        String a = request.getParameter("active");
        boolean active = a.equals("true");
        boolean type = d.equals("Admin");
        test.setActive(active);
        String email = ((User) session.getAttribute("user")).getUsername();
        test.setTeacher(email);
        StringTokenizer st = new StringTokenizer(t, "|");
        List<Integer> list = new ArrayList<Integer>();
        while (st.hasMoreTokens()) {
            list.add(Integer.parseInt(st.nextToken()));
        }
        int testId = userService.addTest(test, list, type);
        if (type) {
            String c = request.getParameter("teachers");
            System.out.println(c);
            st = new StringTokenizer(c, "|");
            List<String> teacherList = new ArrayList<>();
            while (st.hasMoreTokens()) {
                teacherList.add(st.nextToken());
            }
            System.out.println(userService.addTestTeachers(testId, teacherList));
        }
        backingBean.setAllTasks(userService.getAllTasks(type));
        return "createtest";
    }

    @RequestMapping(value = "edittests")
    public String editTests(@ModelAttribute TestFormBackingBean backingBean, HttpSession session) {
        if (!LoginController.validate(session, "Teacher")) {
            return "redirect:/";
        }
        String s = ((User) session.getAttribute("user")).getDescription();
        String username = ((User) session.getAttribute("user")).getUsername();
        backingBean.setAllTests(userService.getAllTestInfo(false, username));
        return "edittests";
    }

    @RequestMapping(value = "functionsview")
    public String functionsView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "functions";
    }

    @RequestMapping(value = "createfunctiontaskview")
    public String createfunctiontaskView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "createfunctiontask";
    }

    @RequestMapping(value = "choosetypeview")
    public String choosetypeView(HttpSession session) {
        if (LoginController.validate(session, "Student")) {
            return "redirect:/";
        }
        return "choosetype";
    }
}
