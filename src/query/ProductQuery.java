package query;

public interface ProductQuery {
	String ADD_PRODUCT = "insert into product "
			+ "(product_seq, user_id, title, category, address, end_date, price, start_price, content, state, start_date) "
			+ "values(product_seq.nextval, ?, ?, ?, ?, sysdate + ?, ?, ?, ?, 'S', sysdate)";
	
	String GET_PRODUCT = "select user_id, title, category, address, end_date, price, start_price, content, state, start_date "
			+ "from product where product_seq = ?";

	String GET_PRODUCTBOX = "select img_seq, p.product_seq, nickname, title, category, start_price, price, p.address, end_date, state, count(bid_price)-1, max(bid_price), content, p.user_id "
			+ "from product p, product_img i, bid b, users u "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) and p.product_seq = ? and "
			+ "u.user_id = p.user_id "
			+ "group by img_seq, p.product_seq, nickname, title, category, start_price, price, p.address, end_date, state, start_date, content, p.user_id";

	String GET_PRODUCTBOX_CHAT = "select product_img, p.product_seq, nickname, title, category, start_price, price, p.address, end_date, state, count(bid_price)-1, max(bid_price), content, p.user_id "
			+ "from product p, product_img i, bid b, users u "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) and p.product_seq = ? and "
			+ "u.user_id = p.user_id "
			+ "group by product_img, p.product_seq, nickname, title, category, start_price, price, p.address, end_date, state, start_date, content, p.user_id";
	
	String GET_IMAGE = "select product_img from product_img where product_seq = ?";

	String ADD_PRODUCT_IMG = "insert into product_img values(img_seq.nextval, ?, ?)";

	
	String GET_LIST = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
			+ "from product p, product_img i, bid b "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) and state='S' and address like ?"
			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, state, start_date "
			+ "order by start_date desc";

	String GET_LIST_CATEGORY = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
			+ "from product p, product_img i, bid b "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) and state='S' and category= ? and address like ? "
			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, state, start_date "
			+ "order by start_date desc";

	String GET_LIST_REGION = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
			+ "from product p, product_img i, bid b "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) and state='S' and address like ? "
			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, start_date, state "
			+ "order by start_date desc";

	String GET_LIST_BIDCOUNT = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
			+ "from product p, product_img i, bid b "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) and state='S' and address like ? "
			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, start_date, state "
			+ "order by count(bid_price) desc, start_date desc";

	String GET_LIST_ENDDATE = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
			+ "from product p, product_img i, bid b "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) and state='S' and address like ? "
			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, state, start_date "
			+ "order by end_date";

	String GET_LIST_SEARCH = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
			+ "from product p, product_img i, bid b "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) and state='S' and (title like ? or content like ?) and address like ? "
			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, state, start_date "
			+ "order by start_date desc";
	
	String GET_LIST_SELLING_HISTORY = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
			+ "from product p, product_img i, bid b "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) "
			+ "and (state = 'S' or state = 'T') and p.user_id = ? "
			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, state, start_date "
			+ "order by start_date desc";

	String GET_LIST_SELL_COMPLETE_HISTORY = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
			+ "from product p, product_img i, bid b "
			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
			+ "img_seq in (select min(img_seq) from product_img group by product_seq) "
			+ "and state = 'E' and p.user_id = ? "
			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, state, start_date "
			+ "order by start_date desc";

//	String GET_LIST_BUYING_HISTORY = "select product_img, p.product_seq, title, category, start_price, price, address, end_date, state, count(bid_price)-1, MAX(bid_price) "
//			+ "from product p, product_img i, bid b "
//			+ "where b.product_seq = p.product_seq and p.product_seq = i.product_seq and "
//			+ "img_seq in (select min(img_seq) from product_img group by product_seq) "
//			+ "and (state = 'T' or state = 'E') "
//			+ "and b.product_seq in ("
//			+ "SELECT b1.product_seq "
//			+ "FROM BID b1 "
//			+ "JOIN ("
//			+ "SELECT product_seq, MAX(bid_seq) AS max_bid_seq "
//			+ "FROM BID "
//			+ "GROUP BY product_seq) b2 "
//			+ "ON b1.product_seq = b2.product_seq AND b1.bid_seq = b2.max_bid_seq "
//			+ "WHERE b1.user_id = ?) "
//			+ "group by product_img, p.product_seq, title, category, start_price, price, address, end_date, state, start_date "
//			+ "order by start_date desc";
	
	String GET_LIST_BUYING_HISTORY = "SELECT i.PRODUCT_IMG, p.PRODUCT_SEQ, p.TITLE, p.CATEGORY, p.START_PRICE, p.PRICE, p.ADDRESS, p.END_DATE, p.STATE, COUNT(b.BID_PRICE) - 1 AS BID_COUNT, MAX(b.BID_PRICE) AS MAX_BID_PRICE, p.USER_ID "
			+ "FROM PRODUCT p "
			+ "JOIN PRODUCT_IMG i ON p.PRODUCT_SEQ = i.PRODUCT_SEQ "
			+ "JOIN BID b ON p.PRODUCT_SEQ = b.PRODUCT_SEQ "
			+ "WHERE i.IMG_SEQ IN ("
			+ "SELECT MIN(IMG_SEQ) "
			+ "FROM PRODUCT_IMG "
			+ "GROUP BY PRODUCT_SEQ"
			+ ") "
			+ "AND p.STATE = 'S' "
			+ "AND b.PRODUCT_SEQ IN ("
			+ "SELECT DISTINCT b1.PRODUCT_SEQ FROM BID b1 "
			+ "WHERE b1.USER_ID = ?"
			+ ") "
			+ "GROUP BY i.PRODUCT_IMG, p.PRODUCT_SEQ, p.TITLE, p.CATEGORY, p.START_PRICE, p.PRICE, p.ADDRESS, p.END_DATE, p.STATE, p.USER_ID, p.START_DATE "
			+ "ORDER BY p.PRODUCT_SEQ desc";

	String GET_LIST_BUY_COMPLETE_HISTORY = "SELECT i.PRODUCT_IMG, p.PRODUCT_SEQ, p.TITLE, p.CATEGORY, p.START_PRICE, p.PRICE, p.ADDRESS, p.END_DATE, p.STATE, COUNT(b.BID_PRICE) - 1 AS BID_COUNT, MAX(b.BID_PRICE) AS MAX_BID_PRICE, p.USER_ID "
			+ "FROM PRODUCT p "
			+ "JOIN PRODUCT_IMG i ON p.PRODUCT_SEQ = i.PRODUCT_SEQ "
			+ "JOIN BID b ON p.PRODUCT_SEQ = b.PRODUCT_SEQ "
			+ "WHERE i.IMG_SEQ IN (SELECT MIN(IMG_SEQ) "
			+ "FROM PRODUCT_IMG GROUP BY PRODUCT_SEQ) "
			+ "AND (p.STATE = 'T' OR p.STATE = 'E') "
			+ "AND b.PRODUCT_SEQ IN (SELECT b1.PRODUCT_SEQ FROM BID b1 "
			+ "JOIN (SELECT PRODUCT_SEQ, MAX(BID_SEQ) AS MAX_BID_SEQ FROM BID "
			+ "GROUP BY PRODUCT_SEQ) b2 ON b1.PRODUCT_SEQ = b2.PRODUCT_SEQ AND b1.BID_SEQ = b2.MAX_BID_SEQ "
			+ "WHERE b1.USER_ID = ?) "
			+ "GROUP BY i.PRODUCT_IMG, p.PRODUCT_SEQ, p.TITLE, p.CATEGORY, p.START_PRICE, p.PRICE, p.ADDRESS, p.END_DATE, p.STATE, p.USER_ID, p.START_DATE "
			+ "ORDER BY p.START_DATE DESC";
	
}



