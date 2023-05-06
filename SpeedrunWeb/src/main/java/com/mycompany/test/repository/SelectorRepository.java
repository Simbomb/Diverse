package com.mycompany.test.repository;

import com.mycompany.test.entity.Selector;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SelectorRepository extends JpaRepository<Selector, Integer> {

}
