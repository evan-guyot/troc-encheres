package fr.eni.trocenchere.bll;

import java.util.List;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.dal.ArticleDAO;
import fr.eni.trocenchere.dal.DAOFactory;
import fr.eni.trocenchere.dal.RetraitDAO;

public class ArticleManager {
	private ArticleDAO daoArticle;
	private RetraitDAO daoRetrait;
	private static ArticleManager instance;

	private ArticleManager() {
		daoArticle =  DAOFactory.getArticleDAO();
		daoRetrait = DAOFactory.getRetraitDAO();
	}

	public static ArticleManager getInstance() {
		if (instance == null)
			instance = new ArticleManager();
		return instance;
	}
	
	public List<Article> getArticles(int categorieArticle, String caractereCompris, String getArticles, Integer id){
		try {
			return daoArticle.getArticles(categorieArticle, caractereCompris, getArticles, id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public Article getArticleById(int id){
		try {
			return daoArticle.getArticleById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;}

	public void insertArticle(Article article, int idUtilisateur, int idCategorie) {
		try {
			int noArticle = daoArticle.insertArticle(article, idUtilisateur, idCategorie);
			daoRetrait.insertRetrait(article.getRetrait(), noArticle);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	public void changeForeignKeyArtiCate(int id) {
		try {
			daoArticle.changeForeignKeyArtiCate(id);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	

}
