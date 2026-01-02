package query;

public interface ReportQuery {

	String ADD_REPORT = "insert into report values(report_seq.nextval, ?, ?, ?)";

}
