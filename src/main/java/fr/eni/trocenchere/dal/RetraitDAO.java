package fr.eni.trocenchere.dal;

import fr.eni.trocenchere.bo.Retrait;

public interface RetraitDAO {
	public void insertRetrait(Retrait retrait, int noArticle) throws Exception;
}
