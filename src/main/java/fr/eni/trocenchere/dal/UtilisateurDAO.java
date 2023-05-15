package fr.eni.trocenchere.dal;

import fr.eni.trocenchere.bo.Utilisateur;

public interface UtilisateurDAO {
	public Utilisateur login(String identifiant, String motDePasse);
}
