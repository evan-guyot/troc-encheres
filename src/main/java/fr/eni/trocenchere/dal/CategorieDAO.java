package fr.eni.trocenchere.dal;

import java.util.List;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Categorie;

public interface CategorieDAO {
	public List<Categorie> getCategories() throws Exception ;
	public Categorie getCategorieById(int id) throws Exception;
	public void insertCategorie(String categorie) throws Exception;
	public List<Article> selectAllArticleByIdCateg(int id) throws Exception;
	public void deleteCategById(int id) throws Exception;
	public void updateLibelleCateg(Categorie categorie) throws Exception ;
}
