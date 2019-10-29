package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.UserVo;

public interface userService {

	public List<ComCodeVo> selectCodeList(ComCodeVo comcodeVo) throws Exception;
	
	public UserVo selectUser(UserVo userVo) throws Exception;
	
	public int selectIdCnt(String userId) throws Exception;
	
	public int selectLoginCnt(UserVo userVo) throws Exception;
	
	public int userInsert(UserVo userVo) throws Exception;
}
