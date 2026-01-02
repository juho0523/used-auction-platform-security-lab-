package query;

public interface NotiQuery {
	
	String ADD_NOTI = "insert into noti (noti_seq, user_id, bid_seq, noti_state) "
			+ "values(noti_seq.nextval, ?, (SELECT MAX(bid_seq) FROM bid WHERE product_seq = ?), 'f')";
	
	String GET_NOTI_LIST = "select noti_seq, b.bid_seq, p.product_seq, noti_state, b.user_id, u.nickname, product_img, b.bid_price, p.title, p.category, p.user_id "
			+ "from noti n, bid b, product p, users u, product_img i "
			+ "where n.bid_seq = b.bid_seq and b.user_id = u.user_id and b.product_seq = p.product_seq and p.product_seq = i.product_seq "
			+ "and n.user_id = ? and img_seq in (select min(img_seq) from product_img group by product_seq) "
			+ "order by noti_seq desc";
	
	String GET_NOTI_USERS = "SELECT DISTINCT user_id FROM bid WHERE product_seq = ? and "
			+ "user_id != (SELECT user_id FROM bid WHERE product_seq = ? "
			+ "and bid_price = (SELECT MAX(bid_price) FROM bid WHERE product_seq = ?))";
	
	String SET_NOTI_STATE = "UPDATE noti SET noti_state = 't' WHERE user_id = ?";
	
	String GET_NOTI_STATE = "SELECT noti_state FROM noti WHERE user_id = ? and "
			+ "noti_seq = (SELECT MAX(noti_seq) FROM noti WHERE user_id = ?)";
}
