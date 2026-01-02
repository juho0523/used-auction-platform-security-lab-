package dto;

import java.time.LocalDateTime;

public class ChatBoxDTO {
	private int chatSeq;
	private int productSeq;
	private String fromId;
	private String toId;
	private String content;
	private LocalDateTime chatDate;
	private String chatState;
	private String fromNickName;
	private String toNickName;
	private String productUserId;
	private String imgURL;
	private int unreadChatCount;
	

	public ChatBoxDTO(){}
	public ChatBoxDTO(int chatSeq, int productSeq, String fromId, String toId, String content, LocalDateTime chatDate,
			String chatState, String fromNickName, String toNickName, String productUserId, String imgURL) {
		super();
		this.chatSeq = chatSeq;
		this.productSeq = productSeq;
		this.fromId = fromId;
		this.toId = toId;
		this.content = content;
		this.chatDate = chatDate;
		this.chatState = chatState;
		this.fromNickName = fromNickName;
		this.toNickName = toNickName;
		this.productUserId = productUserId;
		this.imgURL = imgURL;
	}
	public ChatBoxDTO(int chatSeq, int productSeq, String fromId, String toId, String content, LocalDateTime chatDate,
			String chatState, String fromNickName, String toNickName, String productUserId, String imgURL,
			int unreadChatCount) {
		super();
		this.chatSeq = chatSeq;
		this.productSeq = productSeq;
		this.fromId = fromId;
		this.toId = toId;
		this.content = content;
		this.chatDate = chatDate;
		this.chatState = chatState;
		this.fromNickName = fromNickName;
		this.toNickName = toNickName;
		this.productUserId = productUserId;
		this.imgURL = imgURL;
		this.unreadChatCount = unreadChatCount;
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
	public String getFromNickName() {
		return fromNickName;
	}
	public void setFromNickName(String fromNickName) {
		this.fromNickName = fromNickName;
	}
	public String getToNickName() {
		return toNickName;
	}
	public void setToNickName(String toNickName) {
		this.toNickName = toNickName;
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
	public int getUnreadChatCount() {
		return unreadChatCount;
	}
	public void setUnreadChatCount(int unreadChatCount) {
		this.unreadChatCount = unreadChatCount;
	}
	
}
