package test;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import dao.BidDAO;
import dao.UserDAO;


public class BidDAOTest {

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
	public void getMaxBidTest(){
		assertNotNull(new BidDAO(conn).getMaxBid(2));
		System.out.println(new BidDAO(conn).getMaxBid(2));
	}
	
	//@Test
	public void getBidCountTest(){
		assertNotNull(new BidDAO(conn).getBidCount(2));
		System.out.println(new BidDAO(conn).getBidCount(2));
	}
	
	//@Test
	public void pointDeductionTest() throws Exception{
		conn.setAutoCommit(false);
		assertTrue(new BidDAO(conn).pointDeduction(2, "user001", 8000));
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	//@Test
	public void addBidTest() throws Exception{
		conn.setAutoCommit(false);
		assertTrue(new BidDAO(conn).addBid(2, "user001", 8000));
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	//@Test
	public void setProductStateTest() throws Exception{
		conn.setAutoCommit(false);
		assertTrue(new BidDAO(conn).setProductState(2));
		conn.rollback();
		conn.setAutoCommit(true);
	}
	
	@Test
	public void getBidList() throws Exception{
		conn.setAutoCommit(false);
		assertNotNull(new BidDAO(conn).getBidList(67));
		conn.rollback();
		conn.setAutoCommit(true);
	}
}