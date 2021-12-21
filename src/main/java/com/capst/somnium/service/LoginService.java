package com.capst.somnium.service;

import com.capst.somnium.model.UserVO;

public interface LoginService {
	
	UserVO findUser(UserVO userVO);
	UserVO getUser(String userid);
	
	int updateUser(UserVO userVO);
	int insertUser(UserVO userVO);
	String deleteUser(String userid);
	
	UserVO findId(UserVO userVO);
	UserVO findPass(UserVO userVO);
	int updatePass(UserVO user);
}
