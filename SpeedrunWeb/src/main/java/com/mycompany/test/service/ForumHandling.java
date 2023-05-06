package com.mycompany.test.service;

import com.mycompany.test.entity.DifferentCategories;
import com.mycompany.test.entity.Forum;
import com.mycompany.test.repository.ForumRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class ForumHandling {

    @Autowired
    ForumRepository forumRepository;

    public Optional<List<Forum>> getAllForums(){
        List<Forum> forum = forumRepository.findAllByOrderByHead();
        return Optional.of(forum);
    }
    public void addComment(Forum forum){
        forumRepository.save(forum);
    }

}
