package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;

import fr.eni.trocenchere.bo.Retrait;
import fr.eni.trocenchere.dal.ConnectionProvider;
import fr.eni.trocenchere.dal.RetraitDAO;

public class RetraitDaoJdbcImpl implements RetraitDAO {
	private final static String INSERT_RETRAIT = "INSERT INTO RETRAITS VALUES (?, ?, ?, ?)";
	private final static String UPDATE_RETRAIT = "UPDATE RETRAITS SET rue = ?, code_postal = ?, ville = ? WHERE no_article = ?";
	private final static String DELETE_RETRAIT = "DELETE FROM RETRAITS WHERE no_article = ?";
	
	@Override 
	public void insertRetrait(Retrait retrait, int noArticle) throws Exception {
		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement stm = cnx.prepareStatement(INSERT_RETRAIT)) {

			stm.setInt(1, noArticle);
			stm.setString(2, retrait.getRue());
			stm.setString(3, retrait.getCodePostal());
			stm.setString(4, retrait.getVille());

			stm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateRetrait(Retrait retrait, int noArticle) throws Exception {
		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement stm = cnx.prepareStatement(UPDATE_RETRAIT)) {
			
			stm.setString(1, retrait.getRue());
			stm.setString(2, retrait.getCodePostal());
			stm.setString(3, retrait.getVille());
			stm.setInt(4, noArticle);

			stm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteRetraitById(int idArticle) throws Exception {
		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement stm = cnx.prepareStatement(DELETE_RETRAIT)) {
			stm.setInt(1, idArticle);

			stm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}
}