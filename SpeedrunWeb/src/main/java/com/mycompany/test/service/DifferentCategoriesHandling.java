package com.mycompany.test.service;

import com.mycompany.test.entity.Account;
import com.mycompany.test.entity.DifferentCategories;
import com.mycompany.test.repository.AccountRepository;
import com.mycompany.test.repository.DifferentCategoriesRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class DifferentCategoriesHandling {
    @Autowired
    DifferentCategoriesRepository differentCategoriesRepository;
    public Optional<List<DifferentCategories>> getAllCategories(){
        List<DifferentCategories> catagories = differentCategoriesRepository.findAll();
        return Optional.of(catagories);
    }

    public void addCatagory(String catagory){
        DifferentCategories differentCategories = new DifferentCategories();
        differentCategories.setCategoryName(catagory);
        differentCategoriesRepository.save(differentCategories);
    }

}