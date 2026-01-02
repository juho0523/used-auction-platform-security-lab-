package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import dao.ChatDAO;
import vo.ChatVO;

public class ChatService {
	private DataSource dataSource;
	
	public ChatService(){
		Context context;
		try {
			context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ChatVO> getChat(int productSeq, String fromId, String toId){
		ArrayList<ChatVO> chat = new ArrayList<ChatVO>();
		
//		try (Connection conn = dataSource.getConnection();){
//			chat = new ChatDAO(conn).getChat(productSeq, fromId, toId);
//			
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
		
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			chat = new ChatDAO(conn).getChat(productSeq, fromId, toId);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return chat;
	}
	
	public boolean addChat(int productSeq, String fromId, String toId, String chatContent){
		boolean result = false;
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			
//			System.out.println("상품번호 : "+productSeq);
//			System.out.println("보낸사람 : "+fromId);
//			System.out.println("받는사람 : "+toId);
//			System.out.println("채팅내용 : "+chatContent);
			
			result = new ChatDAO(conn).addChat(productSeq, fromId, toId, chatContent);
			conn.commit();
		} catch (SQLException e) {
			if(conn != null){
				try {
					conn.rollback();
				} catch (SQLException e1) {
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
					e.printStackTrace();
				}
			}
		}
		
		return result;
	}

	public boolean readChat(int productSeq, String fromId, String toId) {
		boolean result = false;
		Connection conn = null;

		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			
			result = new ChatDAO(conn).readChat(productSeq, fromId, toId);
			conn.commit();
		} catch (SQLException e) {
			if(conn != null){
				try {
					conn.rollback();
				} catch (SQLException e1) {
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
					e.printStackTrace();
				}
			}
		}
		
		return result;
	}
	
	public int getUnreadChat(String userId){
		int count = 0;
		
		try (Connection conn = dataSource.getConnection();){
			count = new ChatDAO(conn).getUnreadChat(userId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
	}
	
}












