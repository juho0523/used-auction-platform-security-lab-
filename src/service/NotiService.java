package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.NotiDAO;
import dao.ProductDAO;
import dto.NotiBoxDTO;
import dto.ProductBoxDTO;

public class NotiService {
	private DataSource dataSource;
	private Connection conn;
	
	public NotiService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean addNoti(int productSeq){
		boolean res = false;
		ArrayList<String> list = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			NotiDAO nDAO = new NotiDAO(conn);
			
			conn.setAutoCommit(false);
			list = nDAO.getNotiUserList(productSeq);
			for(String id : list){
				nDAO.addNoti(id, productSeq);
			}
			res = true;
			conn.commit();
		} catch (Exception e) {
			if(conn != null){
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			e.printStackTrace();
		}finally{
			if(conn != null){
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return res;
	}
	
	public ArrayList<NotiBoxDTO> getNotiList(String id){
		ArrayList<NotiBoxDTO> list = new ArrayList<>();
		try {
			conn = dataSource.getConnection();
			list = new NotiDAO(conn).getNotiList(id);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return list;
	}
	
	public boolean setNotiState(String id){
		boolean res = false;
		try {
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			res = new NotiDAO(conn).setNotiState(id);
			conn.commit();
		} catch (Exception e) {
			if(conn != null){
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
			e.printStackTrace();
		}finally{
			if(conn != null){
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return res;
	}
	
	public String getNotiState(String id){
		String res = null;
		try {
			conn = dataSource.getConnection();
			res = new NotiDAO(conn).getNotiState(id);
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return res;
	}
}
