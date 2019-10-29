package com.spring.board.service;

import java.util.List;

import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;

public interface boardService {

	public String selectTest() throws Exception;

	public List<BoardVo> SelectBoardList(PageVo pageVo, List<String> search) throws Exception;
		
	public List<ComCodeVo> selectCodeList(ComCodeVo comcodeVo) throws Exception;
	
	public BoardVo selectBoard(String boardType, int boardNum) throws Exception;

	public int selectBoardCnt() throws Exception;

	public int boardInsert(BoardVo boardVo) throws Exception;
	
	public int boardInsert(String[] boardType,String[] boardTitle,String[] boardComment,String[] creator) throws Exception;
	
	public int boardDelete(BoardVo boardVo) throws Exception;
	
	public int boardUpdate(BoardVo boardVo) throws Exception;
	
	
}
