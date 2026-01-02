package controller;

public class URLModel {
	private String page;
	private boolean flag;
	
	public URLModel(String page){
		this(page, false);
	}
	public URLModel(String page, boolean flag) {
		this.page = page;
		this.flag = flag;
	}
	
	public String getPage() {
		return page;
	}
	public void setPage(String page) {
		this.page = page;
	}
	public boolean isFlag() {
		return flag;
	}
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	
	@Override
	public String toString() {
		return "URLModel [page=" + page + ", flag=" + flag + "]";
	}
	
}
