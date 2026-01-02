package vo;

public class UserVO {
	private String userId;
	private String password;
	private String name;
	private String nickName;
	private String phoneNumber;
	private String email;
	private String address;
	private int point;
	private double rate;
	private int rateCount;
	private String profileImg;
	private String userType;
	private int reportCount;
	
	public UserVO() {}
	
	public UserVO(String nickName, String UserType){
		this(null, null, null, nickName, null, null, null, 0, 0, 0, null, UserType, 0);
	}

	public UserVO(String userId, String password, String name, String nickName, String phoneNumber, String email,
			String address, int point, double rate, int rateCount, String profileImg, String userType,
			int reportCount) {
		super();
		this.userId = userId;
		this.password = password;
		this.name = name;
		this.nickName = nickName;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.address = address;
		this.point = point;
		this.rate = rate;
		this.rateCount = rateCount;
		this.profileImg = profileImg;
		this.userType = userType;
		this.reportCount = reportCount;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public double getRate() {
		return rate;
	}

	public void setRate(double rate) {
		this.rate = rate;
	}

	public int getRateCount() {
		return rateCount;
	}

	public void setRateCount(int rateCount) {
		this.rateCount = rateCount;
	}

	public String getProfileImg() {
		return profileImg;
	}

	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public int getReportCount() {
		return reportCount;
	}

	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((address == null) ? 0 : address.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((nickName == null) ? 0 : nickName.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		result = prime * result + ((phoneNumber == null) ? 0 : phoneNumber.hashCode());
		result = prime * result + point;
		result = prime * result + ((profileImg == null) ? 0 : profileImg.hashCode());
		long temp;
		temp = Double.doubleToLongBits(rate);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + rateCount;
		result = prime * result + reportCount;
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
		result = prime * result + ((userType == null) ? 0 : userType.hashCode());
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
		UserVO other = (UserVO) obj;
		if (address == null) {
			if (other.address != null)
				return false;
		} else if (!address.equals(other.address))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (nickName == null) {
			if (other.nickName != null)
				return false;
		} else if (!nickName.equals(other.nickName))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (phoneNumber == null) {
			if (other.phoneNumber != null)
				return false;
		} else if (!phoneNumber.equals(other.phoneNumber))
			return false;
		if (point != other.point)
			return false;
		if (profileImg == null) {
			if (other.profileImg != null)
				return false;
		} else if (!profileImg.equals(other.profileImg))
			return false;
		if (Double.doubleToLongBits(rate) != Double.doubleToLongBits(other.rate))
			return false;
		if (rateCount != other.rateCount)
			return false;
		if (reportCount != other.reportCount)
			return false;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		if (userType == null) {
			if (other.userType != null)
				return false;
		} else if (!userType.equals(other.userType))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "UserVO [userId=" + userId + ", password=" + password + ", name=" + name + ", nickName=" + nickName
				+ ", phoneNumber=" + phoneNumber + ", email=" + email + ", address=" + address + ", point=" + point
				+ ", rate=" + rate + ", rateCount=" + rateCount + ", profileImg=" + profileImg + ", userType="
				+ userType + ", reportCount=" + reportCount + "]";
	}

}
