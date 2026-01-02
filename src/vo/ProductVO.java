package vo;

import java.time.LocalDateTime;

public class ProductVO {
	private int productSeq;
	private String userId;
	private String title;
	private String category;
	private String address;
	private LocalDateTime startDate;
	private LocalDateTime endDate;
	private int endDateNum;
	private int price;
	private int startPrice;
	private String content;
	private String state;
	
	
	public ProductVO(int productSeq, String userId, String title, String category, String address, LocalDateTime endDate,
			LocalDateTime startDate, int endDateNum, int price, int startPrice, String content, String state) {
		setAddress(address);
		setCategory(category);
		setContent(content);
		setEndDateNum(endDateNum);
		setPrice(price);
		setProductSeq(productSeq);
		setStartDate(startDate);
		setStartPrice(startPrice);
		setState(state);
		setTitle(title);
		setUserId(userId);
		setEndDate(endDate);
	}


	public int getProductSeq() {
		return productSeq;
	}


	public void setProductSeq(int productSeq) {
		this.productSeq = productSeq;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
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


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public LocalDateTime getStartDate() {
		return startDate;
	}


	public void setStartDate(LocalDateTime startDate) {
		this.startDate = startDate;
	}


	public LocalDateTime getEndDate() {
		return endDate;
	}


	public void setEndDate(LocalDateTime endDate) {
		this.endDate = endDate;
	}


	public int getEndDateNum() {
		return endDateNum;
	}


	public void setEndDateNum(int endDateNum) {
		this.endDateNum = endDateNum;
	}


	public int getPrice() {
		return price;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	public int getStartPrice() {
		return startPrice;
	}


	public void setStartPrice(int startPrice) {
		this.startPrice = startPrice;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((address == null) ? 0 : address.hashCode());
		result = prime * result + ((category == null) ? 0 : category.hashCode());
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((endDate == null) ? 0 : endDate.hashCode());
		result = prime * result + endDateNum;
		result = prime * result + price;
		result = prime * result + productSeq;
		result = prime * result + ((startDate == null) ? 0 : startDate.hashCode());
		result = prime * result + startPrice;
		result = prime * result + ((state == null) ? 0 : state.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
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
		ProductVO other = (ProductVO) obj;
		if (address == null) {
			if (other.address != null)
				return false;
		} else if (!address.equals(other.address))
			return false;
		if (category == null) {
			if (other.category != null)
				return false;
		} else if (!category.equals(other.category))
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (endDate == null) {
			if (other.endDate != null)
				return false;
		} else if (!endDate.equals(other.endDate))
			return false;
		if (endDateNum != other.endDateNum)
			return false;
		if (price != other.price)
			return false;
		if (productSeq != other.productSeq)
			return false;
		if (startDate == null) {
			if (other.startDate != null)
				return false;
		} else if (!startDate.equals(other.startDate))
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
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		return true;
	}


	@Override
	public String toString() {
		return "ProductVO [productSeq=" + productSeq + ", userId=" + userId + ", title=" + title + ", category="
				+ category + ", address=" + address + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", endDateNum=" + endDateNum + ", price=" + price + ", startPrice=" + startPrice + ", content="
				+ content + ", state=" + state + "]";
	}
	
	
			
}
