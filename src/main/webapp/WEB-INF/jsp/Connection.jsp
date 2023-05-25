<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Troc Enchères - Connection</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
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
			<div class="form-floating text-left">
				<label for="identifiant">Pseudo ou adresse mail</label>
				<input type="text" class="form-control" id="identifiant"
					name="identifiant" placeholder="Pseudo ou adresse mail">
			</div>
			<div class="form-floating text-left">
				<label for="motDePasse">Mot de passe</label>
				<input type="password" class="form-control" id="motDePasse"
					name="motDePasse" placeholder="Password">
			</div>
			<%
			if (!isCorrect) {
			%>
			<div class="alert alert-danger" role="alert">Données
				incorrectes</div>
			<%
			}
			%>
			<div class="d-flex">
			<button class="w-50 btn btn-lg btn-primary" type="submit">Se
				connecter</button>
			<a href="/TrocEncheres/" class="w-50 btn btn-lg btn-secondary">Annuler</a>
			</div>
			
			<a href="CreationProfileServlet"
					class="w-100 btn btn-lg btn-dark active">S'inscrire</a>
		</form>
	</main>
</body>
</html>