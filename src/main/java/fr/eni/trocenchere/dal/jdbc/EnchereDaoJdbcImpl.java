package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.format.DateTimeFormatter;

import fr.eni.trocenchere.bo.Enchere;
import fr.eni.trocenchere.dal.ConnectionProvider;
import fr.eni.trocenchere.dal.EnchereDAO;

public class EnchereDaoJdbcImpl implements EnchereDAO{

	private static final String INSERT_ENCHERE = "INSERT INTO ENCHERES VALUES (CONVERT(datetime, ?, 120), ?, ?, ?);";

	@Override
	public void insertEnchere(Enchere enchere, int noArticle) throws Exception {
	    try (Connection cnx = ConnectionProvider.connection();
	         PreparedStatement stm = cnx.prepareStatement(INSERT_ENCHERE)) {

	    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.SSS");
	    	String formattedDate = enchere.getDateEnchere().format(formatter);
	    	stm.setString(1, formattedDate);
	        stm.setInt(2, enchere.getMontantEnchere());
	        stm.setInt(3, noArticle);
	        stm.setInt(4, enchere.getUtilisateur().getNoUtilisateur());
	       
	        stm.executeUpdate();
            stm.close();
            cnx.commit(); 
	    } catch (Exception e) {
	    	
	        e.printStackTrace();
	        throw e;
	    }
	}
	
	

}
