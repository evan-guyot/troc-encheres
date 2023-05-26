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
	private static UtilisateurManager utilisateurManager;
	private static Article articleCourrant;
	private static Enchere enchereModifier;

	public Encherir() {
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
		
		request.setAttribute("messageErreur", request.getAttribute("messageErreur"));

		request.getRequestDispatcher("/WEB-INF/jsp/EncherirPage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int noArticle = Integer.parseInt(request.getParameter("noArticle"));
		Article articleCourrantPost = articleManager.getArticleById(noArticle);
		int nouveauMontant = Integer.parseInt(request.getParameter("nouveauMontant"));
		int idUser = (int) request.getSession().getAttribute("connectedUserId");
		Utilisateur acheteur = utilisateurManager.getUserById(idUser);
		LocalDateTime nouvelleDateEnchere = LocalDateTime.now();
		StringBuilder stringBuilder = new StringBuilder();

		
		if((articleCourrantPost.getEnchere()!=null && articleCourrantPost.getEnchere().getMontantEnchere() < nouveauMontant) ||  (articleCourrantPost.getEnchere()==null && articleCourrantPost.getMiseAPrix()< nouveauMontant)) 
		{
			if( articleCourrantPost.getUtilisateur().getNoUtilisateur() != idUser) 
			{				
				if(acheteur.getCredit() >= nouveauMontant) 
				{
					//Crediter et Debiter
					//Debiter nouveau enchérisseur
					acheteur.setCredit(acheteur.getCredit() - nouveauMontant);
					utilisateurManager.nouveauSolde(acheteur);
					//crediter dernier enchérisseur si c'est pas le vendeur
					if(articleCourrantPost.getEnchere() != null) {
					articleCourrantPost.getUtilisateur().setCredit(articleCourrantPost.getUtilisateur().getCredit() + articleCourrantPost.getEnchere().getMontantEnchere());
					utilisateurManager.nouveauSolde(articleCourrantPost.getUtilisateur());
					}
					
					
					
				
					
					//Insert enchere
					enchereModifier = new Enchere(nouvelleDateEnchere, nouveauMontant, acheteur);
					enchereManager.InsertEnchere(enchereModifier, noArticle);
					
				}else {
					stringBuilder.append(" Vous n'avez pas assez de crédit ");
				}
			}else {
				stringBuilder.append(" Le créateur d'une enchère ne peux pas y participer ");
			}
		}else {
			stringBuilder.append(" Vous ne pouvez pas enchérir sous " + articleCourrantPost.getEnchere().getMontantEnchere() + "Créditss");
		}
		String messageErreur = stringBuilder.toString();
		request.setAttribute("messageErreur", messageErreur);
		request.setAttribute("numArticle", noArticle);
		doGet(request, response);
		
	}

}
