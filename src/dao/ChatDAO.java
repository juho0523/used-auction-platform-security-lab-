package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import dto.ChatBoxDTO;
import query.ChatQuery;
import vo.ChatVO;

public class ChatDAO {
	private Connection conn;
	
	public ChatDAO(Connection conn){
		this.conn = conn;
	}
	
	public ArrayList<ChatBoxDTO> getChatList(String userId){
		ArrayList<ChatBoxDTO> chatList = new ArrayList<ChatBoxDTO>();
		DateTimeFormatter formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		
		try (PreparedStatement pstmt = conn.prepareStatement(ChatQuery.GET_CHAT_ROOM_LIST);){
			pstmt.setString(1, userId);
			pstmt.setString(2, userId);
			pstmt.setString(3, userId);
			pstmt.setString(4, userId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()){
				ChatBoxDTO dto = new ChatBoxDTO(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), LocalDateTime.parse(rs.getString(6),formmatter), rs.getString(7), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11), rs.getInt(12));		
				chatList.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return chatList;
	}
	
	public ArrayList<ChatVO> getChat(int productSeq, String fromId, String toId){
		ArrayList<ChatVO> chat = new ArrayList<ChatVO>();
		DateTimeFormatter formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		
		try (PreparedStatement pstmt = conn.prepareStatement(ChatQuery.GET_CHAT_MESSAGE_LIST);){
			pstmt.setInt(1, productSeq);
			pstmt.setString(2, fromId);
			pstmt.setString(3, toId);
			pstmt.setString(4, toId);
			pstmt.setString(5, fromId);
			try (ResultSet rs = pstmt.executeQuery();) {
				while(rs.next()){
					ChatVO vo = new ChatVO(rs.getInt(1), rs.getInt(2), rs.getString(3), rs.getString(4), rs.getString(5), LocalDateTime.parse(rs.getString(6),formmatter), rs.getString(7));
					chat.add(vo);
				}				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return chat;
	}
	
	public boolean addChat(int productSeq, String fromId, String toId, String chatContent){
		
		try (PreparedStatement pstmt = conn.prepareStatement(ChatQuery.ADD_CHAT);){
			pstmt.setInt(1, productSeq);
			pstmt.setString(2, fromId);
			pstmt.setString(3, toId);
			pstmt.setString(4, chatContent);
			if(pstmt.executeUpdate() == 1) return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
	public boolean readChat(int productSeq, String fromId, String toId){
		
		try (PreparedStatement pstmt = conn.prepareStatement(ChatQuery.READ_CHAT);){
			pstmt.setInt(1, productSeq);
			//pstmt.setString(2, fromId);
			//pstmt.setString(3, toId);
			pstmt.setString(2, toId);
			pstmt.setString(3, fromId);
			if(pstmt.executeUpdate() >= 1) return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return false;
	}
	
	public int getUnreadChat(String userId){
		int count = 0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(ChatQuery.GET_UNREAD_CHAT);){
			pstmt.setString(1, userId);
			//pstmt.setString(2, userId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return count;
	}
	
}









