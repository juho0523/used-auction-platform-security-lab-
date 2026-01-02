package vo;

import java.time.LocalDateTime;

public class ChatVO {
	private int chatSeq;
	private int productSeq;
	private String fromId;
	private String toId;
	private String content;
	private LocalDateTime chatDate;
	private String chatState;
	
	public ChatVO(){}
	public ChatVO(int chatSeq, int productSeq, String fromId, String toId, String content, LocalDateTime chatDate, String chatState) {
		super();
		this.chatSeq = chatSeq;
		this.productSeq = productSeq;
		this.fromId = fromId;
		this.toId = toId;
		this.content = content;
		this.chatDate = chatDate;
		this.chatState = chatState;
	}

	public int getChatSeq() {
		return chatSeq;
	}
	public void setChatSeq(int chatSeq) {
		this.chatSeq = chatSeq;
	}
	public int getProductSeq() {
		return productSeq;
	}
	public void setProductSeq(int productSeq) {
		this.productSeq = productSeq;
	}
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public LocalDateTime getChatDate() {
		return chatDate;
	}
	public void setChatDate(LocalDateTime chatDate) {
		this.chatDate = chatDate;
	}
	public String getChatState() {
		return chatState;
	}
	public void setChatState(String chatState) {
		this.chatState = chatState;
	}
	
	@Override
	public String toString() {
		return "ChatVO [chatSeq=" + chatSeq + ", productSeq=" + productSeq + ", fromId=" + fromId + ", toId=" + toId
				+ ", content=" + content + ", chatDate=" + chatDate + ", chatState=" + chatState + "]";
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((chatDate == null) ? 0 : chatDate.hashCode());
		result = prime * result + chatSeq;
		result = prime * result + ((chatState == null) ? 0 : chatState.hashCode());
		result = prime * result + ((content == null) ? 0 : content.hashCode());
		result = prime * result + ((fromId == null) ? 0 : fromId.hashCode());
		result = prime * result + productSeq;
		result = prime * result + ((toId == null) ? 0 : toId.hashCode());
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
		ChatVO other = (ChatVO) obj;
		if (chatDate == null) {
			if (other.chatDate != null)
				return false;
		} else if (!chatDate.equals(other.chatDate))
			return false;
		if (chatSeq != other.chatSeq)
			return false;
		if (chatState == null) {
			if (other.chatState != null)
				return false;
		} else if (!chatState.equals(other.chatState))
			return false;
		if (content == null) {
			if (other.content != null)
				return false;
		} else if (!content.equals(other.content))
			return false;
		if (fromId == null) {
			if (other.fromId != null)
				return false;
		} else if (!fromId.equals(other.fromId))
			return false;
		if (productSeq != other.productSeq)
			return false;
		if (toId == null) {
			if (other.toId != null)
				return false;
		} else if (!toId.equals(other.toId))
			return false;
		return true;
	}

}
