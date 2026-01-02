package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import dao.UserDAO;

public class FindIDService {
	private DataSource dataSource;
	private UserDAO dao;
	
	public FindIDService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public String findId(String name, String email, String phoneNumber){
		String userId = null;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			if(null != new UserDAO(conn).findId(name, email, phoneNumber)){
				conn.commit();
				userId = new UserDAO(conn).findId(name, email, phoneNumber);
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
				} catch (Exception e2) {
					// TODO: handle exception
					e2.printStackTrace();
				}
			}
		}

		return userId;
	}
	
	
	
	
	
}
