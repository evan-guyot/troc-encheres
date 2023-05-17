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

    public ShowUser(){
        super();
        utilisateurManager = UtilisateurManager.getInstance();
    }
	
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int utilisateurID = Integer.parseInt(request.getParameter("id"));
		Utilisateur utilisateur = utilisateurManager.getUserById(utilisateurID);
		request.setAttribute("utilisateur", utilisateur);
		request.getRequestDispatcher("/WEB-INF/jsp/user.jsp").forward(request, response);
	}

}
