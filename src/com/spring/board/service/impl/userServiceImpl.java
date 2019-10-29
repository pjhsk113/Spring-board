package com.spring.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.board.dao.UserDao;
import com.spring.board.service.userService;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.UserVo;

@Service
public class userServiceImpl implements userService{
	
	@Autowired
	UserDao userDao;

	@Override
	public List<ComCodeVo> selectCodeList(ComCodeVo comcodeVo) throws Exception {
		
		return userDao.selectCodeList(comcodeVo);
	}

	@Override
	public int selectIdCnt(String userId) throws Exception {
		
		int result = 0;
		if(userId=="" || userId==null) {
			result=-1;
		}else {
			result = userDao.selectIdCnt(userId);
		}
		return result;
	}

	@Override
	public int userInsert(UserVo userVo) throws Exception {
		
		return userDao.userInsert(userVo);
	}

	@Override
	public int selectLoginCnt(UserVo userVo) throws Exception {
		
		int result = 0;
		if(userVo.getUserId()=="" || userVo.getUserId()==null) {
			result=-1;
		}else if(userVo.getUserPw()=="" || userVo.getUserPw()==null){
			result=-2;
		}else {
			result = userDao.selectLoginCnt(userVo);
		}
		return result;
	}

	@Override
	public UserVo selectUser(UserVo userVo) throws Exception {
		
		return userDao.selectUser(userVo);
	}
	
}
