package com.example.controller;

import com.example.domain.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/userProfile/{user}")
    public String getProfile(Model model, @AuthenticationPrincipal User user) {
        model.addAttribute(user);

        return "userProfile";
    }
    @PostMapping("/userProfile/{user}")
    public String saveUser(
            @RequestParam("password_confirm") String password_confirm,
            @Valid User user,
            BindingResult bindingResult,
            Model model
    ) {
        boolean isPasswordConfirmEmpty = StringUtils.isEmpty(password_confirm);

        if (isPasswordConfirmEmpty) {
            model.addAttribute("password_confirmError", "Password confirmation is empty!");
        }

        if (!user.getPassword().equals(password_confirm)) {
            model.addAttribute("passwordError", "Passwords are different!");
        }

        if (isPasswordConfirmEmpty || bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);

            return "userProfile";
        }

        if (!userService.saveUser(user)) {
            model.addAttribute("usernameError", "User exists!");

            return "userProfile";
        }

        model.addAttribute("messageType", "success");
        model.addAttribute("message", "Message with activation code has been sent to your email!");

        return "greeting";
    }

    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/userList")
    public String userList(Model model) {
        model.addAttribute("users", userService.findAll());

        return "userList";
    }
}
