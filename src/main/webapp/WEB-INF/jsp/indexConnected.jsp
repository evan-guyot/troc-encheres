<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Article"%>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.LocalDate"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ENI - Encheres</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<%
		int idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
		Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
		int noCategorie = 0;

		if (request.getAttribute("filtreCategorie") != null) {
			noCategorie = (int) request.getAttribute("filtreCategorie");
		}

		String nomArticle = (String) request.getAttribute("filtreArticle");
		%><div class="row">

			<div class="col-6">
				<h1>
					<a class="text-secondary text-decoration-none"
						href="<%=request.getContextPath() + "/"%>">ENI - Encheres</a>
				</h1>
			</div>
			<div class="col-6">
				<%
				if (utilisateur.isAdministrateur()) {
				%>
				<a href="PanelAdministration" class="btn btn-warning "
					role="button" aria-pressed="true" style="color:white!important;background-color:orange">Administration</a>
				<%
				}
				%>
				<a class="btn btn-success"  role="button" aria-pressed="true"  href="VendreArticle">Vendre un article</a>
					<a href="utilisateur?id=<%=idConnectedUser%>" class="btn btn-primary" role="button" aria-pressed="true">Voir
					mon profil</a>
					<a href="DeconnectionUtilisateur" class="btn btn-secondary" role="button" aria-pressed="true">Se	déconnecter</a>
			</div>
			<div class="col-12">
				<h2 class="text-center">Liste des enchères</h2>
			</div>
			<div class="col-12">
				<form action="<%=request.getContextPath() + "/"%>" method="POST"
					class="mt-5">
					<div class="row">
						<div class="col-12 col-md-6">
							<div class="form-label">
								<label for="nomArticle">Filtres :</label>

							<%
							if (nomArticle != null) {
							%>
							<input type="text" name="filtreArticle" id="filtreArticle"
								placeholder="le nom de l'article contient"
								value="<%=nomArticle%>" class="w-100">

							<%
							} else {
							%>
							<input type="text" name="filtreArticle" id="filtreArticle"
								placeholder="le nom de l'article contient" class="w-100">
							<%
							}
							%>
						</div>

						<div class="form-label">
							<label for="categorie">Catégories :</label>
							<select class="w-100"
								name="filtreCategorie" id="filtreCategorie">
								<option value="0">Toutes les catégories</option>
								<%
								for (Categorie categorie : (List<Categorie>) request.getAttribute("categories")) {
									if (noCategorie == categorie.getNoCategorie()) {
								%>

								<option value="<%=categorie.getNoCategorie()%>" selected><%=categorie.getLibelle()%></option>
								<%
								} else {
								%>

								<option value="<%=categorie.getNoCategorie()%>"><%=categorie.getLibelle()%></option>
								<%
								}
								}
								%>
							</select>
						</div>

						<div class="form-label">
							<div class="row">
								<div class="col-12 col-md-6">
									<label for="age1">0 - 30</label>
									<input type="radio" id="age1" name="age" value="30">

								</div>
								<div class="col-12 col-md-6">
									<label for="age2">31 - 60</label>
									<input type="radio" id="age2" name="age" value="60">
								</div>
							</div>
						</div>

					</div>
					<div class="col-12 col-md-6">
						<button class="btn btn-primary w-100 mt-4" type="submit">Rechercher</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-12">
			<ul class="list-unstyled row">
				<%
				for (Article article : (List<Article>) request.getAttribute("articles")) {
				%>
				<li class="col-12 col-md-3">
					<div class="card">
						<img class="card-img-top" src="https://picsum.photos/200/300"
							alt="Card image cap">
						<div class="card-body">
							<h2 class="card-title fw-bold"><%=article.getNom()%>
							</h2>
							<p class="card-text"><%=article.getDescription()%>
							</p>
						</div>
						<ul class="list-group list-group-flush">
							<li class="list-group-item"><span class="fw-bold">Prix
									: </span><%
 if (article.getEnchere() != null) {
 %>									<p style="color: blue; font-weight: 500;" class="card-text">
											<%=article.getEnchere().getMontantEnchere()%></p>
<%
 } else {%>
											<p style="color: blue; font-weight: 500;" class="card-text"><%=article.getMiseAPrix()%></p><%
									}
									%></li>
							<li class="list-group-item"><span class="fw-bold">Fin
									enchères : </span><%=article.getDateFinEnchere()%></li>
							<li class="list-group-item"><span class="fw-bold">Vendeur
									: </span> <a
								href="<%=request.getContextPath() + "/utilisateur?id=" + article.getUtilisateur().getNoUtilisateur()%>">
									<span><%=article.getUtilisateur().getPseudo()%></span>
							</a></li>
						</ul>
						<div class="card-body">
							<%
								if (article.getDateFinEnchere().isAfter(LocalDate.now())) {
								%>
								<a href="Encherir?id=<%=article.getNoArticle()%>"
									class="Encherir btn btn-primary">Enchérir</a>
								<%
								} else {
								%>
								<a href="FinEnchere?id=<%=article.getNoArticle()%>"
								class="Encherir btn btn-primary">Fiche article</a>
								<%
								}
								%>

						</div>
					</div>
				</li>
				<%
				}
				%>
			</ul>
			</div>
		</div>
	</div>
</body>
</html>