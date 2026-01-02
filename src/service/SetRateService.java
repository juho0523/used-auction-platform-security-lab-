package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.UserDAO;

public class SetRateService {
	private DataSource dataSource;
	
	public SetRateService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void setRate(int productSeq, double rate) {
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			UserDAO dao = new UserDAO(conn);
			
			dao.setRate(productSeq, rate);
			dao.setRateCount(productSeq);
			dao.setProductState(productSeq);
			
//			if(dao.setRateCount(productSeq)){
//				if(dao.setRate(productSeq, rate)){
//					dao.setProductState(productSeq);
//				}
//			}
			
			conn.commit();
		} catch (SQLException e) {
			if(conn != null){
				try {
					conn.rollback();
				} catch (SQLException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
			e.printStackTrace();
		} finally {
			if(conn != null){
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return ;
	}

}
