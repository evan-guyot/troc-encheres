<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%@ page import="java.util.List"%>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Panel Admin</title>
</head>
<body>

	<%
	List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
	List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("utilisateurs");
	List<Utilisateur> utilisateursSupprimable = (List<Utilisateur>) request.getAttribute("utilisateursSupprimable");
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
                    <a class="nav-link" aria-current="page" href="VendreArticle">Vendre un article</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="utilisateur?id=<%=request.getSession().getAttribute("connectedUserId")%>">Voir mon profil</a>
                </li>                
                <li class="nav-item">
                    <a href="PanelAdministration" class="nav-link">
                        Administration
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="DeconnectionUtilisateur">Se déconnecter</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
	
	<div class="d-flex flex-row justify-content-center align-items-center">
		<h2 class="card-header d-flex justify-content-center m-3">Administrer
			les utilisateurs</h2>
	</div>

	<div class="container">
		<table class="table table-striped border">
			<thead>
				<tr>
					<th>Pseudo</th>
					<th>Nom</th>
					<th>Prénom</th>
					
					<th>Supprimer</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Utilisateur utilisateur : utilisateurs) {
				%>
				<tr>
					<td class="align-middle"><%=utilisateur.getPseudo()%></td>
					<td class="align-middle"><%=utilisateur.getNom()%></td>
					<td class="align-middle"><%=utilisateur.getPrenom()%></td>
					
					<td><form method="post" action="PanelAdministration" name="supprUser">
					<input type="hidden" name="formName" value="supprUser" />
					<input type="hidden" name="idUserASupprimer" value="<%= utilisateur.getNoUtilisateur()%>" />
					<input 
						<%Boolean desable = false; for(Utilisateur user : utilisateursSupprimable){ if(user.getNoUtilisateur() == utilisateur.getNoUtilisateur()){desable = true;} }%><% if(!desable){%>disabled="disabled"<% }%> type="submit" class="btn btn-danger" value=" Supprimer " name="supprimerUser"/> </td>
				</form>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	<h2 class="card-header d-flex justify-content-center m-3">Administrer
		les catégories</h2>
	<div class="container d-flex flex-row justify-content-between">
		<div class="card" style="width: 40%; height: 50%;">
			<h5 class="card-header">Ajouter une catégorie</h5>
			<form class="card-body d-flex flex-row justify-content-around" method="post" action="PanelAdministration" name="ajoutCateg">
				<div class="ligneForm">
				<input type="hidden" name="formName" value="ajoutCateg" />
					<input placeholder="Nouvelle catégorie" type="text" name="newCateg" class="form-control">
				</div>
				<input type="submit" class="btn btn-primary" value=" Ajouter " /> 
			</form>
		</div>

		<table class="table table-striped border" style="width: 50%">
			<thead>
				<tr>
					<th>Libelle</th>
					<th>Modifier</th>
					<th>Supprimer</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Categorie categorie : categories) {
					if(categorie.getNoCategorie() != 1){
				%>
				
				<tr>
					<form method="post" action="PanelAdministration" name="supprCateg">
						<input type="hidden" name="formName" value="supprCateg" />
						<input type="hidden" name="idCateg" value="<%=categorie.getNoCategorie() %>" />
						<td>
							<input type="text" name="nomCateg" class="form-control" value="<%=categorie.getLibelle()%>">
						</td>
						<td><input type="submit" class="btn btn-primary" value=" Modifier " name="modifier"/> </td>
						<td><input type="submit" class="btn btn-danger" value=" Supprimer " name="supprimer"/> </td>
						
					</form>
				</tr>
				<%
				}}
				%>
			</tbody>
		</table>
	</div>
</body>
</html>