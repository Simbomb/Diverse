package com.mycompany.test.repository;

import com.mycompany.test.entity.Posts;
import org.springframework.data.domain.Example;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.FluentQuery;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.function.Function;

@Repository
public interface PostsRepository extends JpaRepository<Posts, String> {

    List<Posts> findPostsByName(String name);

    List<Posts> findPostsByCatagoryOrderByTime(String catagory);

}