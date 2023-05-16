package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.util.ArrayList;
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArticleManager articleManager = ArticleManager.getInstance();
        List<Article> listArticles = articleManager.getArticles();
        request.setAttribute("articles", listArticles);
        request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        System.out.println("=====================> TOTO");
        doGet(request, response);
    }

}
