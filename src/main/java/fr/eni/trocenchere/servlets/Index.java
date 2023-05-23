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
import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Categorie;

/**
 * Servlet implementation class Index
 */
@WebServlet("/")
public class Index extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ArticleManager articleManager;
    private CategorieManager categorieManager;
    private List<Article> listArticles;
    private List<Categorie> listCategories;
    private int paramCategorie;
    private String paramNomArticle;

    public Index(){
        super();
        articleManager = ArticleManager.getInstance();
        categorieManager = CategorieManager.getInstance();
        paramCategorie = 0;
        paramNomArticle = null;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
    	listArticles = articleManager.getArticles(paramCategorie,paramNomArticle);
    	request.setAttribute("articles", listArticles);
    	
    	listCategories = categorieManager.getCategories();
    	request.setAttribute("categories", listCategories);
    	
    	request.setAttribute("filtreCategorie", paramCategorie);
    	request.setAttribute("filtreArticle", paramNomArticle);    	

        
		if (request.getSession().getAttribute("connectedUserId") == null) {

			request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
		} else {
			
			request.getRequestDispatcher("/WEB-INF/jsp/indexConnected.jsp").forward(request, response);
		}        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	paramCategorie = Integer.parseInt(request.getParameter("filtreCategorie"));
    	paramNomArticle = request.getParameter("filtreArticle");
    	    	
        doGet(request, response);
    }

}
