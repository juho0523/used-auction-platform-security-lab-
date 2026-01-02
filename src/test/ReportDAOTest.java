package test;

import static org.junit.Assert.*;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import dao.ReportDAO;


public class ReportDAOTest {

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
	
	@Test
	public void addReportTest() throws Exception{
		conn.setAutoCommit(false);
		assertTrue(new ReportDAO(conn).addReport("user001", 3, "부품 바꿔서 팔아요"));
		conn.rollback();
		conn.setAutoCommit(true);
	}
}