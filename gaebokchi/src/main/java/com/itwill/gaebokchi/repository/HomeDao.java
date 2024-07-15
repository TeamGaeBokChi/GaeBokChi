package com.itwill.gaebokchi.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;



public interface HomeDao {
	List<Home> getUsersPointRank();
}
