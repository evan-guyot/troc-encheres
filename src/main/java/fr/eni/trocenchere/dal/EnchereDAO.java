package fr.eni.trocenchere.dal;

import fr.eni.trocenchere.bo.Enchere;

public interface EnchereDAO 
{
	public void insertEnchere(Enchere enchere, int noArticle) throws Exception;	
}
