package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Map;

import dto.NotiBoxDTO;
import dto.ProductBoxDTO;
import query.NotiQuery;
import query.ProductQuery;

public class NotiDAO {
	private Connection conn;

	public NotiDAO(Connection conn){
		this.conn = conn;
	}
	
	public boolean addNoti(String id, int productSeq){
		
		try(PreparedStatement pstmt = conn.prepareStatement(NotiQuery.ADD_NOTI)){
			pstmt.setString(1, id);
			pstmt.setInt(2, productSeq);
			
			return pstmt.executeUpdate() == 1;
		} catch (SQLException e) {e.printStackTrace();}
		
		return false;
	}
	
	public ArrayList<String> getNotiUserList(int productSeq){	// 알림 날릴 사용자들
		ArrayList<String> list = new ArrayList<>();
		
		try(PreparedStatement pstmt = conn.prepareStatement(NotiQuery.GET_NOTI_USERS)){
			pstmt.setInt(1, productSeq);
			pstmt.setInt(2, productSeq);
			pstmt.setInt(3, productSeq);
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()){
					list.add(rs.getString(1));
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	
	public ArrayList<NotiBoxDTO> getNotiList(String id){	// 알림 목록
		ArrayList<NotiBoxDTO> list = new ArrayList<>();
		
		try(PreparedStatement pstmt = conn.prepareStatement(NotiQuery.GET_NOTI_LIST)){
			pstmt.setString(1, id);			
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()){
					NotiBoxDTO vo = new NotiBoxDTO(rs.getString("product_img"), rs.getString("title"),
							rs.getString("nickname"), rs.getString("category"), rs.getInt("bid_price"), 
							rs.getInt("bid_seq"), rs.getInt("product_seq"), rs.getString(11));
					list.add(vo);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;	
	}
	
	public boolean setNotiState(String id){
		try(PreparedStatement pstmt = conn.prepareStatement(NotiQuery.SET_NOTI_STATE)){
			pstmt.setString(1, id);
			int num = pstmt.executeUpdate();
			return pstmt.executeUpdate() >= 1;
		} catch (SQLException e) {e.printStackTrace();}
		
		return false;
	}
	
	public String getNotiState(String id){
		String state = null;
		try(PreparedStatement pstmt = conn.prepareStatement(NotiQuery.GET_NOTI_STATE)){
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()){
					state = rs.getString(1);
				}
			}
			
		} catch (SQLException e) {e.printStackTrace();}
		return state;
	}
}
