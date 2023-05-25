<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
</head>
<body>
	<main class="form-signin w-50 m-5 shadow-sm border p-4 mx-auto h-200">
		<h3 class="mt-3 mx-auto" style="text-align: center !important ">Création
			du profil</h3>

		<%
		if (request.getAttribute("ErrorMess") != null) {
		%>
		<div class="alert alert-danger w-100" role="alert"><%=request.getAttribute("ErrorMess")%></div>
		<%
		}
		%>

		<form method="post" action="CreationProfileServlet" class="w-100">

			<div class="input-grouped">
				<div class="form-floating w-50 m-2">
					<input type="text" class="form-control" id="pseudo" name="pseudo"
						placeholder="Votre pseudo" /><label for="pseudo"
						class="form-label">Votre Pseudo</label>
				</div>
				<div class="form-floating w-50 m-2">
					<input type="text" class="form-control" id="nom" name="nom"
						placeholder="Votre nom" /><label for="nom" class="form-label">Votre
						nom</label>
				</div>
			</div>

			<div class="input-grouped">

				<div class="form-floating w-50 m-2">
					<input type="text" class="form-control" id="prenom" name="prenom"
						placeholder="Votre prénom" /><label for="prenom"
						class="form-label">Prénom</label>
				</div>

				<div class="form-floating w-50 m-2">
					<input type="text" class="form-control" id="mail" name="mail"
						placeholder="Votre mail" /><label for="mail"
						class="form-label">Email</label>
				</div>
			</div>

			<div class="input-grouped">
				<div class="form-floating  w-50 m-2">
					<input type="tel" class="form-control" id="tel" name="tel"
						placeholder="Votre téléphone" /><label for="tel"
						class="form-label">Votre numéro de téléphone</label>
				</div>
				<div class="form-floating  w-50 m-2">
					<input type="text" class="form-control" id="rue" name="rue"
						placeholder="Rue" /><label for="rue" class="form-label">Rue</label>
				</div>


			</div>
			<div class="input-grouped">

				<div class="form-floating  w-50 m-2">
					<input type="text" class="form-control" id="codepostal"
						name="codepostal" placeholder="Code Postal" /><label
						for="codepostal" class="form-label">Code Postal</label>
				</div>
				<div class="form-floating  w-50 m-2">
					<input type="text" class="form-control" id="ville" name="ville"
						placeholder="Ville" /><label for="ville" class="form-label">Ville</label>
				</div>

			</div>
			<div class="input-grouped">
				<div class="form-floating w-50 m-2">
					<input type="password" class="form-control" id="mdp" name="mdp"
						placeholder="Mot de passe" /><label for="mdp" class="form-label">Mot
						de passe</label>
				</div>
				<div class="form-floating w-50 m-2">
					<input type="password" class="form-control" id="confirmMdp"
						name="confirmMdp" placeholder="Confirmation mot de passe" /><label
						for="confirmMdp" class="form-label">Confirmation mot de
						passe</label>
				</div>
			</div><div class="input-grouped">
<button type="submit" class="w-50 m-2 btn btn-lg btn-primary">Créer</button>
<a href="ConnectionUtilisateur"
							class="w-50 m-2 btn btn-lg btn-secondary">Annuler</a></div>
			<!-- 
					<div class="d-flex"
						style="padding-left: 120px; padding-right: 120px; gap: 24px;">

						
						

					</div>
 -->
		</form>
	</main>
</body>

<style>
.input-grouped {
	display: flex !important;
	flex-direction: row !important;
}


</style>

</html>