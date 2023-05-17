package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.ArticleDAO;
import fr.eni.trocenchere.dal.ConnectionProvider;

public class ArticleDaoJdbcImpl implements ArticleDAO {
	private static final String GET_ALL_ARTICLES_JOIN_USER_BY_ID = "select * from ARTICLES_VENDUS a inner join UTILISATEURS as u ON a.no_utilisateur = u.no_utilisateur join CATEGORIES c on a.no_categorie = c.no_categorie";

	@Override
	public List<Article> getArticles(int idCategorie, String caractereCompris) throws Exception {
		List<Article> listArticle = new ArrayList<Article>();

		try (Connection conn = ConnectionProvider.connection(); Statement stmt = conn.createStatement();) {

			StringBuilder requete = new StringBuilder(GET_ALL_ARTICLES_JOIN_USER_BY_ID);


			if (idCategorie != 0) {
				requete.append(operatorPicker(requete));
				requete.append("c.no_categorie = " + idCategorie);
			}
			if (caractereCompris != null && !caractereCompris.trim().isBlank()) {
				requete.append(operatorPicker(requete));
				requete.append("nom_article like '%" + caractereCompris + "%'");
			}
			System.out.println(requete.toString());

			ResultSet rs = stmt.executeQuery(requete.toString());
			while (rs.next()) {
				Date dateDebut = rs.getDate("date_debut_encheres");
				Date dateFin = rs.getDate("date_fin_encheres");

				Utilisateur utilisateur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
						rs.getString("nom"), rs.getString("prenom"), rs.getString("email"), rs.getString("telephone"),
						rs.getString("rue"), rs.getString("code_postal"), rs.getString("ville"), rs.getInt("credit"),
						rs.getBoolean("administrateur"));

				listArticle.add(
						new Article(rs.getInt("no_article"), rs.getString("nom_article"), rs.getString("description"),
								dateDebut.toLocalDate(), dateFin.toLocalDate(), rs.getInt("prix_initial"),
								rs.getInt("prix_vente"), false, utilisateur, rs.getInt("no_categorie")));
			}

			return listArticle;
		} catch (SQLException e) {
			throw new Exception(e);
		}
	}

	private String operatorPicker(StringBuilder sb) {
		if (sb.toString().contains("WHERE")) {
			return " AND ";
		} else {
			return " WHERE ";
		}
	}
}