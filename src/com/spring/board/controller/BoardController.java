package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;
import com.spring.common.PageUtil;


@Controller
public class BoardController {
	
	@Autowired 
	boardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo,ComCodeVo comcodeVo
			,@RequestParam(value="search", required=false) List<String> search) throws Exception{
		
		List<BoardVo> boardList = new ArrayList<BoardVo>();
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();
		
		int page = 1;
		int totalCount = 0;
		
		boardList = boardService.SelectBoardList(pageVo, search);
		codeList = boardService.selectCodeList(comcodeVo);
		totalCount = boardService.selectBoardCnt();
		
		
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCount);
		model.addAttribute("pageNo", page);
		model.addAttribute("codeList", codeList);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		
		
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);
		
		return "board/boardView";
	}
	
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model,ComCodeVo comcodeVo) throws Exception{
		
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();
		
		codeList = boardService.selectCodeList(comcodeVo);
		
		model.addAttribute("codeList", codeList);
		
		return "board/boardWrite";
	}
	
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale
			,@RequestParam(value="boardType", required=false) String[] boardType
			,@RequestParam(value="boardTitle", required=false) String[] boardTitle
			,@RequestParam(value="boardComment", required=false) String[] boardComment
			,@RequestParam(value="creator", required=false) String[] creator) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardInsert(boardType, boardTitle, boardComment, creator);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/board/boardEdit.do", method = RequestMethod.GET)
	public String boardEdit(Locale locale, Model model
			,@RequestParam("boardType")String boardType
			,@RequestParam("boardNum")int boardNum) throws Exception{
		
		BoardVo boardVo = new BoardVo();
		boardVo = boardService.selectBoard(boardType,boardNum);
		
		model.addAttribute("boardType",boardType);
		model.addAttribute("boardNum",boardNum);
		model.addAttribute("board", boardVo);
		return "board/boardEdit";
	}
	
	@RequestMapping(value = "/board/boardEditAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardEditAction(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardUpdate(boardVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	
	@RequestMapping(value = "/board/boardDel.do", method = RequestMethod.GET)
	@ResponseBody
	public String boardDelete(Locale locale,BoardVo boardVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = boardService.boardDelete(boardVo);
	
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
}
