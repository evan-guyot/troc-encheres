<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Article"%>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ENI - Encheres</title>
	<link
			href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
			rel="stylesheet"
			integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
			crossorigin="anonymous">
</head>
<body>
	<%

	int noCategorie = 0;
	
	if (request.getAttribute("filtreCategorie") != null) {
		noCategorie = (int) request.getAttribute("filtreCategorie");
	}

	String nomArticle = (String) request.getAttribute("filtreArticle");
	%>
	<nav class="navbar navbar-expand-lg bg-body-secondary" data-bs-theme="dark">
		<div class="container-fluid">
			<div class="navbar-brand">
				<h1>
					<a class="nav-link active"
					   href="<%=request.getContextPath() + "/"%>"> ENI - Encheres </a>
				</h1>
			</div>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
					data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
					aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
						<a class="nav-link" aria-current="page" href="ConnectionUtilisateur">Se connecter/S'inscrire</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<div class="col-12 mt-5">
				<h2 class="text-center">Liste des enchères</h2>
			</div>
			<div class="col-12">
				<form action="<%=request.getContextPath() + "/"%>" method="POST"
					class="mt-5 mb-5">
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
							<button class="btn btn-secondary mt-4" id="clear_filter" type="button">Effacer les filtres</button>
							<button class="btn btn-primary w-50 mt-4" type="submit">Rechercher</button>
						</div>
					</div>
				</form>
			</div>
			<div class="col-12">
				<ul class="list-unstyled row">
					<c:forEach var="article" items="${articles}" >
						<li class="col-12 col-sm-4 col-md-4 col-lg-3">
							<div class="card mb-5">
								<img class="card-img-top" src="https://picsum.photos/200/200"
									 alt="Card image cap">
								<div class="card-body">
									<h2 class="card-title fw-bold">
										<c:out value="${article.getNom()}"/>
									</h2>
									<p class="card-text">
										<c:out value="${article.getDescription()}"/>
									</p>
								</div>
								<ul class="list-group list-group-flush">
									<li class="list-group-item">
										<span class="fw-bold">Prix : </span>
										<c:choose>
											<c:when test="${article.getEnchere() != null}">
												<p style="color: blue; font-weight: 500;" class="card-text">
													<c:out value="${article.getEnchere().getMontantEnchere()}"/>
												</p>
											</c:when>
											<c:otherwise>
												<p style="color: blue; font-weight: 500;" class="card-text">
													<c:out value="${article.getMiseAPrix()}"/>
												</p>
											</c:otherwise>
										</c:choose>
									</li>
									<li class="list-group-item">
										<span class="fw-bold">Fin enchères : </span>
										<c:out value="${article.getDateFinEnchere()}"/>
									</li>
									<li class="list-group-item">
										<span class="fw-bold">Vendeur : </span>
										<a href="<c:out value="${request.getContextPath()}utilisateur?id=${article.getUtilisateur().getNoUtilisateur()}"/>">
											<span><c:out value="${article.getUtilisateur().getPseudo()}"/></span>
										</a>
									</li>
								</ul>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
	
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		const button_clear_filters = document.getElementById("clear_filter");
		const filtre_article = document.getElementById("filtreArticle");
		const filtre_categorie = document.getElementById("filtreCategorie");

		button_clear_filters.addEventListener("click", (e) => {
			filtre_article.value = "";
			filtre_categorie.value = 0;
		});
	</script>
</body>
</html>