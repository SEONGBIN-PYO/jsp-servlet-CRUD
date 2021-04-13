package article.service;

import java.sql.Connection;
import java.sql.SQLException;

import article.dao.ArticleDao;
import article.model.Article;
import jdbc.connection.ConnectionProvider;

public class DeleteArticleService {
	
	private ArticleDao articleDao = new ArticleDao();
	
	public void delete(int articleNum) {
		try (Connection conn = ConnectionProvider.getConnection()){
			Article article = articleDao.selectById(conn, articleNum);
			if (article == null) {
				throw new ArticleNotFoundException();
			}
			articleDao.delete(conn, articleNum);
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
}
