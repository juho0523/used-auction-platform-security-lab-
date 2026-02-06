package dto;

import java.time.LocalDateTime;

public class ProductBoxDTO {
	private int imgSeq;
	private String imgURL;
	private int productSeq;
	private String id;
	private String nickName;
	private String title;
	private String category;
	private int startPrice;
	private int price;
	private String address;
	private LocalDateTime endDate;
	private String state;
	private int bidCount;
	private int bidMax;	
	private String content;
	
	public ProductBoxDTO(String imgURL, int productSeq, String title, String category, int startPrice, int price,
			String address, LocalDateTime endDate, String state, int bidCount, int bidMax) {
		setAddress(address);
		setBidCount(bidCount);
		setCategory(category);
		setEndDate(endDate);
		setImgURL(imgURL);
		setPrice(price);
		setProductSeq(productSeq);
		setStartPrice(startPrice);
		setState(state);
		setTitle(title);
		setBidMax(bidMax);
	}

	
	public ProductBoxDTO(int imgSeq, int productSeq, String nickName, String title, String category, int startPrice, int price,
			String address, LocalDateTime endDate, String state, int bidCount, int bidMax) {
		setAddress(address);
		setBidCount(bidCount);
		setCategory(category);
		setEndDate(endDate);
		setImgSeq(imgSeq);
		setPrice(price);
		setProductSeq(productSeq);
		setStartPrice(startPrice);
		setState(state);
		setTitle(title);
		setBidMax(bidMax);
		setNickName(nickName);
	}
	
	public ProductBoxDTO(int imgSeq, int productSeq, String nickName, String title, String category, int startPrice, int price,
			String address, LocalDateTime endDate, String state, int bidCount, int bidMax, String content) {
		setAddress(address);
		setBidCount(bidCount);
		setCategory(category);
		setEndDate(endDate);
		setImgSeq(imgSeq);
		setPrice(price);
		setProductSeq(productSeq);
		setStartPrice(startPrice);
		setState(state);
		setTitle(title);
		setBidMax(bidMax);
		setNickName(nickName);
		setContent(content);
	}
	
	public ProductBoxDTO(int imgSeq, int productSeq, String nickName, String title, String category, int startPrice, int price,
			String address, LocalDateTime endDate, String state, int bidCount, int bidMax, String content, String id) {
		setAddress(address);
		setBidCount(bidCount);
		setCategory(category);
		setEndDate(endDate);
		setImgSeq(imgSeq);
		setPrice(price);
		setProductSeq(productSeq);
		setStartPrice(startPrice);
		setState(state);
		setTitle(title);
		setBidMax(bidMax);
		setNickName(nickName);
		setContent(content);
		setId(id);
	}
	
	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getImgURL() {
		return imgURL;
	}

	public void setImgURL(String imgURL) {
		this.imgURL = imgURL;
	}

	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}

	public int getBidMax() {
		return bidMax;
	}

	public void setBidMax(int bidMax) {
		this.bidMax = bidMax;
	}

	public int getImgSeq() {
		return imgSeq;
	}
	public void setImgSeq(int imgSeq) {
		this.imgSeq = imgSeq;
	}
	public int getProductSeq() {
		return productSeq;
	}
	public void setProductSeq(int productSeq) {
		this.productSeq = productSeq;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getStartPrice() {
		return startPrice;
	}
	public void setStartPrice(int startPrice) {
		this.startPrice = startPrice;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public LocalDateTime getEndDate() {
		return endDate;
	}
	public void setEndDate(LocalDateTime endDate) {
		this.endDate = endDate;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public int getBidCount() {
		return bidCount;
	}
	public void setBidCount(int bidCount) {
		this.bidCount = bidCount;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((address == null) ? 0 : address.hashCode());
		result = prime * result + bidCount;
		result = prime * result + bidMax;
		result = prime * result + ((category == null) ? 0 : category.hashCode());
		result = prime * result + ((endDate == null) ? 0 : endDate.hashCode());
		result = prime * result + imgSeq;
		result = prime * result + price;
		result = prime * result + productSeq;
		result = prime * result + startPrice;
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
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
		ProductBoxDTO other = (ProductBoxDTO) obj;
		if (address == null) {
			if (other.address != null)
				return false;
		} else if (!address.equals(other.address))
			return false;
		if (bidCount != other.bidCount)
			return false;
		if (bidMax != other.bidMax)
			return false;
		if (category == null) {
			if (other.category != null)
				return false;
		} else if (!category.equals(other.category))
			return false;
		if (endDate == null) {
			if (other.endDate != null)
				return false;
		} else if (!endDate.equals(other.endDate))
			return false;
		if (imgSeq != other.imgSeq)
			return false;
		if (price != other.price)
			return false;
		if (productSeq != other.productSeq)
			return false;
		if (startPrice != other.startPrice)
			return false;
		if (state == null) {
			if (other.state != null)
				return false;
		} else if (!state.equals(other.state))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ProductBoxDTO [imgSeq=" + imgSeq + ", imgURL=" + imgURL + ", productSeq=" + productSeq + ", id=" + id
				+ ", nickName=" + nickName + ", title=" + title + ", category=" + category + ", startPrice="
				+ startPrice + ", price=" + price + ", address=" + address + ", endDate=" + endDate + ", state=" + state
				+ ", bidCount=" + bidCount + ", bidMax=" + bidMax + ", content=" + content + "]";
	}

}
