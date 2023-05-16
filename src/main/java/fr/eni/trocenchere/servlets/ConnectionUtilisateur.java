package fr.eni.trocenchere.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.UtilisateurManager;
import fr.eni.trocenchere.bo.Utilisateur;

/**
 * Servlet implementation class ConnectionUtilisateur
 */
@WebServlet("/ConnectionUtilisateur")
public class ConnectionUtilisateur extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UtilisateurManager utilisateurManager;


    public ConnectionUtilisateur() {
        super();
        utilisateurManager = UtilisateurManager.getInstance();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Utilisateur utilisateur = null;

		System.out.println(request.getParameter("identifiant"));
		System.out.println(request.getParameter("motDePasse"));

		try {
			utilisateur = utilisateurManager.connecterUtilisateur(request.getParameter("identifiant"), request.getParameter("motDePasse"));
		} catch (Exception e) {
			
			e.printStackTrace();
		}

		if(utilisateur != null) {
			System.out.println(utilisateur.toString());			
		}
		else {
			System.out.println("informations invalides");
		}
		doGet(request, response);
	}

}
