package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Categorie;
import fr.eni.trocenchere.bo.Enchere;
import fr.eni.trocenchere.bo.Retrait;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.ArticleDAO;
import fr.eni.trocenchere.dal.ConnectionProvider;

public class ArticleDaoJdbcImpl implements ArticleDAO {
	private static final String GET_ALL_ARTICLES_JOIN_USER_BY_ID = "SELECT  a.*, u.*,c.*,e.*, r.*, u2.no_utilisateur no_utilisateur_acheteur, u2.pseudo pseudo_acheteur, u2.nom nom_acheteur, u2.prenom prenom_acheteur, u2.email email_acheteur, u2.telephone telephone_acheteur, u2.rue rue_acheteur, u2.code_postal code_postal_acheteur, u2.ville ville_acheteur, u2.mot_de_passe mot_de_passe_acheteur, u2.credit credit_acheteur, u2.administrateur administrateur_acheteur FROM ARTICLES_VENDUS a JOIN UTILISATEURS u ON a.no_utilisateur = u.no_utilisateur JOIN CATEGORIES c ON c.no_categorie = a.no_categorie JOIN ENCHERES e ON e.no_article = a.no_utilisateur JOIN UTILISATEURS u2 ON u2.no_utilisateur = e.no_utilisateur JOIN RETRAITS r ON r.no_article = a.no_article";
	private static final String GET_ARTICLE_BY_ID = "SELECT a.*, u.*,c.*,e.*,r.*, u2.no_utilisateur no_utilisateur_acheteur, u2.pseudo pseudo_acheteur, u2.nom nom_acheteur, u2.prenom prenom_acheteur, u2.email email_acheteur, u2.telephone telephone_acheteur, u2.rue rue_acheteur, u2.code_postal code_postal_acheteur, u2.ville ville_acheteur, u2.mot_de_passe mot_de_passe_acheteur, u2.credit credit_acheteur, u2.administrateur administrateur_acheteur FROM ARTICLES_VENDUS a JOIN UTILISATEURS u ON a.no_utilisateur = u.no_utilisateur JOIN CATEGORIES c ON c.no_categorie = a.no_categorie JOIN ENCHERES e ON e.no_article = a.no_utilisateur JOIN UTILISATEURS u2 ON u2.no_utilisateur = e.no_utilisateur JOIN RETRAITS r ON r.no_article = a.no_article WHERE a.no_article = ?";

	@Override
	public List<Article> getArticles() throws Exception {
		List<Article> listArticle = new ArrayList<Article>();

		try (Connection conn = ConnectionProvider.connection(); Statement stmt = conn.createStatement();) {

			ResultSet rs = stmt.executeQuery(GET_ALL_ARTICLES_JOIN_USER_BY_ID);

			while (rs.next()) {
				Date dateDebut = rs.getDate("date_debut_encheres");
				Date dateFin = rs.getDate("date_fin_encheres");

				Categorie categorieArticle = new Categorie(rs.getInt("no_categorie"), rs.getString("libelle"));

				Utilisateur vendeur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
						rs.getString("nom"), rs.getString("prenom"), rs.getString("email"), rs.getString("telephone"),
						rs.getString("rue"), rs.getString("code_postal"), rs.getString("ville"), rs.getInt("credit"),
						rs.getBoolean("administrateur"));

				Utilisateur acheteur = new Utilisateur(rs.getInt("no_utilisateur_acheteur"),
						rs.getString("pseudo_acheteur"), rs.getString("nom_acheteur"), rs.getString("prenom_acheteur"),
						rs.getString("email_acheteur"), rs.getString("telephone_acheteur"),
						rs.getString("rue_acheteur"), rs.getString("code_postal_acheteur"),
						rs.getString("ville_acheteur"), rs.getInt("credit_acheteur"),
						rs.getBoolean("administrateur_acheteur"));

				Enchere enchere = new Enchere(rs.getInt("no_enchere"), rs.getDate("date_enchere").toLocalDate(),
						rs.getInt("montant_enchere"), acheteur);

				Retrait retrait = new Retrait(rs.getString("rue"), rs.getString("code_postal"), rs.getString("ville"));

				listArticle.add(
						new Article(rs.getInt("no_article"), rs.getString("nom_article"), rs.getString("description"),
								dateDebut.toLocalDate(), dateFin.toLocalDate(), rs.getInt("prix_initial"),
								rs.getInt("prix_vente"), false, vendeur, categorieArticle, enchere, retrait));

			}
			return listArticle;
		} catch (SQLException e) {
			throw new Exception(e);
		}
	}

	@Override
	public Article getArticleById(int id) throws Exception {
		Article articleCourrant = null;

		try (Connection cnx = ConnectionProvider.connection()) {

			try {

				cnx.setAutoCommit(false);
				PreparedStatement stm = cnx.prepareStatement(GET_ARTICLE_BY_ID);

				stm.setInt(1, id);
				ResultSet rs = stm.executeQuery();

				if (rs.next()) {

					Categorie categorieArticle = new Categorie(rs.getInt("no_categorie"), rs.getString("libelle"));

					Utilisateur vendeur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
							rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),
							rs.getString("telephone"), rs.getString("rue"), rs.getString("code_postal"),
							rs.getString("ville"), rs.getInt("credit"), rs.getBoolean("administrateur"));

					Utilisateur acheteur = new Utilisateur(rs.getInt("no_utilisateur_acheteur"),
							rs.getString("pseudo_acheteur"), rs.getString("nom_acheteur"),
							rs.getString("prenom_acheteur"), rs.getString("email_acheteur"),
							rs.getString("telephone_acheteur"), rs.getString("rue_acheteur"),
							rs.getString("code_postal_acheteur"), rs.getString("ville_acheteur"),
							rs.getInt("credit_acheteur"), rs.getBoolean("administrateur_acheteur"));

					Enchere enchere = new Enchere(rs.getInt("no_enchere"), rs.getDate("date_enchere").toLocalDate(),
							rs.getInt("montant_enchere"), acheteur);

					Retrait retrait = new Retrait(rs.getString("rue"), rs.getString("code_postal"),
							rs.getString("ville"));

					articleCourrant = new Article(rs.getInt("no_article"), rs.getString("nom_article"),
							rs.getString("description"), rs.getDate("date_debut_encheres").toLocalDate(),
							rs.getDate("date_fin_encheres").toLocalDate(), rs.getInt("prix_initial"),
							rs.getInt("prix_vente"), rs.getInt("prix_vente") == 0, vendeur, categorieArticle, enchere,
							retrait);

				}

				stm.close();
				cnx.commit();

			} catch (Exception e) {

				e.printStackTrace();
				cnx.rollback();
				throw e;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return articleCourrant;
	}

}
