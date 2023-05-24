<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height: 100%">
<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<meta charset="UTF-8">
</head>
<body style="height: 100%">
	<div class="grandeDiv">
		<div
			class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative"
			style="padding: 30px;">
			<div style="display: flex; font-size: 30px; justify-content: center;">Création
				du profil</div>
				<%if(request.getAttribute("ErrorMess")!=null){ %>
			<div class="alert alert-danger" role="alert"><%=request.getAttribute("ErrorMess") %></div>
				<% } %>
			<form method="post" action="CreationProfileServlet">
				<div class="formulaire">

					<div>
						<div class="ligneForm">

							<input placeholder="Pseudo" type="text" name="pseudo"
								class="form-control">
						</div>
						<div class="ligneForm">

							<input placeholder="Prénom" type="text" name="prenom"
								class="form-control">
						</div>
						<div class="ligneForm">

							<input placeholder="Téléphone" type="tel" name="tel"
								class="form-control">
						</div>
						<div class="ligneForm">

							<input placeholder="Code Postal" type="text" name="codepostal"
								class="form-control">
						</div>
						<div class="ligneForm">

							<input placeholder="Mot de passe" type="password" name="mdp"
								class="form-control">
						</div>
					</div>

					<div>
						<div class="ligneForm">

							<input placeholder="Nom" type="text" name="nom"
								class="form-control">
						</div>
						<div class="ligneForm">

							<input placeholder="Email" type="text" name="mail"
								class="form-control">
						</div>
						<div class="ligneForm">

							<input placeholder="Rue" type="text" name="rue"
								class="form-control">
						</div>
						<div class="ligneForm">

							<input placeholder="Ville" type="text" name="ville"
								class="form-control">
						</div>
						<div class="ligneForm">

							<input placeholder="Confirmation" type="password"
								name="confirmMdp" class="form-control">
						</div>
					</div>
				</div>
				<div class="d-flex"
					style="padding-left: 120px; padding-right: 120px; gap: 24px;">

					<button type="submit" class="w-50 btn btn-lg btn-primary">Créer</button>
					<a href="ConnectionUtilisateur"
						class="w-50 btn btn-lg btn-secondary">Annuler</a>

				</div>
			</form>
		</div>
	</div>
</body>
<style>
body {
	display: flex;
	justify-content: center;
	align-items: center;
}

.btnn {
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	align-items: center;
	margin-top: 20px;
}

.formulaire {
	display: flex;
	justify-content: center;
}

.grandeDiv {
	display: flex;
	flex-direction: column;
	gap: 50px;
}

.ligneForm {
	display: flex;
	margin: 20px;
	justify-content: flex-end;
	gap: 15px;
}
</style>
</html>