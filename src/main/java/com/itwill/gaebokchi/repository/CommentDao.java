package com.itwill.gaebokchi.repository;

import java.util.List;

public interface CommentDao {

    // 포스트에 달려 있는 모든 댓글 검색
    List<Comment> selectByPostId(Integer postId);
    
    // 포스트에 새로운 댓글 추가
    int insertComment(Comment comment);
    
    // 댓글 내용, 수정 시간을 업데이트
    int updateComment(Comment comment);
    
    // 댓글 아이디로 삭제
    int deleteCommentById(Integer id);
    
    // 포스트에 달려 있는 모든 댓글 삭제
    int deleteCommentsByPostId(Integer postId);
    
    // 포스트에 달려 있는 댓글 개수를 검색
    Integer selectCommentCount(Integer postId);
    
    // 댓글 아이디(PK)로 검색
    Comment selectCommentById(Integer id);
}
