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

/**
 * Servlet implementation class Index
 */
@WebServlet("/")
public class Index extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ArticleManager articleManager;
    private CategorieManager categorieManager;
    private UtilisateurManager utilisateurManager;
    private List<Article> listArticles;
    private List<Categorie> listCategories;
    private int paramCategorie;
    private String paramNomArticle;

    public Index() {
        super();
        utilisateurManager = UtilisateurManager.getInstance();
        articleManager = ArticleManager.getInstance();
        categorieManager = CategorieManager.getInstance();
        paramCategorie = 0;
        paramNomArticle = null;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String basisRadioFilterParameter = null;
    	if((String) request.getAttribute("radioFilterParameter") == null) {
    		basisRadioFilterParameter = "enchere_ouvertes";
    		request.setAttribute("radioFilterParameter", basisRadioFilterParameter);	
    	} else {
    		basisRadioFilterParameter = (String) request.getAttribute("radioFilterParameter");
    	}

        listArticles = articleManager.getArticles(paramCategorie, paramNomArticle, basisRadioFilterParameter, (Integer) request.getSession().getAttribute("connectedUserId"));
        listCategories = categorieManager.getCategories();

    	request.setAttribute("filtreCategorie", paramCategorie);
		request.setAttribute("filtreArticle", paramNomArticle);

        request.setAttribute("categories", listCategories);
        request.setAttribute("articles", listArticles);

        if (request.getSession().getAttribute("connectedUserId") == null) {
            request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
        } else {
            Utilisateur utilisateur = utilisateurManager.getUserById((int) request.getSession().getAttribute("connectedUserId"));
			request.setAttribute("utilisateur", utilisateur);
			request.getRequestDispatcher("/WEB-INF/jsp/indexConnected.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        paramCategorie = Integer.parseInt(request.getParameter("filtreCategorie"));
        paramNomArticle = request.getParameter("filtreArticle");

        request.setAttribute("radioFilterParameter", request.getParameter("paramFilter"));
    	request.setAttribute("selectFilterParameter", "1".equals(request.getParameter("select")));

    	doGet(request, response);
    }

}
