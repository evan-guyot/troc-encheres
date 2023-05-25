package fr.eni.trocenchere.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.ArticleManager;
import fr.eni.trocenchere.bll.EnchereManager;
import fr.eni.trocenchere.bll.UtilisateurManager;
import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Enchere;
import fr.eni.trocenchere.bo.Utilisateur;


@WebServlet("/FinEnchere")
public class FinEnchere extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static ArticleManager articleManager;
	private static EnchereManager enchereManager;
	private static UtilisateurManager utilisateurManager;
	private static Article articleCourrant;
	private static Enchere enchereModifier;

	public FinEnchere() {
		articleManager = ArticleManager.getInstance();
		enchereManager = EnchereManager.getInstance();
		utilisateurManager = UtilisateurManager.getInstance();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		int utilisateurID = (int)request.getSession().getAttribute("connectedUserId");
		Utilisateur utilisateur = utilisateurManager.getUserById(utilisateurID);
		request.setAttribute("utilisateur", utilisateur);

		int articleId;
		if (request.getParameter("id") == null) {
			articleId = (int) request.getAttribute("numArticle");
		} else {
			articleId = Integer.parseInt(request.getParameter("id"));
		}

		articleCourrant = articleManager.getArticleById(articleId);
		
		request.setAttribute("articleCourrant", articleCourrant);
		if(articleCourrant.getRetrait().getCollecte())
		{
			request.setAttribute("collectee", true);
		}
		else {
			request.setAttribute("collectee", false);
		}

		request.getRequestDispatcher("/WEB-INF/jsp/FinEnchere.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int idart = Integer.parseInt(request.getParameter("idArticleForCollecte")) ;
		articleManager.updateCollectedRetrait(idart);
		Article articleCourrantPost = articleManager.getArticleById(idart);
		
		articleCourrantPost.getUtilisateur().setCredit(articleCourrantPost.getUtilisateur().getCredit() + articleCourrantPost.getEnchere().getMontantEnchere());
		utilisateurManager.nouveauSolde(articleCourrantPost.getUtilisateur());
		response.sendRedirect(request.getContextPath()+"/");
	}

}
