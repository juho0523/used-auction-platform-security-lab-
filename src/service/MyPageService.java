package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import dao.UserDAO;
import vo.UserVO;

public class MyPageService {
	private DataSource dataSource;
	private UserDAO dao;
	
	public MyPageService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public UserVO getUser(String id){
		UserVO userInfo = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			if(new UserDAO(conn).getUser(id) != null){
				conn.commit();
				userInfo = new UserDAO(conn).getUser(id);
			}
		} catch (SQLException e) {
			// TODO: handle exception
			if(conn != null){
				try {
					conn.rollback();
					
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			e.printStackTrace();
		}
		finally{
			if(conn != null){
				try {
					conn.setAutoCommit(true);
					conn.close();

				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		}

		return userInfo;
	}
}
