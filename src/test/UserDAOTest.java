package test;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import dao.UserDAO;
import vo.UserVO;

public class UserDAOTest {
	private static Connection conn;

	@BeforeClass
	public static void setUpBeforeClass() throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
		System.out.println("1 loading OK");
		String url = "jdbc:oracle:thin:@192.168.0.97:1521:XE";
		conn = DriverManager.getConnection(url, "hr1", "hr1");
		System.out.println("2 connection OK");
	}

	@AfterClass
	public static void tearDownAfterClass() throws Exception {
		conn.close();
	}

	//@Test
	public void loginTest() {
		assertNull(new UserDAO(conn).login("user001", "user0001")); //로그인 실패
		assertEquals(new UserDAO(conn).login("user001", "user001").getNickName(), "유저001"); //로그인 성공
	}

	//@Test
	public void addUserTest() throws Exception {
		conn.setAutoCommit(false);
		assertTrue(new UserDAO(conn).addUser("user005", "1234", "최민우", "cmw", "010-4845-3293", "certes1@nate.com", "서울특별시 금천구"));
		assertFalse(new UserDAO(conn).addUser("user001", "1234", "최민우", "cmw", "010-4845-3293", "certes1@nate.com", "서울특별시 금천구"));
		conn.rollback();
		conn.setAutoCommit(true);
	}

	//@Test
	public void idCheckTest(){
		assertFalse(new UserDAO(conn).idCheck("user005")); //아이디 중복이 아닐 때
		assertTrue(new UserDAO(conn).idCheck("user001")); //아이디가 중복일 때
	}

	//@Test
	public void nickCheckTest(){
		assertFalse(new UserDAO(conn).nickCheck("유저005")); //닉네임 중복이 아닐 때
		assertTrue(new UserDAO(conn).nickCheck("유저001")); //닉네임이 중복일 때
	}

	//@Test
	public void findIdTest(){
		assertNotNull(new UserDAO(conn).findId("유저001", "user001@nate.com", "010-1111-2222"));
		assertNotNull(new UserDAO(conn).findId("유저005", "user001@nate.com", "010-1111-2222"));
	}

	//@Test
	public void findPwTest(){
		assertTrue(new UserDAO(conn).findPw("user001", "유저001", "user001@nate.com"));
		assertFalse(new UserDAO(conn).findPw("user005", "유저005", "user005@nate.com"));
	}
	
	//@Test
	public void setPwTest() throws Exception {
		conn.setAutoCommit(false);
		assertTrue(new UserDAO(conn).setPw("user001", "user0001"));
		assertFalse(new UserDAO(conn).setPw("user005", "user0005"));
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	//@Test
	public void setRateTest() throws Exception{
		conn.setAutoCommit(false);
		assertTrue(new UserDAO(conn).setRateCount(3));
		assertTrue(new UserDAO(conn).setRate(3, 5));
		assertTrue(new UserDAO(conn).setProductState(3));
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	//@Test
	public void getUserTest(){
		assertNotNull(new UserDAO(conn).getUser("user001"));
	}
	
	//@Test
	public void setPointTest() throws Exception{
		conn.setAutoCommit(false);
		assertTrue(new UserDAO(conn).setPoint("user001", 100));
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	//@Test
	public void setUserTest() throws Exception{
		conn.setAutoCommit(false);
		assertTrue(new UserDAO(conn).setUser("user001", "user0001", "유저0001", "010-3333-4444", "user0001@nate.com", "서울특별시 강서구"));
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	//@Test
	public void setUserTypeTest() throws Exception{
		conn.setAutoCommit(false);
		assertTrue(new UserDAO(conn).setUserType("user001"));
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	//@Test
	public void getUserListTest(){
		ArrayList<UserVO> userList = new UserDAO(conn).getUserList();
		for(int i=0; i<userList.size(); i++){
			System.out.println(userList.get(i));
		}
	}
	
	//@Test
	public void getUserListByIDTest(){
		ArrayList<UserVO> userList = new UserDAO(conn).getUserList("user");
		for(int i=0; i<userList.size(); i++){
			System.out.println(userList.get(i));
		}
	}
}