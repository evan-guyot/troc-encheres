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
 * Servlet implementation class ShowUser
 */
@WebServlet("/utilisateur")
public class ShowUser extends HttpServlet {
    private static UtilisateurManager utilisateurManager;
    Boolean hasBeenUpdated = false;


    public ShowUser(){
        super();
        utilisateurManager = UtilisateurManager.getInstance();
    }
	
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int utilisateurID = Integer.parseInt(request.getParameter("id"));
		Utilisateur utilisateur = utilisateurManager.getUserById(utilisateurID);
		hasBeenUpdated = false;
		request.setAttribute("utilisateur", utilisateur);

		if (request.getSession().getAttribute("connectedUserId") == null) {
			request.getRequestDispatcher("/WEB-INF/jsp/user.jsp").forward(request, response);
		} else {
			request.getRequestDispatcher("/WEB-INF/jsp/userConnected.jsp").forward(request, response);
		}
		request.setAttribute("hasBeenUpdated", hasBeenUpdated);
		request.getRequestDispatcher("/WEB-INF/jsp/user.jsp").forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int utilisateurID = Integer.parseInt(request.getParameter("id"));
		Boolean passwordChanges = request.getParameter("mdp").isBlank() || request.getParameter("mdp").isEmpty();
		Utilisateur updateProfile;

		try {
			if(!passwordChanges) {
				updateProfile = new Utilisateur(
					utilisateurID,
					request.getParameter("pseudo"),
					request.getParameter("nom"),
					request.getParameter("prenom"),
					request.getParameter("mail"),
					request.getParameter("tel"),
					request.getParameter("rue"),
					request.getParameter("codepostal"),
					request.getParameter("ville"),
					request.getParameter("mdp")
					);
			} else {
				updateProfile = new Utilisateur(
					utilisateurID,
					request.getParameter("pseudo"),
					request.getParameter("nom"),
					request.getParameter("prenom"),
					request.getParameter("mail"),
					request.getParameter("tel"),
					request.getParameter("rue"),
					request.getParameter("codepostal"),
					request.getParameter("ville")
					);
			}
			
			Utilisateur updatedProfile = utilisateurManager.updateUserById(updateProfile, utilisateurID);
			if(!passwordChanges) {
				response.sendRedirect(request.getContextPath()+"/DeconnectionUtilisateur");
			} else {
				hasBeenUpdated = true;
				request.setAttribute("utilisateur", updatedProfile);
				request.setAttribute("hasBeenUpdated", hasBeenUpdated);
				request.getRequestDispatcher("/WEB-INF/jsp/user.jsp").forward(request, response);
			}

		} catch (Exception e) {
			e.printStackTrace();
			hasBeenUpdated = false;
			request.setAttribute("hasBeenUpdated", hasBeenUpdated);
			request.getRequestDispatcher("/WEB-INF/jsp/user.jsp").forward(request, response);
		}
		
	}

}
