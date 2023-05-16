package fr.eni.trocenchere.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import fr.eni.trocenchere.bo.Utilisateur;
import fr.eni.trocenchere.bll.UtilisateurManager;




@WebServlet("/CreationProfileServlet")
public class CreationProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		UtilisateurManager utilisateurManager = new UtilisateurManager();
		
		
		try {
			Utilisateur nouveauProfile = new Utilisateur(
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
				System.out.println("TEST");
				utilisateurManager.creationProfile(nouveauProfile);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}