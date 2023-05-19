package fr.eni.trocenchere.dal;

import java.util.ArrayList;
import java.util.List;

import fr.eni.trocenchere.bo.Article;

public interface ArticleDAO {
	public List<Article> getArticles(int idCategorie , String caractereCompris) throws Exception;
	public Article getArticleById(int id) throws Exception;	
}
