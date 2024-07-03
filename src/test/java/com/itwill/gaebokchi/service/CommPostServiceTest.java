package com.itwill.gaebokchi.service;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.itwill.gaebokchi.dto.CommentItemDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(
        locations = { "file:src/main/webapp/WEB-INF/application-context.xml" }
)
public class CommPostServiceTest {

    @Autowired private CommPostService commPostService;
    
    @Test
    public void testReadByPostId() {
        List<CommentItemDto> list = commPostService.readAllComment(43);
        for (CommentItemDto dto : list) {
            log.debug(dto.toString());
        }
    }
    
}