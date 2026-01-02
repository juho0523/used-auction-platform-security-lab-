package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import dao.ProductDAO;
import dto.ProductBoxDTO;

public class ProductListService {
	private DataSource dataSource;
	private Connection conn;
	
	public ProductListService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ProductBoxDTO> getList(String address){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();
		try {
			conn = dataSource.getConnection();
			list = new ProductDAO(conn).getList(address);
			
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
	
	public ArrayList<ProductBoxDTO> getListByCategory(String address, String category){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();
		try {
			conn = dataSource.getConnection();
			if(category.equals("전체"))
				list = new ProductDAO(conn).getList(address);
			else
				list = new ProductDAO(conn).getListByCategory(category, address);
			
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
	
	public ArrayList<ProductBoxDTO> getListByHope(String address, String hope){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();
		try {
			conn = dataSource.getConnection();
			if(hope.equals("등록순")){
				list = new ProductDAO(conn).getList(address);
			}
			else if(hope.equals("입찰건순")){
				list = new ProductDAO(conn).getListByBidCount(address);
			}
			else if(hope.equals("마감임박순")){
				list = new ProductDAO(conn).getListByEndDate(address);
			}
			
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
	
	public ArrayList<ProductBoxDTO> getListBySearch(String search, String address){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();
		try {
			conn = dataSource.getConnection();
			list = new ProductDAO(conn).getListBySearch(search, address);
			
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
}
