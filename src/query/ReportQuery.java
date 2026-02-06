package query;

public interface ReportQuery {
	String ADD_REPORT = "insert into report values(report_seq.nextval, ?, ?, ?)";
	String SET_REPORTCOUNT = "update users set report_count = report_count + 1 "
			+ "where user_id = (SELECT user_id FROM product WHERE product_seq = ?)";
}