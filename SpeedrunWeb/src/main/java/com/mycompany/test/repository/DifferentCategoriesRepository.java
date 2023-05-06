package com.mycompany.test.repository;

import com.mycompany.test.entity.Account;
import com.mycompany.test.entity.DifferentCategories;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DifferentCategoriesRepository extends JpaRepository<DifferentCategories, Integer> {

    List<DifferentCategories> findAll();

}
