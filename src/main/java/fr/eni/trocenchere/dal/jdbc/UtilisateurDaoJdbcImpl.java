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

	private static final String LOGIN_REQ = "SELECT * from UTILISATEURS where (pseudo = ? and mot_de_passe = ?) or (email = ? and mot_de_passe = ?)";
	private static final String NEW_PROFILE_REQ = "INSERT into UTILISATEURS values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String VERIF_EMAIL = "select * from UTILISATEURS where email = ?";
	private static final String VERIF_PSEUDO = "select * from UTILISATEURS where pseudo = ?";
	private static final String GET_USER_BY_ID = "SELECT * from UTILISATEURS where no_utilisateur=?";
    private static final String UPDATE_USER_BY_ID = "UPDATE UTILISATEURS SET pseudo=?, nom=?, prenom=?, email=?, telephone=?, rue=?, code_postal=?, ville=?, mot_de_passe=? WHERE no_utilisateur=?";
    private static final String DELETE_USER_BY_ID = "DELETE from UTILISATEURS where no_utilisateur=?";

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

	public Utilisateur updateUserById(Utilisateur utilisateur, int id) throws SQLException{
		Utilisateur utilisateurCreated = null;

		try (Connection cnx = ConnectionProvider.connection(); PreparedStatement pstmt = cnx.prepareStatement(UPDATE_USER_BY_ID);) {
			pstmt.setString(1, utilisateur.getPseudo());
            pstmt.setString(2, utilisateur.getNom());
            pstmt.setString(3, utilisateur.getPrenom());
            pstmt.setString(4, utilisateur.getEmail());
            pstmt.setString(5, utilisateur.getTelephone());
            pstmt.setString(6, utilisateur.getRue());
            pstmt.setString(7, utilisateur.getCodePostal());
            pstmt.setString(8, utilisateur.getVille());
            pstmt.setString(9, utilisateur.getMotDePasse());
            pstmt.setInt(10, id);

            pstmt.executeUpdate();
            pstmt.close();
            cnx.commit();

            return utilisateurCreated;
        } catch (Exception e) {
            e.printStackTrace();
        }
		return utilisateurCreated;
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
	public Boolean deleteUserById(String password, int id) throws SQLException {
		Utilisateur utilisateur = null;

		try (Connection cnx = ConnectionProvider.connection();
				PreparedStatement pstmt = cnx.prepareStatement(GET_USER_BY_ID);) {
            try {
                pstmt.setInt(1, id);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    utilisateur = new Utilisateur(
						rs.getInt("no_utilisateur"),
						rs.getString("mot_de_passe"));
                } else {
                	throw new Exception("l'id utilisateur est invalide");
                }
                if(utilisateur.getMotDePasse().equals(password)) {
                	PreparedStatement pstmtDelete;
                	pstmtDelete = cnx.prepareStatement(DELETE_USER_BY_ID);
                	pstmtDelete.setInt(1, id);
                	int rsDelete = pstmtDelete.executeUpdate();
                	return true;
                } else {
                	return false;
                }

            } catch (Exception e) {
                e.printStackTrace();
                throw e;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
		return false;
	}
}
