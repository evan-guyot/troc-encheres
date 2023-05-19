package fr.eni.trocenchere.servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RequestDispatcher requestDispatcher;

		if (request.getSession().getAttribute("connectedUserId") == null) {
			request.getRequestDispatcher("/WEB-INF/jsp/Connection.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath()+"/");
		}

	}

	protected void redirectWithError(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("erreur", true);

		request.getRequestDispatcher("/WEB-INF/jsp/Connection.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute("connectedUserId") == null) {
			Utilisateur utilisateur = null;
			
			try {
				utilisateur = utilisateurManager.connecterUtilisateur(request.getParameter("identifiant"),
						request.getParameter("motDePasse"));
				
			} catch (Exception e) {
				e.printStackTrace();
			}

			if (utilisateur != null) {
				session.setAttribute("connectedUserId", utilisateur.getNoUtilisateur());
			} else {
				redirectWithError(request, response);
			}
			doGet(request, response);
		}
	}
}
