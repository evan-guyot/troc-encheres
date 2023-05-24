package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Categorie;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.CategorieDAO;
import fr.eni.trocenchere.dal.ConnectionProvider;

public class CategorieDaoJdbcImpl implements CategorieDAO {
	private static final String GET_ALL_CATEGORIES = "SELECT * FROM Categories";
	private static final String GET_CATEGORIE_BY_ID = "SELECT * FROM Categories WHERE no_categorie = ?";
	private static final String INSERT_CATEGORIE = "insert into CATEGORIES values(?)";
	private static final String SELECT_ALL_ARTICLE_BY_CATEG_ID = "select * from ARTICLES_VENDUS a, CATEGORIES c where a.no_categorie = c.no_categorie and c.no_categorie = ?";
	private static final String DELETE_CATEG_BY_ID = "DELETE FROM CATEGORIES WHERE no_categorie = ?";
	private static final String UPDATE_LIBELLE_CATEG = "UPDATE CATEGORIES SET libelle = ? where no_categorie = ?";
	
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
	
	@Override
	public List<Article> selectAllArticleByIdCateg(int id) throws Exception {
		List<Article> listArticle = new ArrayList<Article>();

		try (Connection conn = ConnectionProvider.connection(); PreparedStatement pstmt = conn.prepareStatement(SELECT_ALL_ARTICLE_BY_CATEG_ID);) {
			
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) 
			{
				Article article = new Article(
						rs.getInt("no_article"), 
						rs.getString("nom_article"),
						rs.getString("description"), 
						rs.getDate("date_debut_encheres").toLocalDate(),
						rs.getDate("date_fin_encheres").toLocalDate(), 
						rs.getInt("prix_initial"),
						rs.getInt("prix_vente"), 
						rs.getDate("date_fin_encheres").toLocalDate().isAfter(LocalDate.now()));
				listArticle.add(article);
			}
				
			return listArticle;
		} catch (SQLException e) {
			throw new Exception(e);
		}
	}
	
	

	@Override
	public Categorie getCategorieById(int id) throws Exception {
		Categorie categorie = null;

		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement pstmt = cnx.prepareStatement(GET_CATEGORIE_BY_ID);) {
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				categorie = new Categorie(rs.getInt("no_categorie"), rs.getString("libelle"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categorie;
	}

	@Override
	public void insertCategorie(String categorie) throws Exception 
	{
		try (Connection cnx = ConnectionProvider.connection();
		         PreparedStatement stm = cnx.prepareStatement(INSERT_CATEGORIE)) 
		{
		    	stm.setString(1, categorie);
		        stm.executeUpdate();
		    } catch (Exception e) 
		{
		    	
		        e.printStackTrace();
		        throw e;
		    }
	}
	
	public void updateLibelleCateg(Categorie categorie) throws Exception 
	{
		try (Connection cnx = ConnectionProvider.connection();
		         PreparedStatement stm = cnx.prepareStatement(UPDATE_LIBELLE_CATEG)) 
		{
		    	stm.setString(1, categorie.getLibelle());
		    	stm.setInt(2, categorie.getNoCategorie());
		    	
		        stm.executeUpdate();
		    } catch (Exception e) 
		{
		    	
		        e.printStackTrace();
		        throw e;
		    }
	}
	
	@Override
	public void deleteCategById(int id) throws Exception 
	{
		try (Connection cnx = ConnectionProvider.connection();
		         PreparedStatement stm = cnx.prepareStatement(DELETE_CATEG_BY_ID)) 
		{
		    	stm.setInt(1, id);
		        stm.executeUpdate();
		    } catch (Exception e) 
		{
		    	
		        e.printStackTrace();
		        throw e;
		    }
	}
}
