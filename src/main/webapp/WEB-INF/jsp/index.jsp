<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Article"%>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ENI - Encheres</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
	<%

	int noCategorie = 0;
	
	if (request.getAttribute("filtreCategorie") != null) {
		noCategorie = (int) request.getAttribute("filtreCategorie");
	}

	String nomArticle = (String) request.getAttribute("filtreArticle");
	%>
	<div class="container">
		<div class="row">
			<div class="col-6">
				<h1>
                <a class="text-secondary text-decoration-none" href="<%=request.getContextPath() + "/"%>">ENI - Encheres</a>
            </h1>
			</div>
			<div class="col-6">
				<a href="ConnectionUtilisateur" class="btn btn-primary active mt-1 d-flex
				 justify-content-center"
					role="button" aria-pressed="true" style="width: fit-content;
    float: right;">Se connecter/S'inscrire</a>
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
								<label for="nomArticle" class="d-block">Filtres :</label>

								<%
								if (nomArticle != null) {
								%>
								<input type="text" name="filtreArticle" id="filtreArticle" class="w-100"
									placeholder="le nom de l'article contient"
									value="<%=nomArticle%>">

								<%
								} else {
								%>
								<input type="text" name="filtreArticle" id="filtreArticle" class="w-100"
									placeholder="le nom de l'article contient">
								<%
								}
								%>
							</div>
							<div class="form-label">
								<label for="categorie" class="d-block">Catégories :</label> <select
									name="filtreCategorie" id="filtreCategorie" class="w-100">
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

						</div>
						<div class="col-12 col-md-6">
							<button class="btn btn-primary w-100" type="submit">Rechercher</button>
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
										: </span> <%=article.getMiseAPrix()%></li>
								<li class="list-group-item"><span class="fw-bold">Fin
										enchères : </span><%=article.getDateFinEnchere()%></li>
								<li class="list-group-item"><span class="fw-bold">Vendeur
										: </span> <a
									href="<%=request.getContextPath() + "/utilisateur?id=" + article.getUtilisateur().getNoUtilisateur()%>">
										<span><%=article.getUtilisateur().getPseudo()%></span>
								</a></li>
							</ul>

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