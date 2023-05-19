package fr.eni.trocenchere.dal;

import java.util.List;

import fr.eni.trocenchere.bo.Categorie;

public interface CategorieDAO {
	public List<Categorie> getCategories() throws Exception ;
}
