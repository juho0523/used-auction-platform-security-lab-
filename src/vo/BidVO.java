package vo;

public class BidVO {
	private int bidSeq;
	private int productSeq;
	private String userId;
	private int bidPrice;
	
	public BidVO(String userId, int bidPrice) {
		setUserId(userId);
		setBidPrice(bidPrice);
	}
	
	public BidVO() {
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getBidPrice() {
		return bidPrice;
	}
	public void setBidPrice(int bidPrice) {
		this.bidPrice = bidPrice;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + bidPrice;
		result = prime * result + bidSeq;
		result = prime * result + productSeq;
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
		BidVO other = (BidVO) obj;
		if (bidPrice != other.bidPrice)
			return false;
		if (bidSeq != other.bidSeq)
			return false;
		if (productSeq != other.productSeq)
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
		return "BidVO [bidSeq=" + bidSeq + ", productSeq=" + productSeq + ", userId=" + userId + ", bidPrice="
				+ bidPrice + "]";
	}
}
