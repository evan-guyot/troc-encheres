package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import fr.eni.trocenchere.dal.ConnectionProvider;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.UtilisateurDAO;

public class UtilisateurDaoJdbcImpl implements UtilisateurDAO {
	private static final String LOGIN_REQ = "select * from UTILISATEURS where (pseudo = ? and mot_de_passe = ?) or (email = ? and mot_de_passe = ?)";
	private static final String NEW_PROFILE_REQ = "insert into UTILISATEURS values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	

	@Override
	public void newProfile(Utilisateur utilisateur)throws SQLException {
		
		
		try(Connection cnx = ConnectionProvider.connection())
		{
			try
			{
				
				cnx.setAutoCommit(false);
				PreparedStatement pstmt;
				pstmt = cnx.prepareStatement(NEW_PROFILE_REQ);
				pstmt.setString(1, utilisateur.getPseudo());
				pstmt.setString(2, utilisateur.getNom());
				pstmt.setString(3, utilisateur.getPrenom());
				pstmt.setString(4, utilisateur.getEmail());
				pstmt.setString(5, utilisateur.getTelephone());
				pstmt.setString(6, utilisateur.getRue());
				pstmt.setString(7, utilisateur.getCodePostal());
				pstmt.setString(8, utilisateur.getVille());
				pstmt.setString(9, utilisateur.getMotDePasse());
				pstmt.setInt(10, utilisateur.getCredit());
				pstmt.setBoolean(11, utilisateur.isAdministrateur());
			
				pstmt.executeUpdate();
				pstmt.close();
				cnx.commit();
				
			}
			catch(Exception e)
			{
				e.printStackTrace();
				cnx.rollback();
				throw e;
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
	}


	@Override
	public Utilisateur login(String identifiant, String motDePasse) {
		// TODO Auto-generated method stub
		return null;
	}

}
