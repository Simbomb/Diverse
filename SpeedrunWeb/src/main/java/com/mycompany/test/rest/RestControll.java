/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.test.rest;
import com.mycompany.test.entity.*;
import com.mycompany.test.service.AccountHandling;
import com.mycompany.test.service.DifferentCategoriesHandling;
import com.mycompany.test.service.ForumHandling;
import com.mycompany.test.service.PostsHandling;
import com.oracle.wls.shaded.org.apache.xpath.operations.Mod;
import org.h2.engine.Mode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Optional;

/**
 *
 * @author simon
 */
@RestController
@SessionAttributes({"username", "catagory", "isAdmin", "player"})
public class RestControll {
    private static final Logger logger = LoggerFactory.getLogger(RestControll.class);
    @Autowired
    private AccountHandling accountHandling;
    @Autowired
    private DifferentCategoriesHandling differentCategoriesHandling;
    @Autowired
    private PostsHandling postsHandling;

    @Autowired
    private ForumHandling forumHandling;

    //LOGIN
    @GetMapping("/")
    ModelAndView login(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login");
        return mav;
    }

    @PostMapping("/login")
    ModelAndView backtologin(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login");
        return mav;
    }

    @PostMapping("/loginCheck")
    ModelAndView loginCheck(@RequestParam String username, @RequestParam String password){
        Account account = accountHandling.user(username);
        Optional<List<DifferentCategories>> differentCategories = differentCategoriesHandling.getAllCategories();
        ModelAndView mav = new ModelAndView();

        if(account.getPassword().equals(password)) {
            mav.setViewName("main");
            //differentCategories.get().forEach(log->System.out.println(log.toString()));

            mav.addObject("differentCategories", differentCategories.get());
            mav.addObject("username", username);
            mav.addObject("isAdmin", Boolean.toString(accountHandling.user(username).isAdmin()));
        }
        else
            mav.setViewName("login");

        return mav;

    }

    @PostMapping("/main")
    ModelAndView main(){
        ModelAndView mav = new ModelAndView();
        Optional<List<DifferentCategories>> differentCategories = differentCategoriesHandling.getAllCategories();
        mav.addObject("differentCategories", differentCategories.get());
        mav.setViewName("main");
        return mav;

    }

    @PostMapping("/catagory")
    ModelAndView catagory(@RequestParam String catagory){
        ModelAndView mav = new ModelAndView();
        Optional<List<Posts>> posts = postsHandling.getCategoryPosts(catagory);


        mav.addObject("posts", posts.get());
        mav.addObject("catagory", catagory);
        mav.setViewName("catagory");

        return mav;
    }
    @PostMapping("/playerlist")
    ModelAndView playerlist(@RequestParam String player){

        //posts.get().forEach(log->System.out.println(log.toString()));
            Optional<List<Posts>> posts = postsHandling.getUserPosts(player);
            ModelAndView mav = new ModelAndView();
            mav.addObject("posts", posts.get());
            mav.addObject("player", player);
            mav.setViewName("playerlist");
            return mav;
    }

    //TEST
    @PostMapping("/isAdmin")
    String formIsAdmin(@RequestParam String username){
        return Boolean.toString(accountHandling.user(username).isAdmin());
    }

    @GetMapping("/isAdmin")
    String isAdmin(@RequestParam String username){
        return Boolean.toString(accountHandling.user(username).isAdmin());
    }

    @PostMapping("/saveUser")
    ModelAndView insertUser(@RequestParam String username, @RequestParam String password) throws Exception {
        Account account = new Account();
        account.setUsername(username);
        account.setPassword(password);
        account.setAdmin(false);
        accountHandling.insertUser(account);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login");
        return mav;
    }
    @GetMapping("/getUsers")
    List<List> getUser() throws Exception {
        Optional<List<List>> allAccount = accountHandling.getAllAccount();
        if(allAccount.isEmpty()){
            throw new Exception("No account exists");
        }
        return allAccount.get();
    }
    @PostMapping("/upload")
    ModelAndView insertPost(@RequestParam String link, @RequestParam String time, @ModelAttribute("username") String username, @ModelAttribute("catagory") String catagory) throws Exception {
        Posts post = new Posts();
        post.setName(username);
        post.setLink(link);
        post.setTime(time);

        java.sql.Date date =new java.sql.Date(System.currentTimeMillis());
        post.setDate(date.toString());

        post.setCatagory(catagory);
        post.setVerified(false);
        postsHandling.insertPost(post);
        ModelAndView mav = new ModelAndView();
        Optional<List<Posts>> posts = postsHandling.getCategoryPosts(catagory);
        mav.addObject("posts", posts.get());
        mav.setViewName("catagory");
        return mav;
    }
    @PostMapping("/catagoryVerified")
    ModelAndView verifyPost(@RequestParam int verified, @ModelAttribute("catagory") String catagory) throws Exception {
        postsHandling.verifyPost(verified);
        ModelAndView mav = new ModelAndView();
        Optional<List<Posts>> posts = postsHandling.getCategoryPosts(catagory);
        mav.addObject("posts", posts.get());
        mav.setViewName("catagory");
        return mav;
    }

    @PostMapping("/deletePost")
    ModelAndView deletePost(@RequestParam int id, @ModelAttribute("player") String player){
        ModelAndView mav = new ModelAndView();
        postsHandling.deletePost(id);
        Optional<List<Posts>> posts = postsHandling.getUserPosts(player);

        mav.addObject("posts", posts.get());
        mav.setViewName("playerlist");

        return mav;
    }


    @PostMapping("/addCatagory")
    ModelAndView addCatagory(@RequestParam String catagory){
        differentCategoriesHandling.addCatagory(catagory);
        ModelAndView mav = new ModelAndView();
        Optional<List<DifferentCategories>> differentCategories = differentCategoriesHandling.getAllCategories();
        mav.addObject("differentCategories", differentCategories.get());
        mav.setViewName("main");
        return mav;
    }


    @PostMapping("/forum")
    ModelAndView forum(){
        ModelAndView mav = new ModelAndView();
        Optional<List<Forum>> forum = forumHandling.getAllForums();
        mav.addObject("forum", forum.get());
        mav.setViewName("forum");

        return mav;
    }

    @PostMapping("/comment")
    ModelAndView comment(@RequestParam String comment, @ModelAttribute("username") String username, @RequestParam String head){
        ModelAndView mav = new ModelAndView();
        Forum fo = new Forum();
        fo.setComment(comment);
        fo.setName(username);
        fo.setHead(head);
        forumHandling.addComment(fo);

        Optional<List<Forum>> forum = forumHandling.getAllForums();
        mav.addObject("forum", forum.get());
        mav.setViewName("main");

        return mav;
    }


}
