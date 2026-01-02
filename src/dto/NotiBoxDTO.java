package dto;

public class NotiBoxDTO {
	private String imgURL;
	private String title;
	private String nickname;
	private String category;
	private String productUserId;
	private int price;
	private int bidSeq;
	private int productSeq;
	
	public NotiBoxDTO(String imgURL, String title, String nickname, String category, int price, int bidSeq,
			int productSeq, String productUserId) {
		setBidSeq(bidSeq);
		setCategory(category);
		setImgURL(imgURL);
		setNickname(nickname);
		setPrice(price);
		setProductSeq(productSeq);
		setTitle(title);
		setProductUserId(productUserId);
	}	
	
	public String getProductUserId() {
		return productUserId;
	}
	public void setProductUserId(String productUserId) {
		this.productUserId = productUserId;
	}
	public String getImgURL() {
		return imgURL;
	}
	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getBidSeq() {
		return bidSeq;
	}
	public void setBidSeq(int bidSeq) {
		this.bidSeq = bidSeq;
	}
	public int getProductSeq() {
		return productSeq;
	}
	public void setProductSeq(int productSeq) {
		this.productSeq = productSeq;
	}

	@Override
	public String toString() {
		return "NotiBoxDTO [imgURL=" + imgURL + ", title=" + title + ", nickname=" + nickname + ", category=" + category
				+ ", productUserId=" + productUserId + ", price=" + price + ", bidSeq=" + bidSeq + ", productSeq="
				+ productSeq + "]";
	}
}
