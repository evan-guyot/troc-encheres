<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="fr.eni.trocenchere.bo.Article"%>
<%@ page import="fr.eni.trocenchere.bo.Categorie"%>
<%@ page import="fr.eni.trocenchere.bo.Enchere"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
</head>
<body>
	<%
	Article article = (Article) request.getAttribute("articleCourrant");
	%>
	<form class="row mb-2 grandeDiv" method="post" action="Encherir" >
		<div class="col-md-6">
			<div
				class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
				<div class="col-auto d-none d-lg-block">
					<img class="tailleImage" src="https://picsum.photos/200/300"
						alt="Card image cap">
				</div>
				<div class="col p-4 d-flex flex-column position-static">
					<h3 class="mb-3">
						D�tail de vente pour:
						<%=article.getNom()%></h3>

					<div class="dpf">
						<div class="bold">Description:</div>
						<p class="card-text"><%=article.getDescription()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Cat�gorie:</div>
						<p class="card-text"><%=article.getCategorie().getLibelle()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Meilleure offre:</div>
						<p class="card-text"><%=article.getEnchere().getMontantEnchere()%>
							Pok�dolar par
							<%=article.getEnchere().getUtilisateur().getPseudo()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Mise � prix:</div>
						<p class="card-text"><%=article.getMiseAPrix()%></p>
					</div>
					<div class="dpf">
						<div class="bold">Fin de l'ench�re:</div>
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
					<div class="dpf">
						<div class="bold">Ma proposition:</div>
						<input type="number" class="form-control inputNumber" id="number" name="nouveauMontant" 
							aria-describedby="number"
							value="<%=article.getEnchere().getMontantEnchere()%>" />
					</div>
					<div class="btnn">
						<input type="hidden" name="noArticle" value="<%=article.getNoArticle()%>"/>
						<input type="submit" class="btn btn-light" value="Ench�rir" /> <a
							href="<%=request.getContextPath() + "/"%>" class="btn btn-light">Retour</a>
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

.inputNumber {
	height: 30px;
	width: auto;
}
}
</style>
</html>