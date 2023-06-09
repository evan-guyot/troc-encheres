package fr.eni.trocenchere.bll;

import java.util.List;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Categorie;
import fr.eni.trocenchere.dal.CategorieDAO;
import fr.eni.trocenchere.dal.DAOFactory;

public class CategorieManager {
	private CategorieDAO daoCategorie;
	private static CategorieManager instance;

	private CategorieManager() {
		daoCategorie =  DAOFactory.getCategorieDAO();
	}

	public static CategorieManager getInstance() {
		if (instance == null)
			instance = new CategorieManager();

		return instance;
	}
	
	public List<Categorie> getCategories(){
		try {
			return daoCategorie.getCategories();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	public Categorie getCategorieById(int id){
		try {
		return daoCategorie.getCategorieById(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
				
	}
	public void insertCategorie(String categorie){
		try {
		daoCategorie.insertCategorie(categorie);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void updateLibelleCateg(Categorie categorie){
		try {
		daoCategorie.updateLibelleCateg(categorie);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void deleteCategById(int id){
		try {
		daoCategorie.deleteCategById(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public List<Article> selectAllArticleByIdCateg(int id){
		try 
		{
			return daoCategorie.selectAllArticleByIdCateg(id);
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return null;
	}
}
