<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Article"%>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Enchere"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%
    Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
    Boolean hasBeenUpdated = (Boolean) request.getAttribute("hasBeenUpdated");
    Integer idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
    Article article = (Article) request.getAttribute("articleCourrant");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="utilisateur" scope="session" value="${utilisateur}"/>
<c:set var="article" scope="session" value="${articleCourrant}"/>
<c:set var="connectedUserId" scope="session" value="${connectedUserId}"/>
<c:set var="messageErreur" scope="session" value="${messageErreur}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-5">
	            <h1>
	                <a class="text-secondary text-decoration-none" href="<%=request.getContextPath() + "/"%>">
	                    ENI - Encheres
	                </a>
	            </h1>
	        </div>
	        <div class="col-7">
		        <div class="mt-2 float-right">
		        	 <%
						if (utilisateur.isAdministrateur()) {
					%>
						<a href="PanelAdministration" class="btn btn-warning "
							role="button" aria-pressed="true" style="color:white!important;background-color:orange">Administration</a>
					<%
						}
					%>
					<a class="btn btn-success"  role="button" aria-pressed="true"  href="VendreArticle">Vendre un article</a>
		            <a href="utilisateur?id=<c:out value="${connectedUserId}" />" class="btn btn-primary" role="button" aria-pressed="true">
		            	Voir mon profil
		           	</a>
		            <a href="DeconnectionUtilisateur" class=" btn btn-secondary" role="button" aria-pressed="true">
		               Se déconnecter
		            </a>
		        </div>
			</div>
			<div class="col-12">
	            <h2 class="text-center">Enchérir</h2>
	        </div>
		</div>
		<form class="row mb-2" method="post" action="Encherir">
		<div class="col-md-8 mx-auto">
			<div
				class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col-auto d-none d-lg-block">
					<img class="tailleImage" src="https://picsum.photos/200/200"
						alt="Card image cap">
				</div>
				<div class="col py-4 d-flex flex-column position-static">
					<h3 class="mb-3">
						Détail de vente pour : <c:out value="${article.getNom()}" />
					</h3>

					<div class="dpf">
						<div class="bold">Description:</div>
						<p class="card-text"><c:out value="${article.getDescription()}" /></p>
					</div>
					<div class="dpf">
						<div class="bold">Catégorie:</div>
						<p class="card-text"><c:out value="${article.getCategorie().getLibelle()}" /></p>
					</div>
					<div class="dpf">
						<div class="bold">Meilleure offre:</div>
						<c:choose>
							<c:when test="${article.getEnchere() != null}">
								<p class="card-text">
									<span style="color: blue; font-weight: 500;">
										<c:out value="${article.getEnchere().getMontantEnchere()}" />
									</span>
									<span>
										Pokédolar par
									</span>
									<span>
										<c:out value="${article.getEnchere().getUtilisateur().getPseudo()}" />
									</span>
								</p>
							</c:when>
							<c:otherwise>
								<p class="card-text">Pas d'enchère faite à cette heure</p>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="dpf">
						<div class="bold">Mise à prix:</div>
						<p class="card-text">
							<c:out value="${article.getMiseAPrix()}" />
						</p>
					</div>
					<div class="dpf">
						<div class="bold">Fin de l'enchère:</div>
						<p class="card-text">
							<c:out value="${article.getDateFinEnchere()}" />
						</p>
					</div>
					<div class="dpf">
						<div class="bold">Retrait:</div>
						<p class="card-text">
							<c:out value="${article.getRetrait().getRue()}" />
							<c:out value="${article.getRetrait().getCodePostal()}" />
							<c:out value="${article.getRetrait().getVille()}" />
						</p>
					</div>
					<div class="dpf">
						<div class="bold">Vendeur:</div>
						<a href="<%=request.getContextPath() + "/utilisateur?id=" + article.getUtilisateur().getNoUtilisateur()%>">
							<span>
								<c:out value="${article.getUtilisateur().getPseudo()}" />
							</span>
						</a>
					</div>

					<c:if test="${connectedUserId != null && connectedUserId != article.getUtilisateur().getNoUtilisateur()}">
						<div class="dpf">
							<div class="bold">Ma proposition:</div>
							<input type="number" class="form-control inputNumber" id="number" name="nouveauMontant"
								   aria-describedby="number"
								   value="<c:out value="${article.getEnchere()!= null ? article.getEnchere().getMontantEnchere() : article.getMiseAPrix()}" />" />
						</div>
					</c:if>

					<c:if test="${messageErreur != null}">
						<p class="messageErr card-text"><c:out value="${messageErreur.toString()}" /></p>
					</c:if>

					<div class="btnn">
						<input type="hidden" name="noArticle" value="<c:out value="${article.getNoArticle()}" />" />
						<c:if test="${connectedUserId != null && connectedUserId != article.getUtilisateur().getNoUtilisateur()}">
							<input type="submit" class="btn btn-light" value="Encherir" />
						</c:if>
						<a href="<%=request.getContextPath() + "/"%>" class="btn btn-light">Retour</a>
					</div>
				</div>
			</div>
		</div>
	</form>
	</div>
</body>
<style>
.dpf {
	display: flex;
	gap: 10px;
}

.btnn {
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	align-items: center;
	margin-top: 20px;
}

.bold {
	font-weight: bold;
}

.messageErr {
	font-style: italic;
	color: red;
	font-weight: 800;
}

.inputNumber {
	height: 30px;
	width: auto;
}
</style>
</html>