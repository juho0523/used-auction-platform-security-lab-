package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import query.UserQuery;
import vo.UserVO;

public class UserDAO {
	private Connection conn;

	public UserDAO(Connection conn){
		this.conn = conn;
	}

	public UserVO login(String id, String pw){
		UserVO vo = null;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.LOGIN);){
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()){
					vo = new UserVO(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4)
							, rs.getString(5), rs.getString(6), rs.getString(7), rs.getInt(8)
							, rs.getDouble(9), rs.getInt(10), rs.getString(11), rs.getString(12), rs.getInt(13));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}

	public boolean addUser(String id, String pw, String name, String nickname, String phoneNumber, String email, String address){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.ADD_USER);){
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.setString(3, name);
			pstmt.setString(4, nickname);
			pstmt.setString(5, phoneNumber);
			pstmt.setString(6, email);
			pstmt.setString(7, address);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean idCheck(String id){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.ID_CHECK);) {
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()){
					result = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean nickCheck(String nickname){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.NICK_CHECK);) {
			pstmt.setString(1, nickname);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()){
					result = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

/*	public boolean findId(String name, String email, String phoneNumber){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.FIND_ID);){
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, phoneNumber);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()){
					result = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}*/

	public String findId(String name, String email, String phoneNumber){
		String userId = null;
		String sql = UserQuery.FIND_ID;
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, phoneNumber);

			ResultSet rs = pstmt.executeQuery();
			if(rs.next()){
				userId = rs.getString(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return userId;
	}

	
	
	
	

	public boolean findPw(String id, String name, String email){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.FIND_PW);){
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()){
					result = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean setPw(String id, String pw){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.SET_PW);){
			pstmt.setString(1, pw);
			pstmt.setString(2, id);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean setRateCount(int productSeq){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.SET_RATE_COUNT);){
			pstmt.setInt(1, productSeq);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean setRate(int productSeq, double rate){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.SET_RATE);){
			pstmt.setDouble(1, rate);
			pstmt.setInt(2, productSeq);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean setProductState(int productSeq){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.SET_PRODUCT_STATE);){
			pstmt.setInt(1, productSeq);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}


	public UserVO getUser(String id){
		UserVO vo = null;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.GET_USER);){
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				if(rs.next()){
					vo = new UserVO();
					vo.setNickName(rs.getString(1));
					vo.setPoint(rs.getInt(2));
					vo.setProfileImg(rs.getString(3));
					vo.setRate(rs.getDouble(4));
					
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vo;
	}

	public boolean setPoint(String id, int point){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.SET_POINT);){
			pstmt.setInt(1, point);
			pstmt.setString(2, id);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean setUser(String id, String pw, String nickname, String phoneNumber, String email, String address){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.SET_USER);){
			pstmt.setString(1, pw);
			pstmt.setString(2, nickname);
			pstmt.setString(3, phoneNumber);
			pstmt.setString(4, email);
			pstmt.setString(5, address);
			pstmt.setString(6, id);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean setUserType(String id){
		boolean result = false;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.SET_USER_TYPE);){
			pstmt.setString(1, id);
			if(pstmt.executeUpdate() >= 1){
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	public ArrayList<UserVO> getUserList(){
		ArrayList<UserVO> userList = null;
		UserVO vo = null;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.GET_USER_LIST);){
			try(ResultSet rs = pstmt.executeQuery();){
				userList = new ArrayList<UserVO>();
				while(rs.next()){
					vo = new UserVO();
					vo.setUserId(rs.getString(1));
					vo.setPhoneNumber(rs.getString(2));
					vo.setReportCount(rs.getInt(3));
					vo.setRate(rs.getDouble(4));
					userList.add(vo);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userList;
	}

	public ArrayList<UserVO> getUserList(String id){
		ArrayList<UserVO> userList = null;
		UserVO vo = null;
		try(PreparedStatement pstmt = conn.prepareStatement(UserQuery.GET_USER_LIST_BY_ID);){
			pstmt.setString(1, id);
			try(ResultSet rs = pstmt.executeQuery();){
				userList = new ArrayList<UserVO>();
				while(rs.next()){
					vo = new UserVO();
					vo.setUserId(rs.getString(1));
					vo.setPhoneNumber(rs.getString(2));
					vo.setReportCount(rs.getInt(3));
					vo.setRate(rs.getDouble(4));
					userList.add(vo);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return userList;
	}
}