package fr.eni.trocenchere.bll;

import java.sql.SQLException;

import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.DAOFactory;
import fr.eni.trocenchere.dal.UtilisateurDAO;
import fr.eni.trocenchere.dal.jdbc.UtilisateurDaoJdbcImpl;

public class UtilisateurManager {
	private UtilisateurDAO daoUtilisateur;

	private static UtilisateurManager instance;

	public UtilisateurManager() {
		daoUtilisateur =  DAOFactory.getUtilisateurDAO();
	}
	
	public Utilisateur updateUserById(int id) {
		try {
			validationUserId(id);
			return daoUtilisateur.updateUserById(id);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return null;
	}
	
	public Boolean deleteUserById(String mdp, int id){
		try {
			validationUserId(id);
			validationUserPassword(mdp);
			return daoUtilisateur.deleteUserById(mdp, id);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		return false;
	}

	public static UtilisateurManager getInstance() {
		if (instance == null)
			instance = new UtilisateurManager();

		return instance;
	}
	
	public Utilisateur getUserById(int id){
		validationUserId(id);
		try {
			return daoUtilisateur.getUserById(id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public Utilisateur connecterUtilisateur(String identifiant, String motDePasse) throws Exception {
		validConnectionUtilisateur(identifiant, motDePasse);
		return daoUtilisateur.login(identifiant, motDePasse);
	}
	
	public void validConnectionUtilisateur(String identifiant, String motDePasse) throws Exception {
		StringBuilder sb = new StringBuilder();

		if (identifiant.isBlank() || motDePasse.isBlank())
			sb.append("Les informations entrées sont invalides");

		if (sb.length() > 0)
			throw new Exception(sb.toString());
	}
	public boolean verifEmail(String email)
	{
		UtilisateurDaoJdbcImpl conn = new UtilisateurDaoJdbcImpl();
		boolean result = false;
		try 
		{
			result = conn.verifEmail(email);
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}

		return result;
	}

	public boolean verifPseudo(String pseudo)
	{
		UtilisateurDaoJdbcImpl conn = new UtilisateurDaoJdbcImpl();
		boolean result = false;
		try 
		{
			result = conn.verifPseudo(pseudo);
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}

		return result;
	}
	public void creationProfile(Utilisateur utilisateur) throws Exception {

		StringBuilder sb = new StringBuilder();
		
		
		if (utilisateur.getPseudo().isBlank())
			sb.append("Il manque : pseudo");
		if (utilisateur.getNom().isBlank())
			sb.append("Il manque : nom");
		if (utilisateur.getPrenom().isBlank())
			sb.append("Il manque : prenom");
		if (utilisateur.getEmail().isBlank())
			sb.append("Il manque : email");
		if (utilisateur.getTelephone().isBlank())
			sb.append("Il manque : tel");
		if (utilisateur.getRue().isBlank())
			sb.append("Il manque : rue");
		if (utilisateur.getCodePostal().isBlank())
			sb.append("Il manque : codepostal");
		if (utilisateur.getVille().isBlank())
			sb.append("Il manque : ville");
		if (utilisateur.getMotDePasse().isBlank())
			sb.append("Il manque : mdp");
		
		
		if (sb.length() > 0)
			throw new Exception(sb.toString());
		
		UtilisateurDaoJdbcImpl conn = new UtilisateurDaoJdbcImpl();
		conn.newProfile(utilisateur);
			
	}
	
	public void validationUserId(int id) {
		if(id != (int)id) {
			throw new NumberFormatException();
		}
	}
	
	public void validationUserPassword(String mdp) throws Exception{
		if (mdp == null || mdp.equals("") || mdp.trim().equals("")) {
			throw new Exception("le mot de passe est invalide");
		}
	}
}
