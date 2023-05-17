package fr.eni.trocenchere.dal;

import java.sql.SQLException;

import fr.eni.trocenchere.bo.Utilisateur;

public interface UtilisateurDAO {
	public Utilisateur login(String identifiant, String motDePasse) throws Exception;
	public void newProfile(Utilisateur utilisateur)throws SQLException;
	public boolean verifEmail(String email)throws SQLException;
	public boolean verifPseudo(String pseudo)throws SQLException;
  	public Utilisateur getUserById(int id) throws SQLException;
	public Boolean deleteUserById(String password, int id) throws SQLException;
	public Utilisateur updateUserById(int id) throws SQLException;
}
