package com.mycompany.test.repository;

import com.mycompany.test.entity.Forum;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ForumRepository extends JpaRepository<Forum, String> {


    List<Forum> findAllByOrderByHead();


}
