package fr.eni.trocenchere.dal;

import fr.eni.trocenchere.dal.jdbc.ArticleDaoJdbcImpl;
import fr.eni.trocenchere.dal.jdbc.CategorieDaoJdbcImpl;
import fr.eni.trocenchere.dal.jdbc.UtilisateurDaoJdbcImpl;

public class DAOFactory {
	public static UtilisateurDAO getUtilisateurDAO() {
		UtilisateurDAO utilisateurDAO = (UtilisateurDAO) new UtilisateurDaoJdbcImpl();
		return utilisateurDAO;
	}
	public static ArticleDAO getArticleDAO() {
		ArticleDAO articleDAO = (ArticleDAO) new ArticleDaoJdbcImpl();
		return articleDAO;
	}
	public static CategorieDAO getCategorieDAO() {
		CategorieDAO categorieDAO = (CategorieDAO) new CategorieDaoJdbcImpl();
		return categorieDAO;
	}
}
