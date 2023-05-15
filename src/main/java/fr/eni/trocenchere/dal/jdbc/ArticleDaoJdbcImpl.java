package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.ArticleDAO;

public class ArticleDaoJdbcImpl implements ArticleDAO {
	private static final String GET_ALL_ARTICLES = "select * from Articles";

	@Override
	public ArrayList<Article> getArticles() throws Exception {
		ArrayList<Article> listArticle = null;
		
		try (Connection conn = JdbcTools.getConnection();
				Statement stmt = conn.createStatement();) {

			ResultSet rs = stmt.executeQuery(GET_ALL_ARTICLES);
			
			/*
				int noArticle, 
				String nom, 
				String description, 
				LocalDate dateDebutEnchere, 
				LocalDate dateFinEnchere,
				int miseAPrix, 
				int prixVente, 
				boolean etatVente, 
				int noUtilisateur, 
				int noCategorie
				}
			*/

			if (rs.next()) {
				System.out.println("=============================");
				System.out.println(rs.getString("nom_article"));
				/*listArticle.add( 
					new Article(
						rs.getInt("no_article"),
						rs.getString("nom_article"),
						rs.getString("description"),
						rs.getDate("date_debut_encheres").toLocalDate(),
						rs.getDate("date_fin_encheres").toLocalDate(),
						rs.getInt("prix_initial"),
						rs.getInt("prix_vente"),
						rs.getInt("no_utilisateur"),
						rs.getString("no_categorie")						
					));*/
			}
		} catch (SQLException e) {
			throw new Exception(e);
		}
		return listArticle;	
	}

}
