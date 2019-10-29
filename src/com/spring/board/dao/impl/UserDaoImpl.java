package com.spring.board.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.board.dao.UserDao;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ComCodeVo> selectCodeList(ComCodeVo comcodeVo) throws Exception {
		
		return sqlSession.selectList("user.codeList");
	}

	@Override
	public int selectIdCnt(String userId) throws Exception {
		
		return sqlSession.selectOne("user.userIdCnt", userId);
	}

	@Override
	public int userInsert(UserVo userVo) throws Exception {
		
		return sqlSession.insert("user.userJoin", userVo);
	}

	@Override
	public int selectLoginCnt(UserVo userVo) throws Exception {
		
		return sqlSession.selectOne("user.userLoginCnt", userVo);
	}

	@Override
	public UserVo selectUser(UserVo userVo) throws Exception {
		
		return sqlSession.selectOne("user.selectUserbyId", userVo);
	}
	
}
