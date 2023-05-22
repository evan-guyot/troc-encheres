package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.CategorieManager;
import fr.eni.trocenchere.bll.UtilisateurManager;
import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Retrait;

/**
 * Servlet implementation class VendreArticle
 */
@WebServlet("/VendreArticle")
public class VendreArticle extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UtilisateurManager utilisateurManager;
	private CategorieManager categorieManager;

	
	public VendreArticle() {
		super();
		utilisateurManager = UtilisateurManager.getInstance();
		categorieManager = CategorieManager.getInstance();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getSession().getAttribute("connectedUserId") != null) {
			request.setAttribute("currentUser",
					utilisateurManager.getUserById((int) request.getSession().getAttribute("connectedUserId")));
			request.setAttribute("categories", categorieManager.getCategories());
			
			if(request.getAttribute("erreursFormulaire")!=null) {
				request.setAttribute("erreursFormulaire", request.getAttribute("erreursFormulaire"));
			}
			
			request.getRequestDispatcher("/WEB-INF/jsp/VenteArticle.jsp").forward(request, response);
		} else {
			response.sendRedirect(request.getContextPath() + "/");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuilder sbErreurs = new StringBuilder();
		LocalDate dateDebEnchere;
		LocalDate dateFinEnchere;

		if(request.getParameter("dateDebEnchere").length() == 0) {
			sbErreurs.append("La date de début d'enchères est invalide.<br />");
			dateDebEnchere = LocalDate.now();
		}
		else {
			dateDebEnchere = LocalDate.parse(request.getParameter("dateDebEnchere"));
		}
		if(request.getParameter("dateFinEnchere").length() == 0) {
			sbErreurs.append("La date de fin d'enchères est invalide.<br />");
			dateFinEnchere = LocalDate.now();
		}
		else {
			dateFinEnchere = LocalDate.parse(request.getParameter("dateFinEnchere"));
		}
		
		Retrait retraitArticle = 
				new Retrait(
					(String) request.getParameter("rueRetrait"), 
					(String) request.getParameter("codePostalRetrait"), 
					(String) request.getParameter("villeRetrait"));
		Article nouvelArticle = 
				new Article(
					(String) request.getParameter("articleNom"), 
					(String) request.getParameter("articleDescription"), 
					dateDebEnchere, 
					dateFinEnchere, 
					Integer.parseInt(request.getParameter("miseAPrixArticle")), 
					Integer.parseInt(request.getParameter("miseAPrixArticle")), 
					false, 
					utilisateurManager.getUserById((int) request.getSession().getAttribute("connectedUserId")),
					categorieManager.getCategorieById(Integer.parseInt(request.getParameter("articleCategorie"))), 
					null, 
					retraitArticle);
		
		sbErreurs.append(nouvelArticle.isValid().toString());
		
		if(sbErreurs.length() == 0) {
			response.sendRedirect(request.getContextPath() + "/");
		}else {
			request.setAttribute("erreursFormulaire",sbErreurs.toString());
			doGet(request, response);
		}
	}
}
