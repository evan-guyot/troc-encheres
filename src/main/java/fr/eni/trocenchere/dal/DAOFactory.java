package fr.eni.trocenchere.dal;

import fr.eni.trocenchere.dal.jdbc.UtilisateurDaoJdbcImpl;

public class DAOFactory {
	public static UtilisateurDAO getUtilisateurDAO() {
		UtilisateurDAO utilisateurDAO = (UtilisateurDAO) new UtilisateurDaoJdbcImpl();
		return utilisateurDAO;
	}
}
