package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;

import fr.eni.trocenchere.bo.Retrait;
import fr.eni.trocenchere.dal.ConnectionProvider;
import fr.eni.trocenchere.dal.RetraitDAO;

public class RetraitDaoJdbcImpl implements RetraitDAO {
	private final static String INSERT_RETRAIT = "INSERT INTO RETRAITS VALUES (?, ?, ?, ?)";

	@Override
	public void insertRetrait(Retrait retrait, int noArticle) throws Exception {
		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement stm = cnx.prepareStatement(INSERT_RETRAIT)) {

			System.out.println(noArticle);
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
}