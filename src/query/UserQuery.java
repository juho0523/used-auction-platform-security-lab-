package query;

public interface UserQuery {
	String LOGIN = "select user_id, password, name, nickname, phone_number, email, address, point, rate, rate_count, profile_img, user_type, report_count from users where user_id = ? and password = ?";
	String ADD_USER = "insert into users "
			+ "(user_id, password, name, nickname, phone_number, email, address, point, profile_img, "
			+ "rate, rate_count, user_type, report_count) "
			+ "values"
			+ "(?, ?, ?, ?, ?, ?, ?, 0,'img.png', "
			+ "5, 1, 'U', 0)";
	String ID_CHECK = "select user_id from users where user_id = ?";
	String NICK_CHECK = "select nickname from users where nickname = ?";
	String FIND_ID = "select user_id from users "
			+ "where name = ? and email = ? and phone_number = ?";
	String FIND_PW = "select password from users "
			+ "where user_id = ? and name = ? and email = ?";
	String SET_PW = "update users set password = ? where user_id = ?";
	String SET_RATE_COUNT = "update users set rate_count = rate_count + 1 "
			+ "where user_id = (SELECT user_id FROM product WHERE product_seq = ?)";
	String SET_RATE = "update users set rate = ((rate*rate_count) + ?)/(rate_count + 1) "
			+ "where user_id = (SELECT user_id FROM product WHERE product_seq = ?)";
	String SET_PRODUCT_STATE = "update product set state = 'E' where product_seq = ?";
	String GET_USER = "select nickname, point, profile_img, rate from users where user_id = ?";
	String SET_POINT = "update users set point = point + ? where user_id = ?";
	String SET_USER = "update users set password = ?, nickname = ?, "
			+ "phone_number = ?, email = ?, "
			+ "address = ? where user_id = ?";
	String SET_USER_TYPE = "update users set user_type = 'D' where user_id = ?";
	String GET_USER_LIST = "select user_id, phone_number, report_count, rate "
			+ "from users where user_type = 'U'";
	String GET_USER_LIST_BY_ID = "select user_id, phone_number, report_count, rate "
			+ "from users where user_type = 'U' and user_id like '%'||?||'%'";
}