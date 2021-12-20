package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
   @GetMapping("/")
    public String greeting(Model model) {
       return "greeting";
    }

    @GetMapping("/main")
    public String main(Model model) {
        return "greeting";
    }

    @GetMapping("/login")
    public String login(Model model) {
        return "login";
    }
}