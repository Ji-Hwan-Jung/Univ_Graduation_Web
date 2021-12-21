package com.capst.somnium.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.capst.somnium.model.UserVO;

@Mapper
public interface LoginMapper {
	
	UserVO findUser(UserVO userVO);
	UserVO getUser(String userid);
	
	int updateUser(UserVO userVO);
	int insertUser(UserVO userVO);
	
	String deleteUser(String userid);
	
	UserVO findId(UserVO userVO);
	UserVO findPass(UserVO userVO);
	int updatePass(UserVO userVO);
	

	//List<User> getUserList();

}
