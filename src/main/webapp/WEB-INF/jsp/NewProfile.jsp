<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="height:100%">
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<meta charset="UTF-8">
</head>
<body style="height: 100%">
	<div  class="grandeDiv">
		<div style = "display: flex; justify-content: center;">Mon Profil</div>
		<form method="post" action="CreationProfileServlet" >
			<div class = "formulaire">
			
			<div>
				<div class="ligneForm">
					
					<input placeholder="Pseudo" type="text" name="pseudo" class="form-control">
				</div>
				<div class="ligneForm">
					
					<input placeholder="Prénom"  type="text" name="prenom"  class="form-control">
				</div>
				<div class="ligneForm">
					
					<input placeholder="Téléphone"  type="text" name="tel"  class="form-control">
				</div>
				<div class="ligneForm">
					
					<input  placeholder="Code Postal" type="text" name="codepostal"  class="form-control">
				</div>
				<div class="ligneForm">
					
					<input placeholder="Mot de passe"  type="password" name="mdp"  class="form-control">
				</div>
			</div>
				
			<div>
				<div class="ligneForm">
					
					<input placeholder="Nom"  type="text" name="nom"  class="form-control">
				</div>
				<div class="ligneForm">
					
					<input placeholder="Email"  type="text" name="mail"  class="form-control">
				</div>
				<div class="ligneForm">
					
					<input  placeholder="Rue" type="text" name="rue"  class="form-control">
				</div>
				<div class="ligneForm">
					
					<input placeholder="Ville"  type="text" name="ville"  class="form-control">
				</div>
				<div class="ligneForm">
					
					<input  placeholder="Confirmation" type="password" name="confirmMdp"  class="form-control">
				</div>
			</div>
			</div>
			<div class="btnn">

				<input type="submit" class="btn btn-light">
				<a href="/TrocEncheres/" class="btn btn-light">Annuler</a>

			</div>
		</form>
	</div>
</body>
<style>
body{
display: flex;
    justify-content: center;
    align-items: center;
}
.btnn{
    display: flex;
    flex-direction: row;
    justify-content: space-evenly;
    align-items: center;
    margin-top: 20px;
}
	.formulaire{
	display: flex;
	}
	.grandeDiv{
	    display: flex;
    flex-direction: column;
    gap: 50px;
	}
	.ligneForm{
	display: flex;
	margin: 20px;
	justify-content: flex-end;
	gap: 15px;
	}
</style>
</html>