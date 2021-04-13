package member.service;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import auth.security.TemporaryPassword;
import auth.security.Utility;
import jdbc.JdbcUtil;
import jdbc.connection.ConnectionProvider;
import member.dao.MemberDao;
import member.model.Member;

public class SearchPasswordService {
	private MemberDao memberDao = new MemberDao();
	
	public void issuedTemporaryPassword(String userId, String userName, HttpServletRequest req) {
		Connection conn = null;
		String tempPassword = TemporaryPassword.getRamdomPassword();
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			
			Member member = memberDao.selectById(conn, userId);
			if (member == null) {
				throw new MemberNotFoundException();
			}
			if (!member.matchName(userName)) {
				throw new InvaildNameException();
			}
			
			member.changePassword(Utility.encoding(tempPassword));
			memberDao.update(conn, member);
			conn.commit();
		} catch (SQLException e) {
			JdbcUtil.rollback(conn);
			throw new RuntimeException(e);
		} finally {
			req.setAttribute("tempPassword", tempPassword);
			JdbcUtil.close(conn);
		}
	}
}
