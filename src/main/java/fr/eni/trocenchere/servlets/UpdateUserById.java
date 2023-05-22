package fr.eni.trocenchere.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.UtilisateurManager;
import fr.eni.trocenchere.bo.Utilisateur;

/**
 * Servlet implementation class DeleteUserById
 */
@WebServlet("/UpdateUserById")
public class UpdateUserById extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static UtilisateurManager utilisateurManager;

    public UpdateUserById(){
        super();
        utilisateurManager = UtilisateurManager.getInstance();
    }
		


}
