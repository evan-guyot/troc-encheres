package fr.eni.trocenchere.bll;

import java.util.List;

import fr.eni.trocenchere.bo.Enchere;
import fr.eni.trocenchere.dal.DAOFactory;
import fr.eni.trocenchere.dal.EnchereDAO;

public class EnchereManager {
	private EnchereDAO daoEnchere;
	private static EnchereManager instance;

	private EnchereManager() {
		daoEnchere =  DAOFactory.getEnchereDAO();
	}

	public static EnchereManager getInstance() {
		if (instance == null)
			instance = new EnchereManager();

		return instance;
	}
	
	public void InsertEnchere(Enchere enchere, int noArticle){
		try {
			daoEnchere.insertEnchere(enchere, noArticle);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}


