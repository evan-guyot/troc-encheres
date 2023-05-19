<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Troc Enchères - Connection</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
</head>
<style>
form {
	margin-top: 5em
}

form>* {
	margin: 15px 0
}
</style>
<body class="text-center">
	<%
	boolean isCorrect = request.getAttribute("erreur") == null || !((boolean) request.getAttribute("erreur"));
	%>
	<main class="form-signin w-50 m-auto">
		<form action="ConnectionUtilisateur" method="post">
			<h1 class="h3 mb-3 fw-normal">Connectez-vous</h1>
			<div class="form-floating">
				<input type="text" class="form-control" id="identifiant"
					name="identifiant" placeholder="Pseudo ou adresse mail"> <label
					for="identifiant">Pseudo ou adresse mail</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="motDePasse"
					name="motDePasse" placeholder="Password"> <label
					for="motDePasse">Mot de passe</label>
			</div>
			<%
			if (!isCorrect) {
			%>
			<div class="alert alert-danger" role="alert">Données
				incorrectes</div>
			<%
			}
			%>
			<button class="w-100 btn btn-lg btn-primary" type="submit">Se
				connecter</button>
		</form>
	</main>
</body>
</html>