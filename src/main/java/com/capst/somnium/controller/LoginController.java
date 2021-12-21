package com.capst.somnium.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.capst.somnium.model.UserVO;
import com.capst.somnium.service.BoardService;
import com.capst.somnium.service.LoginService;
import com.capst.somnium.utils.AES256Util;

@Controller @RequestMapping("/member")
public class LoginController {
	
	String key = "jangan_1182@2021";
	
	@Autowired
	private LoginService loginService;
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		return "/member/login";
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String onlogin(@Valid UserVO userVO, BindingResult result, Model model, HttpSession session) {
		
		if(result.hasFieldErrors("userid") || result.hasFieldErrors("passwd")) {
			model.addAllAttributes(result.getModel());
			return "/member/login";
		}
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	
		UserVO loginUser = this.loginService.findUser(userVO);
		
		if(loginUser == null) {
			model.addAttribute("userid", "");
			model.addAttribute("msgCode", "등록되지 않은 아이디입니다.");
			return "/member/login";
		}
		else if(encoder.matches(userVO.getPasswd(), loginUser.getPasswd())) {
			session.setAttribute("userid", loginUser.getUserid());
			session.setAttribute("username", loginUser.getName());
			return "redirect:/board/list";
		}
		else {
			model.addAttribute("userid", "");
			model.addAttribute("msgCode", "비밀번호가 틀렸습니다.");
			return "/member/login";
		}
	}
	
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String toUserEntryView(Model model) {
		model.addAttribute("userVO", new UserVO());
		return "/member/joinForm";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String onSubmit(@Valid UserVO userVO, BindingResult result, Model model) throws Exception {
		
		if(result.hasErrors()) {
			model.addAllAttributes(result.getModel());
			return "/member/joinForm";
		}
		
		//passwd 암호화 (BCrypt)
		//String hashPass = BCrypt.hashpw(userVO.getPasswd(), BCrypt.gensalt(12));
		
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashPass = passwordEncoder.encode(userVO.getPasswd());
		userVO.setPasswd(hashPass);
		
		//생년월일 암호화 (aes256)		
		AES256Util aes256 = new AES256Util(key);
		
		String hashBirthday = aes256.aesEncode(userVO.getBirthday());
		userVO.setBirthday(hashBirthday);
		
		if(this.loginService.insertUser(userVO) != 0) {
			model.addAttribute("user", userVO);
			model.addAttribute("msgCode", "축하합니다! 회원가입이 완료되었습니다. 로그인 하십시오."); //등록성공
			return "/member/login";
		}else {
			model.addAttribute("msgCode", "죄송합니다! 회원가입이 실패하였습니다. 다시 진행하여 주십시오."); //등록실패
			return "/member/joinForm";
		}
		
	}
	
	
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET) //ID중복체크
	@ResponseBody 
	public String idCheck( HttpServletRequest request){

		String userid = request.getParameter("userid");
		  
		JSONObject  obj = new JSONObject();
	
		UserVO loginUser = this.loginService.getUser(userid);
	
		if(loginUser != null){
			obj.put("msg", "false");
			return obj.toString();
		}
		else {
			obj.put("msg", "true");
			return obj.toString();
		}
	}
	
	
	@RequestMapping(value="/editUser", method=RequestMethod.GET)
	public String toUserEditView(HttpSession session, Model model) throws Exception{
		
		String userid = session.getAttribute("userid").toString();
		
		UserVO loginUser = this.loginService.getUser(userid);
		
		AES256Util aes256 = new AES256Util(key);
		
		if(loginUser == null) {
			model.addAttribute("userid", "");
			model.addAttribute("errCode", 1);
			
			return "/member/login";
		}else {
			String hashBirthday = aes256.aesDecode(loginUser.getBirthday());
			loginUser.setBirthday(hashBirthday);
			model.addAttribute("userVO", loginUser);
			return "/member/editForm";
		}
	}
	
	
	@RequestMapping(value="/editUser", method=RequestMethod.POST)
	public String onEditSave(@ModelAttribute UserVO userVO, Model model) throws Exception{
		
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashPass = passwordEncoder.encode(userVO.getPasswd());
		userVO.setPasswd(hashPass);
		
		//생년월일 암호화 (aes256)
		
		AES256Util aes256 = new AES256Util(key);
		
		String hashBirthday = aes256.aesEncode(userVO.getBirthday());
		userVO.setBirthday(hashBirthday);
		
		if(this.loginService.updateUser(userVO) != 0) {
			model.addAttribute("errMsg", null);
			model.addAttribute("userVO", userVO);
			
			return "redirect:/board/list";
		}else {
			model.addAttribute("errMsg", "정보수정 실패");
			return "/member/editForm";
		}
	}
	
	
	@RequestMapping(value="/findId", method=RequestMethod.GET)
	public String toFindId() throws Exception{
		return "/member/findIdForm";
	}
	
	
	@RequestMapping(value="/findId", method=RequestMethod.POST)
	public String onFindId(@Valid UserVO userVO, BindingResult result, Model model) throws Exception{
		
		if(result.hasFieldErrors("name") || result.hasFieldErrors("email")) {
			model.addAllAttributes(result.getModel());
			return "/member/findIdForm";
		}
		
		UserVO findId = this.loginService.findId(userVO);
		
		if(findId == null) {
			model.addAttribute("errMsg", "존재하지 않는 회원정보입니다.");
			return "/member/findIdForm";
		}else {
			model.addAttribute("userVO", findId);
			return "/member/findIdSucess";
		}
	}
	
	
	@RequestMapping(value="/findPass", method=RequestMethod.GET)
	public String toFindPass() throws Exception{
		return "/member/findPassForm";
	}
	
	
	@RequestMapping(value="/findPass", method=RequestMethod.POST)
	public String onFindPass(@Valid UserVO userVO, BindingResult result, Model model) throws Exception{
		
		if(result.hasFieldErrors("userid") || result.hasFieldErrors("email")) {
			model.addAllAttributes(result.getModel());
			return "/member/findPassForm";
		}
		
		UserVO findPass = this.loginService.findPass(userVO);
		
		if(findPass == null) {
			model.addAttribute("errMsg", "존재하지 않는 회원정보입니다.");
			return "/member/findPassForm";
		}else {
			model.addAttribute("userVO", findPass);
			return "/member/findPassEdit";
		}
	}
	
	
	@RequestMapping(value="/editPass", method=RequestMethod.POST)
	public String onEditPass(@Valid UserVO userVO, BindingResult result, Model model) throws Exception{
		
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashPass = passwordEncoder.encode(userVO.getPasswd());
		userVO.setPasswd(hashPass);
		
		int editPass = this.loginService.updatePass(userVO);
		
		if(editPass == 0) {
			model.addAttribute("msgCode", "비밀번호 변경에 실패하였습니다. 다시 시도해 주십시오."); //등록성공
			
			return "/member/login";
			
		}else {
			model.addAttribute("msgCode", "비밀번호가 정상적으로 변경되었습니다.");
			
			return "/member/login";
		}
	}
	
	
	@RequestMapping(value="/delete", method=RequestMethod.GET)
	public String delete() {
		return "/member/deleteForm";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String ondelete(@Valid UserVO userVO, BindingResult result, Model model, HttpSession session) {
		
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		
		UserVO loginUser = this.loginService.findUser(userVO);
		
		if(encoder.matches(userVO.getPasswd(), loginUser.getPasswd())) {
			
			return "/member/deleteAgree";
		}else {
			model.addAttribute("msgCode", "비밀번호가 틀렸습니다.");
			return "/member/deleteForm";
		}
		
	}
	
	
	@RequestMapping(value="/deleteAgree", method=RequestMethod.GET)
	public String deleteAgree(Model model, HttpSession session) {
		
		String userid = session.getAttribute("userid").toString();
		
		try {
			this.loginService.deleteUser(userid);
			model.addAttribute("msgCode", "계정이 정상적으로 삭제되었습니다.");
			session.invalidate();
			return "/member/login";
		} catch (EmptyResultDataAccessException e){
			model.addAttribute("msgCode", "계정삭제 중 문제가 발생했습니다. 다시시도하여 주십시오.");
			return "/member/deleteForm";		
		}
		
	}
	
	
	@RequestMapping("/logout")
	public String logout(HttpSession session){
	session.invalidate();
	return "redirect:/";
	}

	
}
