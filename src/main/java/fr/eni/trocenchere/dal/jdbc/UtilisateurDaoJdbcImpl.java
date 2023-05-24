package fr.eni.trocenchere.dal.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import fr.eni.trocenchere.dal.ConnectionProvider;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.dal.UtilisateurDAO;

public class UtilisateurDaoJdbcImpl implements UtilisateurDAO {

	private static final String LOGIN_REQ = "SELECT * from UTILISATEURS where (pseudo = ? and mot_de_passe = ?) or (email = ? and mot_de_passe = ?)";
	private static final String NEW_PROFILE_REQ = "INSERT into UTILISATEURS values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String VERIF_EMAIL = "select * from UTILISATEURS where email = ?";
	private static final String VERIF_PSEUDO = "select * from UTILISATEURS where pseudo = ?";
	private static final String SELECT_ALL_USER ="select * from UTILISATEURS";
	private static final String SELECT_ALL_POTENTIAL_DELETED_USER = "select DISTINCT u.* from UTILISATEURS u, ARTICLES_VENDUS a, ENCHERES e WHERE u.no_utilisateur not in (select av.no_utilisateur from ARTICLES_VENDUS av) AND u.no_utilisateur not in (select ee.no_utilisateur from ENCHERES ee)";
	private static final String NOUVEAU_SOLDE = "UPDATE UTILISATEURS SET credit = ? WHERE no_utilisateur = ?";

	private static final String GET_USER_BY_ID = "SELECT * from UTILISATEURS where no_utilisateur=?";
    private static final String UPDATE_USER_BY_ID = "UPDATE UTILISATEURS SET pseudo=?, nom=?, prenom=?, email=?, telephone=?, rue=?, code_postal=?, ville=?, mot_de_passe=? , actif=? WHERE no_utilisateur=?";
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
                pstmt.setBoolean(11, false);
                pstmt.setBoolean(12, true);

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
            pstmt.setBoolean(10, utilisateur.isActif());
            pstmt.setInt(11, id);

            pstmt.executeUpdate();
            pstmt.close();
            cnx.commit();

            return getUserById(id);
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
							rs.getString("ville"), rs.getInt("credit"), rs.getBoolean("administrateur"),rs.getBoolean("actif"));
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
							rs.getString("ville"), rs.getInt("credit"), rs.getBoolean("administrateur"),rs.getBoolean("actif"));
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
					utilisateur = new Utilisateur(
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
                            rs.getBoolean("administrateur"));
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
							rs.getString("ville"), rs.getString("mot_de_passe"),
    						rs.getInt("credit"),
    						rs.getBoolean("administrateur"),rs.getBoolean("actif")
    						);
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

	public void deleteUserById(int id) throws Exception {
		
			try (Connection cnx = ConnectionProvider.connection(); PreparedStatement stm = cnx.prepareStatement(DELETE_USER_BY_ID)) 
			{
			    stm.setInt(1, id);
			    stm.executeUpdate();
			} catch (Exception e) 
			{
			    e.printStackTrace();
			    
			    throw e;
			}
		
	}
	
	
	public Boolean deleteUserByIdWithPassword(String password, int id) throws SQLException {
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
                	pstmtDelete.executeUpdate();
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

	@Override
	public List<Utilisateur> selectAllUser() throws SQLException {
	    List<Utilisateur> utilisateurs = new ArrayList<>();

	    try (Connection cnx = ConnectionProvider.connection();
	         Statement stmt = cnx.createStatement();
	         ResultSet rs = stmt.executeQuery(SELECT_ALL_USER)) {

	        while (rs.next()) {
	            Utilisateur utilisateur = new Utilisateur(
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
	                    rs.getBoolean("administrateur"),
	                    rs.getBoolean("actif")
	            );

	            utilisateurs.add(utilisateur);
	        }
	    } catch (Exception e) {
			
			e.printStackTrace();
		}

	    return utilisateurs;
	}

	@Override
	public List<Utilisateur> selectAllUserPotentialDeleted() throws SQLException {
	    List<Utilisateur> utilisateurs = new ArrayList<>();

	    try (Connection cnx = ConnectionProvider.connection();
	         Statement stmt = cnx.createStatement();
	         ResultSet rs = stmt.executeQuery(SELECT_ALL_POTENTIAL_DELETED_USER)) {

	        while (rs.next()) {
	            Utilisateur utilisateur = new Utilisateur(
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
	                    rs.getBoolean("administrateur"),
	                    rs.getBoolean("actif")
	            );

	            utilisateurs.add(utilisateur);
	        }
	    } catch (Exception e) {
			
			e.printStackTrace();
		}

	    return utilisateurs;
	}


}
