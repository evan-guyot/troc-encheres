package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
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

	private static final String GET_ARTICLES = "SELECT a.*, u.*,c.*,e.*, r.*, u2.no_utilisateur no_utilisateur_acheteur, u2.pseudo pseudo_acheteur, u2.nom nom_acheteur, u2.prenom prenom_acheteur, u2.email email_acheteur, u2.telephone telephone_acheteur, u2.rue rue_acheteur, u2.code_postal code_postal_acheteur, u2.ville ville_acheteur, u2.mot_de_passe mot_de_passe_acheteur, u2.credit credit_acheteur, u2.administrateur administrateur_acheteur "
			+ "FROM ARTICLES_VENDUS a " + "JOIN UTILISATEURS u ON a.no_utilisateur = u.no_utilisateur "
			+ "JOIN CATEGORIES c ON c.no_categorie = a.no_categorie "
			+ "JOIN RETRAITS r ON r.no_article = a.no_article " + "LEFT JOIN ENCHERES e ON e.no_article = a.no_article "
			+ "LEFT JOIN UTILISATEURS u2 ON u2.no_utilisateur = e.no_utilisateur "
			+ "WHERE (e.date_enchere IN (select max(e.date_enchere) " + "FROM ARTICLES_VENDUS a2 "
			+ "JOIN ENCHERES e ON e.no_article = a2.no_article " + "GROUP BY a2.no_article) "
			+ "OR e.no_enchere is null) ";
	private static final String GET_ARTICLE_BY_ID = "SELECT a.*, u.*,c.*,e.*, r.*, u2.no_utilisateur no_utilisateur_acheteur, u2.pseudo pseudo_acheteur, u2.nom nom_acheteur, u2.prenom prenom_acheteur, u2.email email_acheteur, u2.telephone telephone_acheteur, u2.rue rue_acheteur, u2.code_postal code_postal_acheteur, u2.ville ville_acheteur, u2.mot_de_passe mot_de_passe_acheteur, u2.credit credit_acheteur, u2.administrateur administrateur_acheteur "
			+ "FROM ARTICLES_VENDUS a " + "JOIN UTILISATEURS u ON a.no_utilisateur = u.no_utilisateur "
			+ "JOIN CATEGORIES c ON c.no_categorie = a.no_categorie "
			+ "JOIN RETRAITS r ON r.no_article = a.no_article " + "LEFT JOIN ENCHERES e ON e.no_article = a.no_article "
			+ "LEFT JOIN UTILISATEURS u2 ON u2.no_utilisateur = e.no_utilisateur "
			+ "WHERE e.date_enchere IN (select max(e.date_enchere) " + "FROM ARTICLES_VENDUS a "
			+ "JOIN ENCHERES e ON e.no_article = a.no_article " + "WHERE a.no_article = ? " + "GROUP BY a.no_article) "
			+ "OR e.no_enchere is null " + "AND a.no_article = ?";
	private static final String INSERT_ARTICLE = "INSERT INTO ARTICLES_VENDUS VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE_ARTICLE = "UPDATE ARTICLES_VENDUS SET nom_article = ?, description = ?, date_debut_encheres = ?, date_fin_encheres = ?, prix_initial = ?, prix_vente = ?, no_categorie = ? WHERE no_article = ?";
	private static final String DELETE_ARTICLE = "DELETE FROM ARTICLES_VENDUS WHERE no_article = ?";

	@Override
	public List<Article> getArticles(int idCategorie, String caractereCompris, String radioFilterParameter, Integer id)
			throws Exception {
		List<Article> listArticle = new ArrayList<Article>();
		StringBuilder requete = new StringBuilder(GET_ARTICLES);

		if (idCategorie != 0) {
			requete.append(" AND c.no_categorie = " + idCategorie);
		}
		if (caractereCompris != null && !caractereCompris.trim().isBlank()) {
			requete.append(" AND nom_article like '%" + caractereCompris + "%'");
		}

		if (radioFilterParameter != null) {
			switch (radioFilterParameter) {

			case "enchere_ouvertes":
				requete.append(" AND CAST(GETDATE() AS DATE) > a.date_debut_encheres "
						+ "	AND CAST(GETDATE() AS DATE) < a.date_fin_encheres ");
				break;

			case "mes_encheres":
				requete.append(
						" AND CAST(GETDATE() AS DATE) < a.date_fin_encheres " + "	And u2.no_utilisateur=" + id);
				break;

			case "mes_encheres_remportes":
				requete.append(" AND CAST(GETDATE() AS DATE) > a.date_debut_encheres"
						+ "	AND CAST(GETDATE() AS DATE) > a.date_fin_encheres " + "	And u2.no_utilisateur=" + id);
				break;

			case "mes_ventes_en_cours":
				requete.append(" AND CAST(GETDATE() AS DATE) > a.date_debut_encheres "
						+ "	AND CAST(GETDATE() AS DATE) < a.date_fin_encheres " + "	And u.no_utilisateur=" + id);
				break;

			case "ventes_non_debutes":
				requete.append("AND CAST(GETDATE() AS DATE) < a.date_debut_encheres "
						+ "	AND CAST(GETDATE() AS DATE) < a.date_fin_encheres " + "	And u.no_utilisateur=" + id);
				break;

			case "ventes_terminees":
				requete.append(" AND CAST(GETDATE() AS DATE) > a.date_debut_encheres "
						+ "	AND CAST(GETDATE() AS DATE) > a.date_fin_encheres " + "	And u.no_utilisateur=" + id);
				break;

			default:
				System.out.println("Choix incorrect");
				break;
			}
		}

		try (Connection conn = ConnectionProvider.connection();
				PreparedStatement pstmt = conn.prepareStatement(requete.toString());) {

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Categorie categorieArticle = new Categorie(rs.getInt("no_categorie"), rs.getString("libelle"));

				Utilisateur vendeur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
						rs.getString("nom"), rs.getString("prenom"), rs.getString("email"), rs.getString("telephone"),
						rs.getString("rue"), rs.getString("code_postal"), rs.getString("ville"), rs.getInt("credit"),
						rs.getBoolean("administrateur"));

				Utilisateur acheteur = rs.getInt("no_utilisateur_acheteur") != 0 ? new Utilisateur(
						rs.getInt("no_utilisateur_acheteur"), rs.getString("pseudo_acheteur"),
						rs.getString("nom_acheteur"), rs.getString("prenom_acheteur"), rs.getString("email_acheteur"),
						rs.getString("telephone_acheteur"), rs.getString("rue_acheteur"),
						rs.getString("code_postal_acheteur"), rs.getString("ville_acheteur"),
						rs.getInt("credit_acheteur"), rs.getBoolean("administrateur_acheteur")) : null;

				Enchere enchere = rs.getInt("no_enchere") != 0 ? new Enchere(rs.getInt("no_enchere"),
						rs.getTimestamp("date_enchere").toLocalDateTime(), rs.getInt("montant_enchere"), acheteur)
						: null;

				Retrait retrait = new Retrait(rs.getString("rue"), rs.getString("code_postal"), rs.getString("ville"));

				listArticle.add(new Article(rs.getInt("no_article"), rs.getString("nom_article"),
						rs.getString("description"), rs.getDate("date_debut_encheres").toLocalDate(),
						rs.getDate("date_fin_encheres").toLocalDate(), rs.getInt("prix_initial"),
						rs.getInt("prix_vente"), rs.getDate("date_fin_encheres").toLocalDate().isAfter(LocalDate.now()),
						vendeur, categorieArticle, enchere, retrait));
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
				stm.setInt(2, id);
				ResultSet rs = stm.executeQuery();

				if (rs.next()) {

					Categorie categorieArticle = new Categorie(rs.getInt("no_categorie"), rs.getString("libelle"));

					Utilisateur vendeur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
							rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),
							rs.getString("telephone"), rs.getString("rue"), rs.getString("code_postal"),
							rs.getString("ville"), rs.getInt("credit"), rs.getBoolean("administrateur"));

					Utilisateur acheteur = rs.getInt("no_utilisateur_acheteur") != 0
							? new Utilisateur(rs.getInt("no_utilisateur_acheteur"), rs.getString("pseudo_acheteur"),
									rs.getString("nom_acheteur"), rs.getString("prenom_acheteur"),
									rs.getString("email_acheteur"), rs.getString("telephone_acheteur"),
									rs.getString("rue_acheteur"), rs.getString("code_postal_acheteur"),
									rs.getString("ville_acheteur"), rs.getInt("credit_acheteur"),
									rs.getBoolean("administrateur_acheteur"))
							: null;

					Enchere enchere = rs.getInt("no_enchere") != 0 ? new Enchere(rs.getInt("no_enchere"),
							rs.getTimestamp("date_enchere").toLocalDateTime(), rs.getInt("montant_enchere"), acheteur)
							: null;

					Retrait retrait = new Retrait(rs.getString("rue"), rs.getString("code_postal"),
							rs.getString("ville"));

					articleCourrant = new Article(rs.getInt("no_article"), rs.getString("nom_article"),
							rs.getString("description"), rs.getDate("date_debut_encheres").toLocalDate(),
							rs.getDate("date_fin_encheres").toLocalDate(), rs.getInt("prix_initial"),
							rs.getInt("prix_vente"),
							rs.getDate("date_fin_encheres").toLocalDate().isAfter(LocalDate.now()), vendeur,
							categorieArticle, enchere, retrait);

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

	@Override
	public int insertArticle(Article article, int idUtilisateur, int idCategorie) throws Exception {
		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement stm = cnx.prepareStatement(INSERT_ARTICLE, Statement.RETURN_GENERATED_KEYS)) {
			stm.setString(1, article.getNom());
			stm.setString(2, article.getDescription());
			stm.setDate(3, Date.valueOf(article.getDateDebutEnchere()));
			stm.setDate(4, Date.valueOf(article.getDateFinEnchere()));
			stm.setInt(5, article.getMiseAPrix());
			stm.setInt(6, article.getPrixVente());
			stm.setInt(7, idUtilisateur);
			stm.setInt(8, idCategorie);
			stm.executeUpdate();
			ResultSet rs = stm.getGeneratedKeys();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return 0;
	}

	
	@Override
	public void updateArticle(Article article, int idCategorie) throws Exception {
		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement stm = cnx.prepareStatement(UPDATE_ARTICLE)) {
			stm.setString(1, article.getNom());
			stm.setString(2, article.getDescription());
			stm.setDate(3, Date.valueOf(article.getDateDebutEnchere()));
			stm.setDate(4, Date.valueOf(article.getDateFinEnchere()));
			stm.setInt(5, article.getMiseAPrix());
			stm.setInt(6, article.getPrixVente());
			stm.setInt(7, idCategorie);
			stm.setInt(8, article.getNoArticle());
			stm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteArticleById(int idArticle) throws Exception {
		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement stm = cnx.prepareStatement(DELETE_ARTICLE)) {
			stm.setInt(1, idArticle);
			stm.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}
}