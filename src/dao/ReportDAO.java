package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import query.ReportQuery;
import vo.ReportVO;

public class ReportDAO {
	private Connection conn;

	public ReportDAO(Connection conn){
		this.conn = conn;
	}
	
	public boolean addReport(String id, int productSeq, String content){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(ReportQuery.ADD_REPORT);){
			pstmt.setString(1, id);
			pstmt.setInt(2, productSeq);
			pstmt.setString(3, content);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public ArrayList<ReportVO> getReportList(){
		ArrayList<ReportVO> reportList = null;
		
		return reportList;
	}
}
