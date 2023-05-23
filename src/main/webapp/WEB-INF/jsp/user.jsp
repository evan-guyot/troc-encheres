<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%
Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
%>
<%
Boolean hasBeenUpdated = (Boolean) request.getAttribute("hasBeenUpdated");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ENI - Encheres</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-6">
				<h1>
					<a class="text-secondary text-decoration-none"
						href="<%=request.getContextPath() + "/"%>">ENI - Encheres</a>
				</h1>
			</div>
			<div class="col-6">

				<div class="col-6">
					<a href="ConnectionUtilisateur"
						class="btn btn-primary active mt-1 d-flex
				 justify-content-center"
						role="button" aria-pressed="true"
						style="width: fit-content; float: right;">Se
						connecter/S'inscrire</a>
				</div>

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
									<%=utilisateur.getNom()%>
								</h2>
								<p class="card-text">
									<span>Pseudo : </span><span><%=utilisateur.getPseudo()%></span>
								</p>
								<p class="card-text">
									<span>Adresse : </span><span><%=utilisateur.getRue()%> <%=utilisateur.getVille()%>
										<%=utilisateur.getCodePostal()%></span>
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
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>

</html>