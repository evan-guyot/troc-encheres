package fr.eni.trocenchere.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.UtilisateurManager;

/**
 * Servlet implementation class DeleteUserById
 */
@WebServlet("/DeleteUserById")
public class DeleteUserById extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static UtilisateurManager utilisateurManager;

    public DeleteUserById(){
        super();
        utilisateurManager = UtilisateurManager.getInstance();
    }
		
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Boolean isDeleted = utilisateurManager.deleteUserById(request.getParameter("passwordDelete"), Integer.parseInt(request.getParameter("userId")));
		
		/*TODO = utiliser un attribut pour afficher un message à l'uilisateur sur le status de la suppression de son compte*/
		request.setAttribute("hasBeenDeleted", isDeleted);
		if(isDeleted) {
			request.getSession().removeAttribute("connectedUserId");
			response.sendRedirect(request.getContextPath()+"/");			
		} else {
			response.sendRedirect(request.getContextPath()+"/utilisateur?id=" + request.getParameter("userId"));
		}
		
	}

}
