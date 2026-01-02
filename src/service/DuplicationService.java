package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.UserDAO;

public class DuplicationService {
	private DataSource dataSource;
	private Connection conn;
	
	public DuplicationService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean idCheck(String id){
		boolean result = false;
		Connection conn = null;
		

		try {
			conn = dataSource.getConnection();
			result = new UserDAO(conn).idCheck(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		return result;
	}

	
	
	public boolean nickCheck(String id){
		boolean result = false;
		Connection conn = null;
		

		try {
			conn = dataSource.getConnection();
			result = new UserDAO(conn).nickCheck(id);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		return result;
	}	
	
}
