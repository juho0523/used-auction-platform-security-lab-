package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.UserDAO;
import vo.UserVO;

public class UserService {
	private DataSource dataSource;

	public UserService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getUser(String userId) {
		Connection conn = null;
		int point = 0;
		try {
			conn = dataSource.getConnection();
			point = new UserDAO(conn).getUser(userId).getPoint();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return point;
	}
	
	public UserVO getUsers(String userId){
		Connection conn = null;
		UserVO vo = new UserVO();
		
		try {
			conn = dataSource.getConnection();
			vo = new UserDAO(conn).getUser(userId);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
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

