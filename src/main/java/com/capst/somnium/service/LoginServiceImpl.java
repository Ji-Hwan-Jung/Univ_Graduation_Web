package com.capst.somnium.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capst.somnium.mapper.LoginMapper;
import com.capst.somnium.model.UserVO;

@Service(value = "loginService")
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	private LoginMapper loginMapper;

	@Override
	public UserVO findUser(UserVO userVO) {
		return loginMapper.findUser(userVO);
	}

	@Override
	public UserVO getUser(String userid) {
		return loginMapper.getUser(userid);
	}

	@Override
	public int insertUser(UserVO userVO) {
		return loginMapper.insertUser(userVO);
	}

	@Override
	public int updateUser(UserVO userVO) {
		return loginMapper.updateUser(userVO);
	}

	@Override
	public UserVO findId(UserVO userVO) {
		return loginMapper.findId(userVO);
	}

	@Override
	public UserVO findPass(UserVO userVO) {
		return loginMapper.findPass(userVO);
	}

	@Override
	public int updatePass(UserVO userVO) {
		return loginMapper.updatePass(userVO);
	}

	@Override
	public String deleteUser(String userid) {
		return loginMapper.deleteUser(userid);
	}
	
}
