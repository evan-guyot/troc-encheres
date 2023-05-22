package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;

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


@WebServlet("/Encherir")
public class Encherir extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static ArticleManager articleManager;
	private static EnchereManager enchereManager;
	private static UtilisateurManager  utilisateurManager;
	private static Article articleCourrant;
	private static Enchere enchereModifier;
	
	
	public Encherir(){
        articleManager = ArticleManager.getInstance();
        enchereManager = EnchereManager.getInstance();
        utilisateurManager = UtilisateurManager.getInstance();
    }
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int articleId;
		if(request.getParameter("id") == null) {
			articleId = (int) request.getAttribute("numArticle");
		}
		else {
			articleId = Integer.parseInt(request.getParameter("id"));
		}
		
		articleCourrant = articleManager.getArticleById(articleId);
		request.setAttribute("articleCourrant", articleCourrant);

		request.getRequestDispatcher("/WEB-INF/jsp/EncherirPage.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int noArticle = Integer.parseInt(request.getParameter("noArticle"));
		Article articleCourrantPost = articleManager.getArticleById(noArticle);
		int nouveauMontant = Integer.parseInt(request.getParameter("nouveauMontant"));
		int idUser = (int) request.getSession().getAttribute("connectedUserId");
		Utilisateur acheteur = utilisateurManager.getUserById(idUser);
		LocalDateTime nouvelleDateEnchere = LocalDateTime.now();
		
		
		
		if(articleCourrantPost.getEnchere().getMontantEnchere() < nouveauMontant) 
		{
			if(acheteur.getCredit() >= nouveauMontant) 
			{
				//Crediter et Debiter
				System.out.println(articleCourrantPost.getUtilisateur().getCredit());
				acheteur.setCredit(acheteur.getCredit() - nouveauMontant);
				utilisateurManager.nouveauSolde(acheteur);
				System.out.println(articleCourrantPost.getPrixVente());
				articleCourrantPost.getUtilisateur().setCredit(articleCourrantPost.getUtilisateur().getCredit() + articleCourrantPost.getPrixVente());
				System.out.println(articleCourrantPost.getUtilisateur().getCredit());
				utilisateurManager.nouveauSolde(articleCourrantPost.getUtilisateur());
				System.out.println(articleCourrantPost.getUtilisateur().getCredit());
				
				//Insert enchere
				enchereModifier = new Enchere(nouvelleDateEnchere, nouveauMontant, acheteur);
				enchereManager.InsertEnchere(enchereModifier, noArticle);
				
			}
			
		}
		request.setAttribute("numArticle", noArticle);
		doGet(request, response);
		
	}

}
