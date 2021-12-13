package com.example.controller;

import com.example.domain.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class RegistrationController {
    @Autowired
    private UserService userService;

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(
            @RequestParam("password_confirm") String password_confirm,
            @Valid User user,
            BindingResult bindingResult,
            Model model
    ) {
        boolean isPasswordConfirmEmpty = StringUtils.isEmpty(password_confirm);

        if (isPasswordConfirmEmpty) {
            model.addAttribute("password_confirmError", "Password confirmation is empty!");
        }

        if (user.getPassword () != null && !user.getPassword().equals(password_confirm)) {
            model.addAttribute("passwordError", "Passwords are different!");
        }

        if (isPasswordConfirmEmpty || bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);

            return "registration";
        }

        if (!userService.addUser(user)) {
            model.addAttribute("usernameError", "User exists!");

            return "registration";
        }

        model.addAttribute("messageType", "success");
        model.addAttribute("message", "Message with activation code has been sent to your email!");

        return "login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);

        if (isActivated) {
            model.addAttribute("messageType", "success");
            model.addAttribute("message", "User successfully activated");
        } else {
            model.addAttribute("message", "Activation code is not found!");
            model.addAttribute("messageType", "danger");
        }

        return "login";
    }
}
