package service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.ReportDAO;

public class ReportService {
	private DataSource dataSource;

	public ReportService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean addReport(String userId, int productSeq, String reportContent){
		boolean result = false;
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			result = new ReportDAO(conn).addReport(userId, productSeq, reportContent);
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(conn != null){
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
				}
			}
		}
		return result;
	}
}
