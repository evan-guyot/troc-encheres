package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.ArticleManager;
import fr.eni.trocenchere.bll.CategorieManager;
import fr.eni.trocenchere.bll.UtilisateurManager;
import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Categorie;
import fr.eni.trocenchere.bo.Utilisateur;


@WebServlet("/PanelAdministration")
public class PanelAdministration extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private CategorieManager categorieManager;
	 private ArticleManager articleManager;
	 private UtilisateurManager utilisateurManager;
	 private List<Utilisateur> listUtilisateur;
	 private List<Categorie> listCategorie;
	 private List<Article> articlesIdCateg;
	 private List<Utilisateur> listUtilisateurSupprimable;
   
    public PanelAdministration() {
    	 utilisateurManager = UtilisateurManager.getInstance();
    	 categorieManager = CategorieManager.getInstance();
    	 articleManager = ArticleManager.getInstance();
    	 
    	
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		listUtilisateurSupprimable = utilisateurManager.selectAllUserPotentialDeletable();
		listCategorie = categorieManager.getCategories();
		listUtilisateur = utilisateurManager.selectAllUser();
		request.setAttribute("utilisateurs", listUtilisateur);
		request.setAttribute("categories", listCategorie);
		request.setAttribute("utilisateursSupprimable", listUtilisateurSupprimable);
		request.getRequestDispatcher("/WEB-INF/jsp/PanelAdministration.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String formName = request.getParameter("formName");
		 String modifierButton = request.getParameter("modifier");
		 String supprimerButton = request.getParameter("supprimer");
		 String supprimerButtonUser = request.getParameter("supprimerUser");
		 
		 String libelleCateg = null;
		 int idCateg = 0;
		 if(request.getParameter("nomCateg") != null) {
			 libelleCateg = request.getParameter("nomCateg");
		 }
		 if(request.getParameter("idCateg") != null) {
			 idCateg = Integer.parseInt(request.getParameter("idCateg"));
		 }
		 
		 Categorie categorie = new Categorie(idCateg, libelleCateg);
			 
		 
		    if (formName != null) 
		    {
		        if (formName.equals("ajoutCateg")) 
		        {
					String nouvelleCateg = request.getParameter("newCateg");
					categorieManager.insertCategorie(nouvelleCateg);
		        	
		        } else if (formName.equals("supprCateg")) 
		        {
		        	 if (modifierButton != null) 
		        	 {
		        		
		        		 categorieManager.updateLibelleCateg(categorie);
		        	 } else if (supprimerButton != null) 
		        	 {
		        		
		 		    	//recup liste article lié a la categ
		 	        	
		 	        	articlesIdCateg = categorieManager.selectAllArticleByIdCateg(idCateg);
		 	        	//change les articles de categ pour les mettres en autre
		 	        	for(Article article : articlesIdCateg) 
		 	        	{
		 	        		articleManager.changeForeignKeyArtiCate(article.getNoArticle());
		 	        	}
		 	        	//supprime la categ
		 	        	categorieManager.deleteCategById(idCateg);
		 		    }
		        } else if (formName.equals("supprUser")) 
		        {
		        	if (supprimerButtonUser != null) 
		        	 {
		        		
		        		utilisateurManager.deleteUserById(Integer.parseInt(request.getParameter("idUserASupprimer")));
			        	System.out.println("suppr user");
		        	 }
		        	
		        }
		    }
		   
	doGet(request, response);
	}

}
