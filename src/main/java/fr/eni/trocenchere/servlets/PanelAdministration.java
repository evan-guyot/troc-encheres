package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.UtilisateurManager;
import fr.eni.trocenchere.bo.Article;


@WebServlet("/PanelAdministration")
public class PanelAdministration extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private UtilisateurManager utilisateurManager;
	 private List<Article> listArticles;
   
    public PanelAdministration() {
    	 utilisateurManager = UtilisateurManager.getInstance();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/WEB-INF/jsp/PanelAdministration.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
