package fr.eni.trocenchere.dal;

import fr.eni.trocenchere.bo.Retrait;

public interface RetraitDAO {
	public void insertRetrait(Retrait retrait, int noArticle) throws Exception;

	public void updateRetrait(Retrait retrait, int noArticle) throws Exception;

	public void deleteRetraitById(int idArticle) throws Exception;
	
	public void updateCollectedRetrait(int noArticle) throws Exception;
}
