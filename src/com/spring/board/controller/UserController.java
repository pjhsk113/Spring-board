package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.HomeController;
import com.spring.board.service.userService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.ComCodeVo;
import com.spring.board.vo.UserVo;
import com.spring.common.CommonUtil;

@Controller
public class UserController {
	
	@Autowired 
	userService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/user/register.do", method = RequestMethod.GET)
	public String register(Locale locale, Model model, ComCodeVo comcodeVo) throws Exception{
		List<ComCodeVo> codeList = new ArrayList<ComCodeVo>();
		
		codeList = userService.selectCodeList(comcodeVo);
		
		model.addAttribute("codeList", codeList);
		
		return "user/register";
	}
	
	@RequestMapping(value = "/user/checkId.do", method = RequestMethod.GET)
	@ResponseBody
	public int Duplicate(@RequestParam("userId") String userId) throws Exception{
		int result =0;
		result = userService.selectIdCnt(userId);
		
		return result;
	}
	
	@RequestMapping(value = "/user/userJoin.do", method = RequestMethod.POST)
	@ResponseBody
	public String userJoin(Locale locale,UserVo userVo) throws Exception{
		
		HashMap<String, String> result = new HashMap<String, String>();
		CommonUtil commonUtil = new CommonUtil();
		
		int resultCnt = userService.userInsert(userVo);
		
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = commonUtil.getJsonCallBackString(" ",result);
		
		System.out.println("callbackMsg::"+callbackMsg);
		
		return callbackMsg;
	}
	
	@RequestMapping(value = "/user/userLogin.do", method = RequestMethod.GET)
	public String login(Locale locale, Model model) throws Exception{
		
		return "user/login";
	}
	
	@RequestMapping(value = "/user/userLoginOk.do", method = RequestMethod.POST)
	@ResponseBody
	public int loginOk(Locale locale, UserVo userVo,HttpServletRequest request) throws Exception{
		
		HttpSession session = request.getSession();
		
		int result = 0;
		result = userService.selectLoginCnt(userVo);
		UserVo user = null;
		if(result > 0) {
			user = userService.selectUser(userVo);
			session.setAttribute("userInfo", user);
		}
		return result;
	}
	@RequestMapping(value = "/user/userLogout.do", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request) {

		request.getSession().removeAttribute("userInfo");

		return new ModelAndView("redirect:/board/boardList.do");
	}
}
