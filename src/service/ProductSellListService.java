package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.ProductDAO;
import dto.ProductBoxDTO;

public class ProductSellListService {
	private DataSource dataSource;
	private Connection conn;
	
	public ProductSellListService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ProductBoxDTO> getSellingList(String userId){
		ArrayList<ProductBoxDTO> sellingList = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			sellingList = new ProductDAO(conn).getSellingHistory(userId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return sellingList;
	}

	public ArrayList<ProductBoxDTO> getSellCompleteList(String userId){
		ArrayList<ProductBoxDTO> sellCompleteList = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			sellCompleteList = new ProductDAO(conn).getSellCompleteHistory(userId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return sellCompleteList;
	}
	
}










