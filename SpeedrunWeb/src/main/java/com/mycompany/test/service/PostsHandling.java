package com.mycompany.test.service;


import com.mycompany.test.entity.Posts;
import com.mycompany.test.repository.PostsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Component
public class PostsHandling {
    @Autowired
    PostsRepository postsRepository;

    public Optional<List<List>> getAllPosts(){
        List posts = postsRepository.findAll();
        return Optional.of(posts);
    }

    public Optional<List<Posts>> getCategoryPosts(String catagory){
        List posts = postsRepository.findPostsByCatagoryOrderByTime(catagory);
        return Optional.of(posts);
    }

    public Optional<List<Posts>> getUserPosts(String player){
       List posts = postsRepository.findPostsByName(player);
        return Optional.of(posts);
    }
    public void insertPost(Posts posts) {
        postsRepository.save(posts);
    }


    public void verifyPost(int id){
        Posts posts = postsRepository.getOne(String.valueOf(id));
        posts.setVerified(true);
        postsRepository.save(posts);
    }

    public void deletePost(int id){
        postsRepository.deleteById(String.valueOf(id));
    }

}
