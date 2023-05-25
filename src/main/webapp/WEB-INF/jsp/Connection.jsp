<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Troc Enchères - Connection</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
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
					name="identifiant" placeholder="Pseudo ou adresse mail" /><label
					for="identifiant" class="form-label">Pseudo ou adresse mail</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" id="motDePasse"
					name="motDePasse" placeholder="Password" /><label for="motDePasse"
					class="form-label">Mot de passe</label>
			</div>
			<%
			if (!isCorrect) {
			%>
			<div class="alert alert-danger" role="alert">Données
				incorrectes</div>
			<%
			}
			%>
				<button class="w-25 btn btn-lg btn-primary" type="submit">Se
					connecter</button>
				<a href="/TrocEncheres/" class="w-25 btn btn-lg btn-secondary">Annuler</a>

			<a href="CreationProfileServlet"
				class="w-50 btn btn-lg btn-outline-primary">S'inscrire</a>
		</form>
	</main>
</body>
</html>