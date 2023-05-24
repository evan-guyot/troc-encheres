package fr.eni.trocenchere.dal;

import java.sql.SQLException;
import java.util.List;

import fr.eni.trocenchere.bo.Utilisateur;

public interface UtilisateurDAO {
	public Utilisateur login(String identifiant, String motDePasse) throws Exception;
	public void newProfile(Utilisateur utilisateur)throws SQLException;
	public boolean verifEmail(String email)throws SQLException;
	public boolean verifPseudo(String pseudo)throws SQLException;
	public List<Utilisateur> selectAllUser()throws SQLException;
	public Utilisateur getUserById(int id) throws SQLException;
	public void nouveauSolde(Utilisateur user)throws SQLException;
	public List<Utilisateur> selectAllUserPotentialDeleted() throws SQLException;
	public void deleteUserById(int id) throws Exception;
	public Boolean deleteUserByIdWithPassword(String password, int id) throws SQLException;
	public Utilisateur updateUserById(Utilisateur utilisateur, int id) throws SQLException;

}
