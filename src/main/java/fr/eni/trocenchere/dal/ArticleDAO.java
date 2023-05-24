package fr.eni.trocenchere.dal;

import java.util.List;

import fr.eni.trocenchere.bo.Article;

public interface ArticleDAO {
	public List<Article> getArticles(int idCategorie, String caractereCompris, String radioFilterParameter, Integer id)
			throws Exception;

	public Article getArticleById(int id) throws Exception;

	public int insertArticle(Article article, int idUtilisateur, int idCategorie) throws Exception;

	public void updateArticle(Article article, int idCategorie) throws Exception;
}
