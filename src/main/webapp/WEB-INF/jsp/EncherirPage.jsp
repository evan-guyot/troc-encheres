<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Article"%>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Enchere"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
	<%
	Article article = (Article) request.getAttribute("articleCourrant");
	%>
	<form class="row mb-2 grandeDiv" method="post" action="Encherir">
		<div class="col-md-6">
			<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col-auto d-none d-lg-block">
					<img class="tailleImage" src="https://picsum.photos/200/300"
						alt="Card image cap">
				</div>
				<div class="col p-4 d-flex flex-column position-static">
					<h3 class="mb-3">
						Détail de vente pour :
						<%=article.getNom()%></h3>

					<div class="dpf">
						<div class="bold">Description:</div>
						<p class="card-text"><%=article.getDescription()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Catégorie:</div>
						<p class="card-text"><%=article.getCategorie().getLibelle()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Meilleure offre:</div>

						<%
						if (article.getEnchere() != null) {
						%>
						<p class="card-text">
							<span style="color: blue; font-weight: 500;"><%=article.getEnchere().getMontantEnchere()%></span>
							Pokédolar par
							<%=article.getEnchere().getUtilisateur().getPseudo()%></p>
						<%
						} else {
						%>
						<p class="card-text">Pas d'ench�re faite � cette heure</p>
						<%
						}
						%>

					</div>
					<div class="dpf">
						<div class="bold">Mise à prix:</div>
						<p class="card-text"><%=article.getMiseAPrix()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Fin de l'enchère:</div>
						<p class="card-text"><%=article.getDateFinEnchere()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Retrait:</div>
						<p class="card-text"><%=article.getRetrait().getRue()%>
							<%=article.getRetrait().getCodePostal()%>
							<%=article.getRetrait().getVille()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Vendeur:</div>
						<a
							href="<%=request.getContextPath() + "/utilisateur?id=" + article.getUtilisateur().getNoUtilisateur()%>">
							<span><%=article.getUtilisateur().getPseudo()%></span>
						</a>
					</div>
					<% if(request.getSession().getAttribute("connectedUserId") != null){ %>
					<div class="dpf">
						<div class="bold">Ma proposition:</div>
						<input type="number" class="form-control inputNumber" id="number" name="nouveauMontant"
							aria-describedby="number"
							value="<%=article.getEnchere()!= null ? article.getEnchere().getMontantEnchere() : article.getMiseAPrix()%>" />
					</div>
					<%
					}
					if (request.getAttribute("messageErreur") != null) {
					%>
					<p class="messageErr card-text"><%=request.getAttribute("messageErreur").toString()%></p>
					<%
					}
					%>
					<div class="btnn">

						<input type="hidden" name="noArticle"
							value="<%=article.getNoArticle()%>" />
							<% if(request.getSession().getAttribute("connectedUserId") != null){ %>
							<input type="submit" class="btn btn-light" value="Encherir" />
							<% } %>

							<a
							href="<%=request.getContextPath() + "/"%>" class="btn btn-light">Retour</a>
					</div>
				</div>
			</div>
	</div>
	</form>
</body>
<style>
.dpf {
	display: flex;
	gap: 10px;
}

.grandeDiv {
	display: flex;
	justify-content: center;
	margin: 50px;
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