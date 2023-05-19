package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Categorie;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.CategorieDAO;
import fr.eni.trocenchere.dal.ConnectionProvider;

public class CategorieDaoJdbcImpl implements CategorieDAO {
	private static final String GET_ALL_CATEGORIES = "select * from CATEGORIES";

	@Override
	public List<Categorie> getCategories() throws Exception {
		List<Categorie> listCategorie = new ArrayList<Categorie>();

		try (Connection conn = ConnectionProvider.connection(); Statement stmt = conn.createStatement();) {
			ResultSet rs = stmt.executeQuery(GET_ALL_CATEGORIES);

			while (rs.next()) {
				listCategorie.add(new Categorie(rs.getInt("no_categorie"), rs.getString("libelle")));
			}

			return listCategorie;
		} catch (SQLException e) {
			throw new Exception(e);
		}
	}

}