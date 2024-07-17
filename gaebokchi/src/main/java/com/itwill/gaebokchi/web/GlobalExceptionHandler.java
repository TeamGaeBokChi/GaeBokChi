package com.itwill.gaebokchi.web;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.ModelAndView;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler({SQLException.class, SQLIntegrityConstraintViolationException.class})
    @ResponseStatus(HttpStatus.FOUND) // Optional: HTTP 상태 코드 설정
    public ModelAndView handleSQLException() {
        return new ModelAndView("redirect:/admin/adminPosts");
    }
    
}
