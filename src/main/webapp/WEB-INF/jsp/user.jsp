<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%
Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
%>
<%
Integer idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
Boolean isDeleted = (Boolean) request.getAttribute("articles");
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
				<h1>
					<a class="text-secondary text-decoration-none"
						href="<%=request.getContextPath() + "/"%>">ENI - Encheres</a>
				</h1>
			</div>

        <div class="col-6">
            <%
				if (idConnectedUser != null) {
				%>
				<a href="utilisateur?id=<%=idConnectedUser%>">voir mon profil</a>
                <a href="DeconnectionUtilisateur">se déconnecter</a>
				<%
				} else {
				%>
				<a href="ConnectionUtilisateur" class="btn btn-primary active" role="button" aria-pressed="true">Se connecter</a>
            <a href="#" class="btn btn-dark active" role="button" aria-pressed="true">S'inscrire</a>
				<%
				}
				%>
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
							<%
							if (idConnectedUser != null && idConnectedUser == Integer.parseInt(request.getParameter("id"))) {
							%>
							<div class="card-body">
								<form action="<%=request.getContextPath()%>/utilisateur?id=<%=request.getParameter("id")%>" method="POST">
									<div class="row">
										<div class="col-12 col-md-6">
											<div class="form-label">
												<label for="name" class="d-block">Nom</label> <input
													type="text" id="name" value="<%=utilisateur.getNom()%>" required>
											</div>

											<div class="form-label">
												<label for="firstname" class="d-block">Prenom</label> <input
													type="text" id="firstname" name="firstname"
													value="<%=utilisateur.getPrenom()%>" required>
											</div>

											<div class="form-label">
												<label for="pseudo" class="d-block">Pseudo</label> <input
													type="text" id="pseudo" name="pseudo"
													value="<%=utilisateur.getPseudo()%>" required>
											</div>

											<div class="form-label">
												<label for="adress" class="d-block">Rue</label> <input
													type="text" id="adress" name="adress" value="<%=utilisateur.getRue()%>" required>
											</div>

											<div class="form-label">
												<label for="city" class="d-block">Ville</label> <input
													type="text" id="city" name="city" value="<%=utilisateur.getVille()%>" required>
											</div>
										</div>
										<div class="col-12 col-md-6">
											<div class="form-label">
												<label for="postal-code" class="d-block">code
													postale</label> <input type="text" id="postal-code" name="postal-code"
													value="<%=utilisateur.getCodePostal()%>" required>
											</div>

											<div class="form-label">
												<label for="phone" class="d-block">telephone</label> <input
													type="text" id="phone" name="phone"
													value="<%=utilisateur.getTelephone()%>" required>
											</div>

											<div class="form-label">
												<label for="email" class="d-block">email</label> <input
													type="email" id="email" name="email" value="<%=utilisateur.getEmail()%>" required>
											</div>

											<div class="form-label">
												<label for="password" class="d-block">mot de passe</label> <input
													type="password" id="password" name="password" required>
											</div>
										</div>
									</div>
									<div class="mt-2">
										<button type="submit" class="btn btn-primary">
											modifier mon compte</button>
										<button type="button" class="btn btn-primary"
											data-toggle="modal" data-target="#modal">supprimer
											mon compte</button>
									</div>
								</form>
							</div>
							<%
							} else {
							%>
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
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="modal" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<form action="<%=request.getContextPath()%>/DeleteUserById"
					method="post">
					<div class="modal-header">
						<h2 class="modal-title text-uppercase" id="exampleM	odalLongTitle">êtes
							vous sur de vouloir supprimer votre compte ?</h2>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<label for="passwordDelete" class="d-block">pour confirmer
							la suppression de votre compte, renseignez votre mot de passe :</label>
                        <input type="password" id="passwordDelete" name="passwordDelete">
                        <label for="userId">
                            <input type="hidden" id="userId" name="userId" value="<%= idConnectedUser %>">
                        </label>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">supprimer
							mon compte</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"
	integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"
	integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
	crossorigin="anonymous"></script>
</html>