package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.UtilisateurDAO;

public class UtilisateurDaoJdbcImpl implements UtilisateurDAO {
	private static final String LOGIN_REQ = "select * from UTILISATEURS where (pseudo = ? and mot_de_passe = ?) or (email = ? and mot_de_passe = ?)";

	@Override
	public Utilisateur login(String identifiant, String motDePasse) {
		Utilisateur  utilisateur = null;
		
		try (Connection conn = JdbcTools.getConnection();
				PreparedStatement stm = conn.prepareStatement(LOGIN_REQ);) {
			
			stm.setString(1, identifiant);
			stm.setString(2, motDePasse);
			stm.setString(3, identifiant);
			stm.setString(4, motDePasse);

			ResultSet rs = stm.executeQuery();

			if (rs.next()) {				
				utilisateur = 
						new Utilisateur(
								rs.getInt("no_utilisateur"),
								rs.getString("pseudo"),
								rs.getString("nom"),
								rs.getString("prenom"),
								rs.getString("email"),
								rs.getString("telephone"),
								rs.getString("rue"),
								rs.getString("code_postal"),
								rs.getString("ville"),
								rs.getInt("credit"),
								rs.getBoolean("administrateur")								
								);
			}
		} catch (SQLException e) {
		}
		return utilisateur;		
	}

}
