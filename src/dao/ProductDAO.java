package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import dto.ProductBoxDTO;
import query.ProductQuery;
import vo.ProductVO;

public class ProductDAO {
	private Connection conn;
	
	public ProductDAO(Connection conn){
		this.conn = conn;
	}
	
	// 물품 정보
	public ProductVO getProduct(int productSeq){
		ProductVO vo = null;
		DateTimeFormatter formmatter = null;

		try (PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_PRODUCT)){
			pstmt.setInt(1, productSeq);
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next())
					 
					formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			
					vo = new ProductVO(productSeq, rs.getString("user_id"), rs.getString("title"), rs.getString("category"),
							rs.getString("address"), LocalDateTime.parse(rs.getString("end_date"),formmatter),
							LocalDateTime.parse(rs.getString("start_date"),formmatter), 0, rs.getInt("price"), 
							rs.getInt("start_price"), rs.getString("content"), rs.getString("state"));
					
			}
		}catch (Exception e) {e.printStackTrace();}
		
		return vo;
	}
	
	public ProductBoxDTO getProductBox(int productSeq){
		ProductBoxDTO dto = null;
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_PRODUCTBOX)){
			pstmt.setInt(1, productSeq);	
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				if(rs.next()){
					dto = new ProductBoxDTO(rs.getInt("img_seq"), rs.getInt("product_seq"), rs.getString("nickname"),
							rs.getString("title"), rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), 
							rs.getString("address"), LocalDateTime.parse(rs.getString("end_date"),formmatter), 
							rs.getString("state"), rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"), rs.getString("content"), rs.getString("user_id"));
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return dto;
	}
	
	public ProductBoxDTO getProductBoxChat(int productSeq){
		ProductBoxDTO dto = null;
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_PRODUCTBOX_CHAT)){
			pstmt.setInt(1, productSeq);	
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				if(rs.next()){
					dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"),
							rs.getString("title"), rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), 
							rs.getString("address"), LocalDateTime.parse(rs.getString("end_date"),formmatter), 
							rs.getString("state"), rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return dto;
	}
	
	// 물품 이미지
	public ArrayList<String> getProductImage(int productSeq){
		ArrayList<String> list = new ArrayList<>();
		
		try (PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_IMAGE)){
			pstmt.setInt(1, productSeq);
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()){
					list.add(rs.getString("product_img"));
				}
			}	
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	
	//상품 이미지 등록
	public boolean addProductImage(int productSeq, String productImage){
		
		try (PreparedStatement pstmt = conn.prepareStatement(ProductQuery.ADD_PRODUCT_IMG)){

			pstmt.setInt(1, productSeq);
			pstmt.setString(2, productImage);
			
			return pstmt.executeUpdate() == 1;
			
		} catch (SQLException e) {e.printStackTrace();}
		
		return false;
	}
	
	// 상품 등록
	public int addProduct(ProductVO vo){
		int productSeq = 0;
		try (PreparedStatement pstmt = conn.prepareStatement(ProductQuery.ADD_PRODUCT, new String[]{"PRODUCT_SEQ"})){
			pstmt.setString(1, vo.getUserId());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getCategory());
			pstmt.setString(4, vo.getAddress());
			pstmt.setInt(5, vo.getEndDateNum());
			pstmt.setInt(6, vo.getPrice());
			pstmt.setInt(7, vo.getStartPrice());
			pstmt.setString(8, vo.getContent());
			
			if(pstmt.executeUpdate() == 1){
				try(ResultSet rs = pstmt.getGeneratedKeys()){
					if(rs.next()){
						productSeq = rs.getInt(1);
					}
				}
			}
			
		} catch (SQLException e) {e.printStackTrace();}
		
		return productSeq;
	}
	
	/* 구매&판매 내역*/
	
	// 판매 중 내역 조회
	public ArrayList<ProductBoxDTO> getSellingHistory(String id){	
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_SELLING_HISTORY)){
			pstmt.setString(1, id);	
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"), rs.getString("title"),
							rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), rs.getString("address"),
							LocalDateTime.parse(rs.getString("end_date"),formmatter), rs.getString("state"),
							rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	
	// 거래 완료 내역 조회
	public ArrayList<ProductBoxDTO> getSellCompleteHistory(String id){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_SELL_COMPLETE_HISTORY)){
			pstmt.setString(1, id);	
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"), rs.getString("title"),
							rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), rs.getString("address"),
							LocalDateTime.parse(rs.getString("end_date"),formmatter), rs.getString("state"), 
							rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	
	// 구매 전체 내역 조회
	public ArrayList<ProductBoxDTO> getBuyingHistory(String id){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_BUYING_HISTORY)){
			pstmt.setString(1, id);	
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					if(rs.getString(12).equals(id)) continue;
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString(1), rs.getInt(2), rs.getString(3),
							rs.getString(4), rs.getInt(5), rs.getInt(6), rs.getString(7),
							LocalDateTime.parse(rs.getString(8),formmatter), rs.getString(9), 
							rs.getInt(10), rs.getInt(11));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	
	public ArrayList<ProductBoxDTO> getBuyCompleteHistory(String id){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try (PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_BUY_COMPLETE_HISTORY)){
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					if(rs.getString(12).equals(id)) continue;
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString(1), rs.getInt(2), rs.getString(3),
							rs.getString(4), rs.getInt(5), rs.getInt(6), rs.getString(7),
							LocalDateTime.parse(rs.getString(8),formmatter), rs.getString(9), rs.getInt(10),
							rs.getInt(11));
					list.add(dto);
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	/* 메인 리스트 */
	
	// 등록순 목록 조회(default)
	public ArrayList<ProductBoxDTO> getList(String address){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST)){
			pstmt.setString(1, "%"+address+"%");
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"), rs.getString("title"),
							rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), rs.getString("address"),
							LocalDateTime.parse(rs.getString("end_date"),formmatter), rs.getString("state"), 
							rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	// 카테고리별 목록 조회
	public ArrayList<ProductBoxDTO> getListByCategory(String category, String address){
		
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_CATEGORY)){
			pstmt.setString(1, category);
			pstmt.setString(2, "%"+address+"%");
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"), rs.getString("title"),
							rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), rs.getString("address"),
							LocalDateTime.parse(rs.getString("end_date"),formmatter), rs.getString("state"), 
							rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	
	// 지역별 목록 조회
	public ArrayList<ProductBoxDTO> getListByRegion(String region){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_REGION)){
			pstmt.setString(1, "%"+region+"%");	
			
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"), rs.getString("title"),
							rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), rs.getString("address"),
							LocalDateTime.parse(rs.getString("end_date"),formmatter), rs.getString("state"), 
							rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	
	
	// 입찰건순 목록 조회
	public ArrayList<ProductBoxDTO> getListByBidCount(String region){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
	
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_BIDCOUNT)){
			pstmt.setString(1, "%"+region+"%");	
			
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"), rs.getString("title"),
							rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), rs.getString("address"),
							LocalDateTime.parse(rs.getString("end_date"),formmatter), rs.getString("state"), 
							rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;	
	}
	
	// 마감 임박순 목록조회
	public ArrayList<ProductBoxDTO> getListByEndDate(String region){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_ENDDATE)){
			pstmt.setString(1, "%"+region+"%");	
			
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"), rs.getString("title"),
							rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), rs.getString("address"),
							LocalDateTime.parse(rs.getString("end_date"),formmatter), rs.getString("state"), 
							rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;	
	}
	
	// 검색 상품 목록 조회
	public ArrayList<ProductBoxDTO> getListBySearch(String searchKeyWord, String region){
		ArrayList<ProductBoxDTO> list = new ArrayList<>();	
		DateTimeFormatter formmatter = null;
		
		try(PreparedStatement pstmt = conn.prepareStatement(ProductQuery.GET_LIST_SEARCH)){
			pstmt.setString(1, "%"+searchKeyWord+"%");	
			pstmt.setString(2, "%"+searchKeyWord+"%");	
			pstmt.setString(3, "%"+region+"%");	
			
			try(ResultSet rs = pstmt.executeQuery()){
				formmatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				
				while(rs.next()){
					ProductBoxDTO dto = new ProductBoxDTO(rs.getString("product_img"), rs.getInt("product_seq"), rs.getString("title"),
							rs.getString("category"), rs.getInt("start_price"), rs.getInt("price"), rs.getString("address"),
							LocalDateTime.parse(rs.getString("end_date"),formmatter), rs.getString("state"), 
							rs.getInt("count(bid_price)-1"), rs.getInt("max(bid_price)"));
					list.add(dto);
				}
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		return list;
	}
	
}
