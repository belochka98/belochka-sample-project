package com.example.service;

import com.example.domain.Message;
import com.example.domain.User;
import com.example.repos.MessageRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class MessageService {
    @Autowired
    private MessageRepo messageRepo;

    @Autowired
    private FileStorageService fileStorageServiceImp;

    public Iterable<Message> getMessageList(String filter) {
        if (filter != null && !filter.isEmpty()) {
            return messageRepo.findByTextContainsOrTagContains(filter, filter);
        } else {
            return messageRepo.findAll();
        }
    }

    public void saveMessage(Message message, User author, MultipartFile file) {
        message.setAuthor(author);

        if (!file.isEmpty() && !file.getOriginalFilename().isEmpty()) {
            message.setFilename(fileStorageServiceImp.saveFile(file));
        }

        messageRepo.save(message);
    }

    public void delMessage(Message message) {
        messageRepo.delete(message);
    }
}
