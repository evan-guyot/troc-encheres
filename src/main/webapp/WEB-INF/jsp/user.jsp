<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%
Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ENI - Encheres</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-6">
				<h1>ENI - Encheres</h1>
			</div>
			
        <div class="col-6">
            <a href="ConnectionUtilisateur" class="btn btn-primary active" role="button" aria-pressed="true">Se connecter</a>
            <a href="#" class="btn btn-dark active" role="button" aria-pressed="true">S'inscrire</a>
        </div>
			<div class="col-12">
				<h2 class="text-center">Utilisateur</h2>
			</div>
			<div class="col-12">
				<div class="card mt-5">
					<div class="row no-gutters">
						<div class="col-sm-3">
							<img class="card-img" src="https://picsum.photos/200/300"
								alt="user profil img">
						</div>
						<div class="col-sm-9">
							<div class="card-body">
								<h2 class="card-title"><%=utilisateur.getPrenom()%>
									<%=utilisateur.getNom()%></h2>
								<p class="card-text">
									<span>Pseudo : </span><span><%=utilisateur.getPseudo()%></span>
								</p>
								<p class="card-text">
									<span>Adresse : </span><span><%=utilisateur.getRue()%>
										<%=utilisateur.getVille()%> <%=utilisateur.getCodePostal()%></span>
								</p>
								<p class="card-text">
									<span>Tel : </span><span><%=utilisateur.getTelephone()%></span>
								</p>
								<p class="card-text">
									<span>Email : </span><span><%=utilisateur.getEmail()%></span>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>