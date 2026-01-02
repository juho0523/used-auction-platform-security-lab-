package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.ProductDAO;
import dto.ProductBoxDTO;

public class ProductBuyListService {
	private DataSource dataSource;
	private Connection conn;
	
	public ProductBuyListService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	
	
	public ArrayList<ProductBoxDTO> getBuyList(String userId) {
		ArrayList<ProductBoxDTO> buyList = new ArrayList<>();
		
		try {
			conn = dataSource.getConnection();
			buyList = new ProductDAO(conn).getBuyingHistory(userId);
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
		
		return buyList;
	}

}
