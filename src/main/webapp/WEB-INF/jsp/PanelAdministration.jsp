<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<meta charset="ISO-8859-1">
<title>Panel Admin</title>
</head>
<body>

	<%
	List<Categorie> categories = (List<Categorie>) request.getAttribute("categories");
	List<Utilisateur> utilisateurs = (List<Utilisateur>) request.getAttribute("utilisateurs");
	List<Utilisateur> utilisateursSupprimable = (List<Utilisateur>) request.getAttribute("utilisateursSupprimable");
	%>
	
	<div class="d-flex flex-row justify-content-center align-items-center">
		<h2 class="card-header d-flex justify-content-center m-3">Administrer
			les utilisateurs</h2>
		<a href="<%=request.getContextPath() + "/"%>"
			class="btn btn-secondary">Accueil</a>
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
					if(categorie.getNoCategorie() != 5){
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