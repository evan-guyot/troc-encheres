<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%@ page import="fr.eni.trocenchere.bo.Enchere"%>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Article"%>
<%@ page import="fr.eni.trocenchere.bo.Retrait"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="categories" scope="page" value="${categories}" />
<c:set var="article" scope="page" value="${article}" />
<c:set var="currentUser" scope="page" value="${currentUser}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ENI - Encheres - Vente Article</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">

	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<%
	Utilisateur utilisateur = (Utilisateur) request.getAttribute("currentUser");
	Integer idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
	List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
	%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="utilisateur" scope="page" value="${currentUser}" />
	<c:set var="idConnectedUser" scope="page" value="${connectedUserId}" />
	<c:set var="categories" scope="page" value="${categories}" />
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
				<ul class="navbar-nav me-auto mb-2 mb-lg-0" style="margin-left:auto;margin-right:5px!important">
					<li class="nav-item">
					<a class="nav-link" aria-current="page"
						href="VendreArticle">Vendre un article</a> </li>
					<li class="nav-item">
						<a
						class="nav-link" href="utilisateur?id=<%=idConnectedUser%>">Voir
						mon profil</a> </li>
					<% if (utilisateur.isAdministrateur()) { %>
					<li class="nav-item">
						<a href="PanelAdministration"
						class=" nav-link">
							Administration
						</a>
					</li>
						<% } %>
					<li class="nav-item">
						<a class="nav-link" href="DeconnectionUtilisateur">Se déconnecter</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<main class="container">
		<div class="row">
			<div class="col-12 mt-5">
				<h2 class="text-center">
					<%
					if (request.getAttribute("article") == null) {
					%>
					Vendez votre article
					<%
					} else {
					%>
					Modifiez votre article
					<%
					}
					%>
				</h2>
			</div>
			<div class="mt-4">
				<div class="col-lg-8 mx-auto">
					<%
					if (request.getAttribute("erreursFormulaire") != null) {
					%>
					<div class="alert alert-danger" role="alert">
						<%=request.getAttribute("erreursFormulaire")%>
					</div>
					<%
					}
					if (request.getAttribute("article") == null) {
					%>
					<form class="needs-validation mb-5" method="POST" action="VendreArticle"
						novalidate>
						<div class="col-sm-6">
							<label for="articleNom" class="form-label">Nom</label> <input
								type="text" class="form-control" id="articleNom"
								name="articleNom" placeholder="Nom" value="" required>
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="col-xl-12">
							<label for="articleDescription" class="form-label">Description
								:</label>
							<textarea class="form-control" aria-label="With textarea"
								id="articleDescription" name="articleDescription"
								placeholder="Décrivez votre article" value="" required></textarea>
							<div class="invalid-feedback">Valid last name is required.</div>
						</div>
						<div class="col-sm-6">
							<label for="articleCategorie" class="form-label">Catégorie</label>
							<select class="form-select" id="articleCategorie"
								name="articleCategorie" required>
								<%
								for (Categorie c : categories) {
								%>
								<option value="<%=c.getNoCategorie()%>">
									<%=c.getLibelle()%>
								</option>
								<%
								}
								%>
							</select>
							<div class="invalid-feedback">Please provide a valid state.
							</div>
						</div>
						<div class="form-group row"></div>
						<div class="col-sm-3">
							<label for="miseAPrixArticle" class="form-label">Mise à
								prix (Crédits)</label> <input type="number" class="form-control"
								id="miseAPrixArticle" name="miseAPrixArticle"
								placeholder="Mise à prix" value="10" min="1" required />
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="form-group row"></div>
						<div class="col-sm-6">
							<label for="dateDebEnchere" class="form-label">Date de
								début d'enchères</label> <input type="date" class="form-control"
								name="dateDebEnchere" id="dateDebEnchere" required />
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="form-group row"></div>
						<div class="col-sm-6">
							<label for="dateFinEnchere" class="form-label">Date de
								fin d'enchères</label> <input type="date" class="form-control"
								name="dateFinEnchere" id="dateFinEnchere" required />
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<hr class="my-4">
						<h5 class="mb-3">Retrait</h5>
						<div class="form-group row">
							<label for="rueRetrait" class="col-sm-2 col-form-label">Rue</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="rueRetrait"
									name="rueRetrait" placeholder="Rue"
									value="<c:out value='${utilisateur.getRue()}'/>">
							</div>
						</div>
						<div class="form-group row">
							<label for="codePostalRetrait" class="col-sm-2 col-form-label">Code
								postal</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="codePostalRetrait"
									name="codePostalRetrait" placeholder="Code Postal"
									value="<c:out value='${utilisateur.getCodePostal()}'/>">
							</div>
						</div>
						<div class="form-group row">
							<label for="villeRetrait" class="col-sm-2 col-form-label">Ville</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="villeRetrait"
									name="villeRetrait" placeholder="Ville"
									value="<c:out value='${utilisateur.getVille()}'/>">
							</div>
						</div>
						<div class="d-flex justify-content-around">
							<a href="/TrocEncheres/"
								class="w-25 btn btn-secondary btn-lg float-start">retour</a>
							<button class="w-25 btn btn-primary btn-lg" type="submit">Mettre
								en enchère</button>
						</div>
					</form>
					<%
					} else {
					Article article = (Article) request.getAttribute("article");
					%>
					<form class="needs-validation mb-5" method="POST" action="ModifierVente"
						novalidate>
						<input type="hidden" name="articleId"
							value="<c:out value='${article.getNoArticle()}'/>">
						<div class="col-sm-6">
							<label for="articleNom" class="form-label">Nom</label> <input
								type="text" class="form-control" id="articleNom"
								name="articleNom" placeholder="Nom"
								value="<c:out value='${article.getNom()}'/>" required>
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="col-xl-12">
							<label for="articleDescription" class="form-label">Description
								:</label>
							<textarea class="form-control" aria-label="With textarea"
								id="articleDescription" name="articleDescription"
								placeholder="Décrivez votre article" required><c:out
									value='${article.getDescription()}' /></textarea>
							<div class="invalid-feedback">Valid last name is required.</div>
						</div>
						<div class="col-sm-6">
							<label for="articleCategorie" class="form-label">Catégorie</label>
							<select class="form-select" id="articleCategorie"
								name="articleCategorie" required>
								<%
								for (Categorie c : categories) {
									if (c.getNoCategorie() == article.getCategorie().getNoCategorie()) {
								%>
								<option value="<%=c.getNoCategorie()%>" selected>
									<%=c.getLibelle()%>
								</option>
								<%
								} else {
								%>
								<option value="<%=c.getNoCategorie()%>">
									<%=c.getLibelle()%>
								</option>
								<%
								}
								}
								%>
							</select>
							<div class="invalid-feedback">Please provide a valid state.
							</div>
						</div>
						<div class="form-group row"></div>
						<div class="col-sm-3">
							<label for="miseAPrixArticle" class="form-label">Mise à
								prix (Crédits)</label> <input type="number" class="form-control"
								id="miseAPrixArticle" name="miseAPrixArticle"
								placeholder="Mise à prix"
								value="<c:out value='${article.getMiseAPrix()}'/>" min="1"
								required />
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="form-group row"></div>
						<div class="col-sm-6">
							<label for="dateDebEnchere" class="form-label">Date de
								début d'enchères</label> <input type="date" class="form-control"
								name="dateDebEnchere" id="dateDebEnchere"
								value="<c:out value='${article.getDateDebutEnchere()}'/>"
								required />
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="form-group row"></div>
						<div class="col-sm-6">
							<label for="dateFinEnchere" class="form-label">Date de
								fin d'enchères</label> <input type="date" class="form-control"
								name="dateFinEnchere" id="dateFinEnchere"
								value="<c:out value='${article.getDateFinEnchere()}'/>" required />
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<hr class="my-4">
						<h5 class="mb-3">Retrait</h5>
						<div class="form-group row">
							<label for="rueRetrait" class="col-sm-2 col-form-label">Rue</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="rueRetrait"
									name="rueRetrait" placeholder="Rue"
									value="<c:out value='${article.getRetrait().getRue()}'/>">
							</div>
						</div>
						<div class="form-group row">
							<label for="codePostalRetrait" class="col-sm-2 col-form-label">Code
								postal</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="codePostalRetrait"
									name="codePostalRetrait" placeholder="Code Postal"
									value="<c:out value='${article.getRetrait().getCodePostal()}'/>">
							</div>
						</div>
						<div class="form-group row">
							<label for="villeRetrait" class="col-sm-2 col-form-label">Ville</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="villeRetrait"
									name="villeRetrait" placeholder="Ville"
									value="<c:out value='${article.getRetrait().getVille()}'/>">
							</div>
						</div>
						<div class="d-flex justify-content-around">
							<a href="/TrocEncheres/"
								class="w-25 btn btn-secondary btn-lg float-start">retour</a>
							<button class="w-25 btn btn-primary btn-lg" type="submit">Modifier</button>
							<button class="w-25 btn btn-danger btn-lg"
								formaction="AnnulerVente" type="submit">Annuler la
								vente</button>
						</div>
					</form>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</main>
	<div class="modal" tabindex="1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>Modal body text goes here.</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary">Save changes</button>
				</div>
			</div>
		</div>

	</div>
	<%
	if (request.getAttribute("validationMessage") != null) {
	%>
	<div id="myModal" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<div class="form-group">
						<h5 class="modal-title text-center"><%=request.getAttribute("validationMessage")%></h5>
					</div>

				</div>
			</div>
		</div>
	</div>
	<%
	}
	%>
</body>
<script>

<%if (request.getAttribute("validationMessage") != null) {%>
	$(document).ready(function() {
		$("#myModal").modal('show');
	});
<%}%>

</script>
<style>
body {
	background-color: #eee
}

.form-group {
	margin-bottom: 1em
}
</style>
</html>