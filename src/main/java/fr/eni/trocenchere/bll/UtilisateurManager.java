package fr.eni.trocenchere.bll;

import fr.eni.trocenchere.dal.DAOFactory;
import fr.eni.trocenchere.dal.UtilisateurDAO;

public class UtilisateurManager {
	private UtilisateurDAO daoUtilisateur;

	private static UtilisateurManager instance;

	private UtilisateurManager() {
		daoUtilisateur =  DAOFactory.getUtilisateurDAO();
	}

	public static UtilisateurManager getInstance() {
		if (instance == null)
			instance = new UtilisateurManager();

		return instance;
	}

	
	public void validConnectionUtilisateur(String identifiant, String motDePasse) throws Exception {
		StringBuilder sb = new StringBuilder();

		if (identifiant.isBlank() || motDePasse.isBlank())
			sb.append("Les informations entrées sont invalides");

		if (sb.length() > 0)
			throw new Exception(sb.toString());
	}
}
