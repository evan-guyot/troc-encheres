package fr.eni.trocenchere.dal;

import java.util.ArrayList;

import fr.eni.trocenchere.bo.Article;

public interface ArticleDAO {
	public ArrayList<Article> getArticles() throws Exception;
}
