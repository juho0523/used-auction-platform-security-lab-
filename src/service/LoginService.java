package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import dao.UserDAO;
import vo.UserVO;

public class LoginService {
	private DataSource dataSource;

	public LoginService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public UserVO login(String userId, String userPw) {
		Connection conn = null;
		UserVO vo = null;
		
		try {
			conn = dataSource.getConnection();
			UserDAO dao = new UserDAO(conn);
			vo = dao.login(userId, userPw);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return vo;
	}
}