package fr.eni.trocenchere.bll;

import java.util.ArrayList;
import java.util.List;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.dal.ArticleDAO;
import fr.eni.trocenchere.dal.DAOFactory;

public class ArticleManager {
	private ArticleDAO daoArticle;
	private static ArticleManager instance;

	private ArticleManager() {
		daoArticle =  DAOFactory.getArticleDAO();
	}

	public static ArticleManager getInstance() {
		if (instance == null)
			instance = new ArticleManager();

		return instance;
	}
	
	public List<Article> getArticles(){
		try {
			return daoArticle.getArticles();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
		
	}
}
