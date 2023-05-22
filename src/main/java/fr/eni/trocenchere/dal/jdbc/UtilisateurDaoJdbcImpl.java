package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import fr.eni.trocenchere.dal.ConnectionProvider;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.UtilisateurDAO;

public class UtilisateurDaoJdbcImpl implements UtilisateurDAO {

	private static final String LOGIN_REQ = "select * from UTILISATEURS where (pseudo = ? and mot_de_passe = ?) or (email = ? and mot_de_passe = ?)";
	private static final String NEW_PROFILE_REQ = "insert into UTILISATEURS values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String VERIF_EMAIL = "select * from UTILISATEURS where email = ?";
	private static final String VERIF_PSEUDO = "select * from UTILISATEURS where pseudo = ?";
	private static final String GET_USER_BY_ID = "select * from UTILISATEURS where no_utilisateur=?";
	private static final String NOUVEAU_SOLDE = "UPDATE UTILISATEURS SET credit = ? WHERE no_utilisateur = ?";

	@Override
	public void newProfile(Utilisateur utilisateur) throws SQLException {

		try (Connection cnx = ConnectionProvider.connection()) {
			try {

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

			} catch (Exception e) {
				e.printStackTrace();
				cnx.rollback();
				throw e;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public boolean verifEmail(String email) throws SQLException {

		try (Connection cnx = ConnectionProvider.connection()) {
			try {
				Utilisateur utilisateur = null;
				cnx.setAutoCommit(false);
				PreparedStatement stm = cnx.prepareStatement(VERIF_EMAIL);

				stm.setString(1, email);
				ResultSet rs = stm.executeQuery();

				if (rs.next()) {
					utilisateur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
							rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),
							rs.getString("telephone"), rs.getString("rue"), rs.getString("code_postal"),
							rs.getString("ville"), rs.getInt("credit"), rs.getBoolean("administrateur"));
				}
				stm.close();
				cnx.commit();
				if (utilisateur != null) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				cnx.rollback();
				throw e;
			}

		} catch (Exception e) {
			throw new SQLException(e);
		}

	}

	@Override
	public boolean verifPseudo(String pseudo) throws SQLException {

		try (Connection cnx = ConnectionProvider.connection()) {
			try {
				Utilisateur utilisateur = null;
				cnx.setAutoCommit(false);
				PreparedStatement stm = cnx.prepareStatement(VERIF_PSEUDO);

				stm.setString(1, pseudo);
				ResultSet rs = stm.executeQuery();

				if (rs.next()) {
					utilisateur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
							rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),
							rs.getString("telephone"), rs.getString("rue"), rs.getString("code_postal"),
							rs.getString("ville"), rs.getInt("credit"), rs.getBoolean("administrateur"));
				}
				stm.close();
				cnx.commit();
				if (utilisateur != null) {
					return true;
				} else {
					return false;
				}
			} catch (Exception e) {
				cnx.rollback();
				throw e;
			}

		} catch (Exception e) {
			throw new SQLException(e);
		}

	}

	@Override
	public Utilisateur login(String identifiant, String motDePasse) throws Exception {
		Utilisateur utilisateur = null;

		try (Connection cnx = ConnectionProvider.connection()) {
			try {
				cnx.setAutoCommit(false);
				PreparedStatement stm = cnx.prepareStatement(LOGIN_REQ);

				stm.setString(1, identifiant);
				stm.setString(2, motDePasse);
				stm.setString(3, identifiant);
				stm.setString(4, motDePasse);

				ResultSet rs = stm.executeQuery();

				if (rs.next()) {
					utilisateur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
							rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),
							rs.getString("telephone"), rs.getString("rue"), rs.getString("code_postal"),
							rs.getString("ville"), rs.getInt("credit"), rs.getBoolean("administrateur"));
				}
				stm.close();
				cnx.commit();
			} catch (Exception e) {
				cnx.rollback();
				throw e;
			}

		} catch (SQLException e) {
			throw new SQLException(e);
		}

		return utilisateur;
	}

	@Override
	public Utilisateur getUserById(int id) {
		Utilisateur utilisateur = null;

		try (Connection cnx = ConnectionProvider.connection()) {
			try {
				PreparedStatement pstmt;
				pstmt = cnx.prepareStatement(GET_USER_BY_ID);
				pstmt.setInt(1, id);
				ResultSet rs = pstmt.executeQuery();

				if (rs.next()) {
					utilisateur = new Utilisateur(rs.getInt("no_utilisateur"), rs.getString("pseudo"),
							rs.getString("nom"), rs.getString("prenom"), rs.getString("email"),
							rs.getString("telephone"), rs.getString("rue"), rs.getString("code_postal"),
							rs.getString("ville"), rs.getInt("credit"), rs.getBoolean("administrateur"));
				}

			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return utilisateur;
	}

	@Override
	public void nouveauSolde(Utilisateur user) throws SQLException {
		
		try (Connection cnx = ConnectionProvider.connection()) {
			try {

				cnx.setAutoCommit(false);
				PreparedStatement pstmt;
				pstmt = cnx.prepareStatement(NOUVEAU_SOLDE);
				pstmt.setInt(1, user.getCredit());
				pstmt.setInt(2, user.getNoUtilisateur());
				

				pstmt.executeUpdate();
				pstmt.close();
				cnx.commit();

			} catch (Exception e) {
				e.printStackTrace();
				cnx.rollback();
				throw e;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
