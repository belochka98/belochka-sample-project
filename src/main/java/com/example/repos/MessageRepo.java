package com.example.repos;

import com.example.domain.Message;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageRepo extends CrudRepository<Message, Long> {
    List<Message> findByTag(String tag);

    List<Message> findByText(String text);

    List<Message> findByTextContainsOrTagContains(String text, String tag);
}