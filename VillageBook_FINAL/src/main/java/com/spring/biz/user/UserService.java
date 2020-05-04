package com.spring.biz.user;

public interface UserService {
	public UserVO getUser(UserVO vo);

	void insertUser(UserVO vo);

	void updateUser(UserVO vo);

	void updatePoint(UserVO vo, int old);
}
