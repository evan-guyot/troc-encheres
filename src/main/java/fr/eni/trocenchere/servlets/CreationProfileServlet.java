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
		request.getRequestDispatcher("/WEB-INF/jsp/NewProfile.jsp").forward(request, response);
	}

	@SuppressWarnings("null")
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		UtilisateurManager utilisateurManager = new UtilisateurManager();
		boolean emailDejaUtilise = utilisateurManager.verifEmail(request.getParameter("mail"));
		boolean pseudoDejaUtilise = utilisateurManager.verifPseudo(request.getParameter("pseudo"));
		if (!(emailDejaUtilise || pseudoDejaUtilise) && Pattern.matches("[A-Za-z0-9]+", request.getParameter("pseudo"))
				&& (request.getParameter("mdp").contains(request.getParameter("confirmMdp")))) {
			try {
				Utilisateur nouveauProfile = new Utilisateur(request.getParameter("pseudo"),
						request.getParameter("nom"), request.getParameter("prenom"), request.getParameter("mail"),
						request.getParameter("tel"), request.getParameter("rue"), request.getParameter("codepostal"),
						request.getParameter("ville"), request.getParameter("mdp"));
				utilisateurManager.creationProfile(nouveauProfile);
				response.sendRedirect(request.getContextPath()+"/");
			} catch (Exception e) 
			{
				e.printStackTrace();
				response.sendRedirect("CreationProfileServlet");
			}
		}else {
			request.setAttribute("emailDejaPrit",true);
			request.setAttribute("pseudoDejaPrit",true);
			response.sendRedirect(request.getContextPath()+"/");
		}
	}
}