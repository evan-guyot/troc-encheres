<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="fr.eni.trocenchere.bo.Article" %>
<%@ page import="fr.eni.trocenchere.bo.Categorie" %>
<%@ page import="fr.eni.trocenchere.bo.Enchere" %>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body><% Article article = (Article) request.getAttribute("articleCourrant"); %>
	<div>
		 <img class="tailleImage" src="https://picsum.photos/200/300" alt="Card image cap">
	</div>
	<div>
		<h3>Détail vente</h3>
		<div>
			<div>Description :</div>
			<div><%=article.getDescription() %></div>
		</div>
		<div>
			<div>Catégorie :</div>
			<div><%=article.getCategorie().getLibelle() %></div>
		</div>
		<div>
			<div>Meilleure offre :</div>
			<div><%=article.getEnchere().getMontantEnchere()%> Pokédolar par <%=article.getEnchere().getUtilisateur().getPseudo() %></div>
		</div>
		<div>
			<div>Mise à prix :</div>
			<div><%=article.getMiseAPrix()%></div>
		</div>
		<div>
			<div>Fin de l'enchère :</div>
			<div><%=article.getDateFinEnchere()%></div>
		</div>
		<div>
			<div>Retrait :</div>
			<div><%=article.getRetrait().getRue()%> <%=article.getRetrait().getCodePostal() %> <%=article.getRetrait().getVille() %></div>			
		</div>
		<div>
			<div>Vendeur :</div>
			<a href="#" ><%=article.getUtilisateur().getPseudo() %></a>
		</div>
	</div>
</body>
<style>
.tailleImage{
height:450px;
width:300px;
}
</style>
</html>