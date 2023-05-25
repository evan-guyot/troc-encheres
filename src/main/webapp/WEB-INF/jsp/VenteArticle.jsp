<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%@ page import="fr.eni.trocenchere.bo.Enchere"%>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Article"%>
<%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="categories" scope="page" value="${categories}"/>
<c:set var="article" scope="page" value="${article}"/>
<c:set var="currentUser" scope="page" value="${currentUser}"/>
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
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
	<%
	Utilisateur utilisateur = (Utilisateur) request.getAttribute("currentUser");
	Integer idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
	List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
	%>
	<main class="container">
		<div class="row">
			<div class="col-5">
				<h1>
					<a class="text-secondary text-decoration-none" href="<%=request.getContextPath() + "/"%>">
						ENI - Encheres
					</a>
				</h1>
			</div>
			<div class="col-7">
				<div class="mt-2 float-end">
				<%
					if (utilisateur.isAdministrateur()) {
				%>
				<a href="PanelAdministration" class="btn btn-warning "
				   role="button" aria-pressed="true" style="color:white!important;background-color:orange">Administration</a>
				<%
					}
				%>
				<a class="btn btn-success"  role="button" aria-pressed="true"  href="VendreArticle">Vendre un article</a>
					 <a
				 href="utilisateur?id=<%=request.getSession().getAttribute("connectedUserId")%>" class="btn btn-primary" role="button" aria-pressed="true">Voir
					mon profil</a>
				<a href="DeconnectionUtilisateur" class=" btn btn-secondary" role="button" aria-pressed="true">Se
					déconnecter</a>
				</div>
			</div>
			<div class="col-12">
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
					<form class="needs-validation" method="POST" action="VendreArticle"
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
								prix (P$)</label> <input type="number" class="form-control"
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
							<label for="dateFinEnchere" class="form-label">Date de fin
								d'enchères</label> <input type="date" class="form-control"
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
							<a href="/TrocEncheres/" class="w-25 btn btn-secondary btn-lg float-start">retour</a>
							<button class="w-25 btn btn-primary btn-lg" type="submit">Mettre
								en enchère</button>
						</div>
					</form>
					<%
					} else {
						Article article = (Article) request.getAttribute("article");
					%>
					<form class="needs-validation" method="POST" action="ModifierVente"
						  novalidate>
						<input type="hidden" name="articleId" value="<c:out value='${article.getNoArticle()}'/>">
						<div class="col-sm-6">
							<label for="articleNom" class="form-label">Nom</label> <input
								type="text" class="form-control" id="articleNom"
								name="articleNom" placeholder="Nom" value="<c:out value='${article.getNom()}'/>"
								required>
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="col-xl-12">
							<label for="articleDescription" class="form-label">Description
								:</label>
							<textarea class="form-control" aria-label="With textarea"
									  id="articleDescription" name="articleDescription"
									  placeholder="Décrivez votre article" required><c:out value='${article.getDescription()}'/></textarea>
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
								prix (P$)</label> <input type="number" class="form-control"
														 id="miseAPrixArticle" name="miseAPrixArticle"
														 placeholder="Mise à prix" value="<c:out value='${article.getMiseAPrix()}'/>"
														 min="1" required />
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="form-group row"></div>
						<div class="col-sm-6">
							<label for="dateDebEnchere" class="form-label">Date de
								début d'enchères</label> <input type="date" class="form-control"
																name="dateDebEnchere" id="dateDebEnchere"
																value="<c:out value='${article.getDateDebutEnchere()}'/>" required />
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="form-group row"></div>
						<div class="col-sm-6">
							<label for="dateFinEnchere" class="form-label">Date de fin
								d'enchères</label> <input type="date" class="form-control"
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
						<a href="/TrocEncheres/" class="w-25 btn btn-secondary btn-lg float-start">retour</a>
						<button class="w-25 btn btn-primary btn-lg" type="submit">Modifier</button>
						<button class="w-25 btn btn-danger btn-lg" formaction="AnnulerVente" type="submit">Annuler
							la vente</button>
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