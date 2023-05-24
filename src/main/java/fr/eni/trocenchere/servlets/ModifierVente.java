package fr.eni.trocenchere.servlets;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fr.eni.trocenchere.bll.ArticleManager;
import fr.eni.trocenchere.bll.CategorieManager;
import fr.eni.trocenchere.bll.UtilisateurManager;
import fr.eni.trocenchere.bo.Article;
import fr.eni.trocenchere.bo.Retrait;

@WebServlet("/ModifierVente")
public class ModifierVente extends HttpServlet {
	private static final long serialVersionUID = 1L;
	ArticleManager articleManager;
	CategorieManager categorieManager;
	UtilisateurManager utilisateurManager;
	private String erreursFormulaire;
	private String validationMessage;

	public ModifierVente() {
		super();
		articleManager = ArticleManager.getInstance();
		categorieManager = CategorieManager.getInstance();
		utilisateurManager = UtilisateurManager.getInstance();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {

			if (request.getParameter("id") != null && request.getSession().getAttribute("connectedUserId") != null) {
				int idArticle = Integer.parseInt(request.getParameter("id"));
				int currentUserId = (int) request.getSession().getAttribute("connectedUserId");
				Article article = articleManager.getArticleById(idArticle);

				if (article.getUtilisateur().getNoUtilisateur() == currentUserId) {
					if (article.getDateDebutEnchere().isAfter(LocalDate.now())) {
						if (erreursFormulaire != null) {
							request.setAttribute("erreursFormulaire", erreursFormulaire);
							erreursFormulaire = null;
						}
						if (validationMessage != null) {
							request.setAttribute("validationMessage", validationMessage);
							validationMessage = null;
						}
						request.setAttribute("currentUser", utilisateurManager.getUserById(currentUserId));
						request.setAttribute("categories", categorieManager.getCategories());
						request.setAttribute("article", articleManager.getArticleById(idArticle));

						request.getRequestDispatcher("/WEB-INF/jsp/VenteArticle.jsp").forward(request, response);
					} else {
						throw new Exception("L'enchère à déjà commencée");
					}
				} else {
					throw new Exception("L'utilisateur connecté n'est pas le vendeur");
				}
			} else {
				throw new Exception("Paramètre absent ou utilisateur non connecté");
			}
		} catch (Exception e) {
			response.sendRedirect(request.getContextPath() + "/");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		StringBuilder sbErreurs = new StringBuilder();
		LocalDate dateDebEnchere;
		LocalDate dateFinEnchere;

		if (request.getParameter("dateDebEnchere").length() == 0) {
			sbErreurs.append("La date de début d'enchères est invalide.<br />");
			dateDebEnchere = LocalDate.now();
		} else {
			dateDebEnchere = LocalDate.parse(request.getParameter("dateDebEnchere"));
		}
		if (request.getParameter("dateFinEnchere").length() == 0) {
			sbErreurs.append("La date de fin d'enchères est invalide.<br />");
			dateFinEnchere = LocalDate.now();
		} else {
			dateFinEnchere = LocalDate.parse(request.getParameter("dateFinEnchere"));
		}

		Retrait retraitArticle = new Retrait((String) request.getParameter("rueRetrait"),
				(String) request.getParameter("codePostalRetrait"), (String) request.getParameter("villeRetrait"));
		Article nouvelArticle = new Article(Integer.parseInt(request.getParameter("articleId")),
				(String) request.getParameter("articleNom"), (String) request.getParameter("articleDescription"),
				dateDebEnchere, dateFinEnchere, Integer.parseInt(request.getParameter("miseAPrixArticle")),
				Integer.parseInt(request.getParameter("miseAPrixArticle")), false, null, null, null, retraitArticle);

		sbErreurs.append(nouvelArticle.isValid().toString());

		if (sbErreurs.length() == 0) {
			articleManager.updateArticle(nouvelArticle, Integer.parseInt(request.getParameter("articleCategorie")));
			validationMessage = "🎉 Votre article à bien été modifié ! 🎉";
		} else {
			erreursFormulaire = sbErreurs.toString();
		}

		response.sendRedirect(request.getContextPath() + "/ModifierVente?id=" + nouvelArticle.getNoArticle());

	}
}
