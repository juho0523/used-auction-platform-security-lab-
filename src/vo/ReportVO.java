package vo;

public class ReportVO {
	private int reportSeq;
	private String id;
	private int productSeq;
	private String report_content;
	
	public ReportVO() {	}
	
	public ReportVO(int reportSeq, String id, int productSeq, String report_content) {
		setReportSeq(reportSeq);
		setId(id);
		setProductSeq(productSeq);
		setReport_content(report_content);
	}
	
	public int getReportSeq() {
		return reportSeq;
	}
	public void setReportSeq(int reportSeq) {
		this.reportSeq = reportSeq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getProductSeq() {
		return productSeq;
	}
	public void setProductSeq(int productSeq) {
		this.productSeq = productSeq;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + productSeq;
		result = prime * result + reportSeq;
		result = prime * result + ((report_content == null) ? 0 : report_content.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ReportVO other = (ReportVO) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (productSeq != other.productSeq)
			return false;
		if (reportSeq != other.reportSeq)
			return false;
		if (report_content == null) {
			if (other.report_content != null)
				return false;
		} else if (!report_content.equals(other.report_content))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReportVO [reportSeq=" + reportSeq + ", id=" + id + ", productSeq=" + productSeq + ", report_content="
				+ report_content + "]";
	}
	
	
}
