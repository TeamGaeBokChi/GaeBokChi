package com.itwill.gaebokchi.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwill.gaebokchi.dto.expertUserCreateDto;
import com.itwill.gaebokchi.dto.findIdDto;
import com.itwill.gaebokchi.dto.findPasswordDto;
import com.itwill.gaebokchi.dto.normalUserCreateDto;
import com.itwill.gaebokchi.repository.User;
import com.itwill.gaebokchi.repository.UserDao;
import com.itwill.gaebokchi.dto.AcceptListDto;
import com.itwill.gaebokchi.dto.ExchangeListDto;
import com.itwill.gaebokchi.dto.UpdatePasswordDto;
import com.itwill.gaebokchi.dto.UpdatePointDto;
import com.itwill.gaebokchi.dto.UserSignInDto;
import com.itwill.gaebokchi.dto.exchangeInfoDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {

	private final UserDao userDao;

	public boolean checkUserid(String userid) {
		log.debug("checkUserid(userid={})", userid);
		User user = userDao.selectByUserid(userid);
		if (user == null) {
			return true;
		} else {
			return false;
		}
	}

	public boolean checkNickname(String nickname) {
		log.debug("checkNickname(nickname={})", nickname);
		User user = userDao.selectByNickname(nickname);
		if (user == null) {
			return true;
		} else {
			return false;
		}
	}

	public boolean checkEmail(String email) {
		log.debug("checkEmail(email={})", email);
		User user = userDao.selectByEmail(email);
		if (user == null) {
			return true;
		} else {
			return false;
		}

	}

	public void nomalUserCreate(normalUserCreateDto dto) {
		log.debug("create({})", dto);
		User user = dto.toEntity();
		userDao.insertNormalUser(user);

	}

	@Transactional
	public void expertUserCreate(expertUserCreateDto dto) throws Exception {
		log.debug("create({})", dto);
		User user = dto.toEntity();
		try {
			userDao.insertExpertUser(user);
		} catch (Exception e) {
			throw new Exception("Failed to insert into pros table", e);
		}

	}

	public User read(UserSignInDto dto) {
		log.debug("UserSignInDto({})", dto);
		User user = userDao.selectByUseridAndPassword(dto.toEntity());

		return user;
	}

	public User findUserid(findIdDto dto) {
		log.debug("findIdDto({})", dto);
		User user = userDao.FindUserid(dto.toEntity());
		return user;
	}

	public boolean findPassword(findPasswordDto dto) {
		log.debug("findPasswordDto({})", dto);
		User user = userDao.FindPassword(dto.toEntity());
		if (user == null) {
			return false;
		} else {
			return true;
		}
	}

	public int UpdatePassword(UpdatePasswordDto dto) {
		log.debug("UpdatePassword({})", dto);

		int result = userDao.UpdatePassword(dto.toEntity());

		if (result == 0) {
			return 0;
		} else {
			return 1;
		}
	}

	public exchangeInfoDto exchangeInfo(String userId) {

		User user = userDao.selectByUserid(userId);

		exchangeInfoDto dto = exchangeInfoDto.fromEntity(user);

		log.debug("exchangeDto :{}", dto);

		return dto;
	}

	public int UpdatePoint(String userid, UpdatePointDto dto) {
		log.debug("UpdatePointDto :{}", dto);
		log.debug("sessionId :{}", userid);
		int result = userDao.UpdatePoint(userid, dto.getPassword(), dto.getWithdraw());
		if (result == 0) {
			return 0;
		} else {
			return 1;
		}

	}

	public List<AcceptListDto> AdminSignup() {
		log.debug("AdminSignup()");
		List<User> list = userDao.AdminSignup();

		return list.stream().map(AcceptListDto::fromEntity).toList();
	}

	public List<ExchangeListDto> AdminExchange() {
		log.debug("AdminSignup()");
		List<User> list = userDao.AdminExchange();

		return list.stream().map(ExchangeListDto::fromEntity).toList();
	}

	@Transactional
	public void acceptUser(String userid) {
		try {
			userDao.deleteAccept(userid);
			userDao.updateGrade(userid);
			userDao.intoPros(userid);
			userDao.intoLicense(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void rejectUser(String userid) {
		userDao.deleteAccept(userid);
	}

	public void acceptEx(String userid, int withdraw) {
		try {
			userDao.setPoint(userid, withdraw);
			userDao.setWithdraw(userid, withdraw);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void rejectEx(String userid, int withdraw) {
		userDao.setWithdraw(userid, withdraw);
	}

	public Map<String, String> getUserNicknames() {
		List<Map<String, String>> users = userDao.findAllUserNicknames();
		log.debug("users={}", users);
		Map<String, String> result = users.stream().collect(Collectors.toMap(user -> user.get("USERID"), user -> user.get("NICKNAME")));
		log.debug("result={}", result);
		return result;
	}


}
