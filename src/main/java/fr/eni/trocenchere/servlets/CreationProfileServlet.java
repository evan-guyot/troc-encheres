package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.util.regex.Pattern;

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

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if(request.getAttribute("ErrorMess") != null) 
		{
			String errorMess =  (String) request.getAttribute("ErrorMess");
			request.setAttribute("ErrorMess", errorMess);
		}
		
		request.getRequestDispatcher("/WEB-INF/jsp/NewProfile.jsp").forward(request, response);
	}

	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		UtilisateurManager utilisateurManager = new UtilisateurManager();
		
		boolean emailDejaUtilise = utilisateurManager.verifEmail(request.getParameter("mail"));
		boolean pseudoDejaUtilise = utilisateurManager.verifPseudo(request.getParameter("pseudo"));
		Utilisateur nouveauProfile = new Utilisateur(request.getParameter("pseudo"),
				request.getParameter("nom"), request.getParameter("prenom"), request.getParameter("mail"),
				request.getParameter("tel"), request.getParameter("rue"), request.getParameter("codepostal"),
				request.getParameter("ville"), request.getParameter("mdp"));
		StringBuilder validationFormulaire = nouveauProfile.isValid();
		if (emailDejaUtilise)
		{
			validationFormulaire.append("Email deja utilisé.<br />"); 
		}
		if (pseudoDejaUtilise)
		{
			validationFormulaire.append("Pseudo deja utilisé.<br />"); 
		}
		if(!request.getParameter("mdp").contains(request.getParameter("confirmMdp")))
		{
			validationFormulaire.append("Le mot de passe n'est pas le même dans confirmation.<br />"); 
		}
		if (validationFormulaire.length() < 1) {
			try {
				utilisateurManager.creationProfile(nouveauProfile);
				response.sendRedirect(request.getContextPath()+"/");
			} catch (Exception e) 
			{
				e.printStackTrace();
				response.sendRedirect("CreationProfileServlet");
			}
		}else {
			request.setAttribute("ErrorMess", validationFormulaire.toString());
			doGet(request, response);
		}
	}
}