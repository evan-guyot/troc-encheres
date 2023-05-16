package fr.eni.trocenchere.dal;

import java.sql.SQLException;

import fr.eni.trocenchere.bo.Utilisateur;

public interface UtilisateurDAO {
	public Utilisateur login(String identifiant, String motDePasse);
	public void newProfile(Utilisateur utilisateur)throws SQLException;
}
