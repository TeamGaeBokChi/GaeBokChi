package com.itwill.gaebokchi.repository;

import java.util.List;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.itwill.gaebokchi.repository.Comment;
import com.itwill.gaebokchi.repository.CommentDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ExtendWith(SpringExtension.class)
@ContextConfiguration(
        locations = { "file:src/main/webapp/WEB-INF/application-context.xml" }
)
public class CommentDaoTest {

    @Autowired // 스프링 컨테이너가 생성/관리하는 빈을 주입받음.
    private CommentDao commentDao;
    
//    @Test
    public void testSelect() {
        Assertions.assertNotNull(commentDao);
        
        List<Comment> list = commentDao.selectByPostId(43);
        for (Comment c : list) {
            log.debug(c.toString());
        }
    }
    
    @Test
    public void testInsert() {
        Comment comment = Comment.builder()
                .postId(43).author("dsa").content("댓글...")
                .build();
        int result = commentDao.insertComment(comment);
        Assertions.assertEquals(1, result);
    }
    
//    @Test
    public void testUpdate() {
        Comment comment = Comment.builder().id(3).content("update test ... ㅎㅎㅎ").build();
        int result = commentDao.updateComment(comment);
        Assertions.assertEquals(1, result);
    }
    
//    @Test
    public void testDeleteById() {
        int result = commentDao.deleteCommentById(2);
        Assertions.assertEquals(1, result);
    }
    
//    @Test
    public void testDeleteByPostId() {
        int result = commentDao.deleteCommentsByPostId(43);
        // 포스트 번호 102번에 댓글이 2개 있는 경우:
        Assertions.assertEquals(1, result);
    }
    
//    @Test
    public void testCommentCount() {
        Integer result = commentDao.selectCommentCount(102);
        // 테이블에 댓글이 5개 있는 경우
        Assertions.assertEquals(5, result);
    }
    
//    @Test
    public void testSelectById() {
        // 테이블에 댓글 아이디(PK)가 있는 경우
        Comment comment1 = commentDao.selectCommentById(9);
        Assertions.assertNotNull(comment1);
        log.debug(comment1.toString());
        
        // 테이블에 댓글 아이디가 없는 경우
        Comment comment2 = commentDao.selectCommentById(1);
        Assertions.assertNull(comment2);
    }
    
}
