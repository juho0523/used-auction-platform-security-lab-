package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dao.BidDAO;
import dao.ProductDAO;
import dao.UserDAO;
import dto.ProductBoxDTO;
import vo.BidVO;
import vo.ProductVO;

public class ProductService {
	private DataSource dataSource;

	public ProductService(){
		try {
			Context context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/myoracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean addProduct(String user_id, String fileName, String title, String category, String region, String bid_date,
			String price, String startPrice, String content){
		Connection conn = null;
		boolean result = false;
		int productSeq = 0;
		try {
			conn = dataSource.getConnection();
			ProductDAO pDAO = new ProductDAO(conn);
			ProductVO vo = new ProductVO(0, user_id, title, category, "서울특별시 " + region, null, null, Integer.parseInt(bid_date), Integer.parseInt(price), Integer.parseInt(startPrice), content, "s");
			conn.setAutoCommit(false);
			productSeq = pDAO.addProduct(vo);
			if(productSeq >= 1){
				result = pDAO.addProductImage(productSeq, fileName);
				if(result){
					BidDAO bDAO = new BidDAO(conn);
					result = bDAO.addBid(productSeq, user_id, 0);
				} 
			}
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
		return result;
	}

	public ProductBoxDTO getProduct(int productSeq) {
		Connection conn = null;
		ProductBoxDTO dto = null;
		try {
			conn = dataSource.getConnection();
			dto = new ProductDAO(conn).getProductBox(productSeq);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			if(conn != null){
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return dto;
	}

	public boolean setProductState(int productSeq){
		Connection conn = null;
		boolean result = false;
		try {
			conn = dataSource.getConnection();
			BidDAO dao = new BidDAO(conn);
			UserDAO uDao = new UserDAO(conn);
			conn.setAutoCommit(false);
			result = dao.setProductState(productSeq);
			ArrayList<BidVO> refundList = dao.getBidList(productSeq);
			for(int i=0; i<refundList.size(); i++){
				uDao.setPoint(refundList.get(i).getUserId(), refundList.get(i).getBidPrice());
			}
			conn.commit();
		} catch (SQLException e) {
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
		return result;
	}
	public boolean addBid(int productSeq, String id, int bidPrice){
		Connection conn = null;
		boolean result = false;
		ProductBoxDTO dto = getProduct(productSeq);;
		try {
			conn = dataSource.getConnection();
			BidDAO dao = new BidDAO(conn);
			conn.setAutoCommit(false);
			result = dao.pointDeduction(productSeq, id, bidPrice);
			if(result){
				result = dao.addBid(productSeq, id, bidPrice);
				if(dto.getPrice() == bidPrice){
					result = setProductState(productSeq);
				}
			}
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
		return result;
	}

	public boolean setProductStateByEndDate(ArrayList<ProductBoxDTO> dtoList) {
		Connection conn = null;
		boolean result = false;
		LocalDateTime now = LocalDateTime.now();
		try {
			conn = dataSource.getConnection();
			BidDAO bDao = new BidDAO(conn);
			UserDAO uDao = new UserDAO(conn);
			conn.setAutoCommit(false);
			for(int i=0; i<dtoList.size(); i++){
				System.out.println(dtoList.get(i).getEndDate().isAfter(now));
				if(dtoList.get(i).getEndDate().isBefore(now)){
					if(dtoList.get(i).getBidCount() == 0){
						uDao.setProductState(dtoList.get(i).getProductSeq()); //상태 -> E
					}
					else{
						bDao.setProductState(dtoList.get(i).getProductSeq()); //상태 -> T
					}
				}
			}
			conn.commit();
		} catch (SQLException e) {
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
		return result;
	}
}