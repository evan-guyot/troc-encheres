package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.ArticleManager;

/**
 * Servlet implementation class AnnulerVente
 */
@WebServlet("/AnnulerVente")
public class AnnulerVente extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ArticleManager articleManager;

    public AnnulerVente() {
        super();
        articleManager = ArticleManager.getInstance();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect(request.getContextPath()+"/");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		articleManager.deleteArticleById(Integer.parseInt(request.getParameter("articleId")));
		
		doGet(request, response);
	}
}
