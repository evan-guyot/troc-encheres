package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.ArticleManager;
import fr.eni.trocenchere.bo.Article;

/**
 * Servlet implementation class Index
 */
@WebServlet("/")
public class Index extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static ArticleManager articleManager;

    public Index(){
        super();
        articleManager = ArticleManager.getInstance();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Article> listArticles = articleManager.getArticles();
        request.setAttribute("articles", listArticles);
        
		if (request.getSession().getAttribute("idConnectedUser") == null) {
			request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
			Integer.parseInt("20");
		} else {
			request.getRequestDispatcher("/WEB-INF/jsp/indexConnected.jsp").forward(request, response);
		}        
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
