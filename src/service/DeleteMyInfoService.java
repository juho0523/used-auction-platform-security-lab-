package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import dao.UserDAO;

public class DeleteMyInfoService {
	private DataSource dataSource;
	private UserDAO dao;
	
	public DeleteMyInfoService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean setUserType(String id){
		boolean result = false;
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);			
			
			if(new UserDAO(conn).setUserType(id)){
				conn.commit();
				result = true;
			}
		} catch (Exception e) {
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
		
		
		return result;
	}
	
}
