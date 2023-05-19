package fr.eni.trocenchere.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.ArticleManager;
import fr.eni.trocenchere.bo.Article;


@WebServlet("/Encherir")
public class Encherir extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static ArticleManager articleManager;
	private static Article articleCourrant;
	
	
	public Encherir(){
        articleManager = ArticleManager.getInstance();
    }
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int articleId = Integer.parseInt(request.getParameter("id"));
		articleCourrant = articleManager.getArticleById(articleId);
		request.setAttribute("articleCourrant", articleCourrant);
		System.out.println("DEBUT TEST");
		System.out.println(articleId);
		System.out.println(articleCourrant.getCategorie());
		request.getRequestDispatcher("EncherirPage.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
