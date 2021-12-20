package com.example.controller;

import com.example.domain.Message;
import com.example.domain.User;
import com.example.service.MessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.Valid;
import java.io.IOException;
import java.util.Map;
import java.util.Set;

@Controller
public class MessageController {
    @Autowired
    MessageService messageService;

    @GetMapping("/messagesList")
    public String getMessagesList(@RequestParam(required = false, defaultValue = "") String filter, Model model) {
        model.addAttribute("messages", messageService.getMessageList(filter));
        model.addAttribute("filter", filter);

        return "messagesList";
    }

    @PostMapping("/messagesList")
    public String addMessage(
            @AuthenticationPrincipal User user,
            @Valid Message message,
            BindingResult bindingResult,
            Model model,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        if (bindingResult.hasErrors()) {
            Map<String, String> errorsMap = ControllerUtils.getErrors(bindingResult);

            model.mergeAttributes(errorsMap);
            model.addAttribute(message);

            return getMessagesList(null, model);
        } else {
            messageService.saveMessage(message, user, file);

            model.addAttribute("message", null);

            return "redirect:/messagesList";
        }
    }

    @GetMapping("/messagesList/{message}/del")
    public String delMessage(@PathVariable Message message) {
        messageService.delMessage(message);

        return "redirect:/messagesList";
    }

    @GetMapping("/userMessages/{user}")
    public String getUserMessages(
            @AuthenticationPrincipal User currentUser,
            @PathVariable User user,
            Model model,
            @RequestParam(required = false) Message message
    ) {
        Set<Message> messages = user.getMessages();

        model.addAttribute("messages", messages);
        model.addAttribute("message", message);
        model.addAttribute("isCurrentUser", currentUser.equals(user));

        return "userMessages";
    }

    @PostMapping("/userMessages/{user}")
    public String saveUserMessage(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam("id") Message message,
            @RequestParam("text") String text,
            @RequestParam("tag") String tag,
            @RequestParam("file") MultipartFile file
    ) throws IOException {
        if (message.getAuthor().equals(currentUser)) {
            if (!StringUtils.isEmpty(text)) {
                message.setText(text);
            }

            if (!StringUtils.isEmpty(tag)) {
                message.setTag(tag);
            }

           messageService.saveMessage(message, currentUser, file);
        }

        return "redirect:/userMessages/" + user;
    }
}