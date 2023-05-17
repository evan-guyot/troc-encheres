package fr.eni.trocenchere.dal;

import java.sql.SQLException;

import fr.eni.trocenchere.bo.Utilisateur;

public interface UtilisateurDAO {
	public Utilisateur login(String identifiant, String motDePasse) throws Exception;
	public void newProfile(Utilisateur utilisateur) throws SQLException;
	public Utilisateur getUserById(int id) throws SQLException;
}
