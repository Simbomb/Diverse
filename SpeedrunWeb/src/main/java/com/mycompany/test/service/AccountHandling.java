package com.mycompany.test.service;


import com.mycompany.test.entity.Account;
import com.mycompany.test.repository.AccountRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Optional;

@Component
public class AccountHandling {
    @Autowired
    AccountRepository accountRepository;
    public Optional<List<List>> getAllAccount(){
        List accounts = accountRepository.findAll();
        return Optional.of(accounts);
    }

    public void insertUser(Account account){
        accountRepository.save(account);
    }

    public Account user(String username){
        return accountRepository.findByUsername(username).get();
    }
}
