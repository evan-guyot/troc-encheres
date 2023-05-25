<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%
Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
Utilisateur utilisateurConnecte = (Utilisateur) request.getAttribute("utilisateurConnecte");
Boolean hasBeenUpdated = (Boolean) request.getAttribute("hasBeenUpdated");
Integer idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ENI - Encheres</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
            crossorigin="anonymous">
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-body-secondary" data-bs-theme="dark">
		<div class="container-fluid">
			<div class="navbar-brand">
				<h1>
					<a class="nav-link active"
						href="<%=request.getContextPath() + "/"%>">ENI - Encheres</a>
				</h1>
			</div>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
				data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
					aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
					<div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
					<a class="nav-link" aria-current="page"
						href="VendreArticle">Vendre un article</a> </li>
                <li class="nav-item">
                    <a
						class="nav-link" href="utilisateur?id=<%=idConnectedUser%>"> Voir mon profil </a>
                </li>
                <% if (utilisateur.isAdministrateur()) { %>
                <li class="nav-item"> <a
						href="PanelAdministration" class="nav-link">
                        Administration
                    </a>
                </li>
                <% } %>
                <li class="nav-item"> <a class="nav-link" href="DeconnectionUtilisateur">Se déconnecter</a>
                </li>
            </ul>
        </div>
				</div>
			</nav>
<div class="container">
    <div class="row">
			<div class="col-12mt-5">
				<h2 class="text-center">Utilisateur</h2>
			</div>
			<div class="col-12">
				<div class="card mt-5">
					<div class="row no-gutters">
						<div class="col-sm-3">
							<img class="card-img" src="https://picsum.photos/200/200"
								alt="user profil img">
						</div>
						<div class="col-sm-9">
							<%
							if (idConnectedUser != null && idConnectedUser == Integer.parseInt(request.getParameter("id"))) {
							%>
							<div class="card-body">
								<form
									action="<%=request.getContextPath()%>/utilisateur?id=<%=request.getParameter("id")%>"
									method="POST">
									<div class="row">
										<div class="col-12 col-md-6">
											<div class="form-label">
												<label for="nom" class="d-block fw-bold">Nom
													:</label> <input class="w-100 form-control-plaintext" type="text" id="nom" name="nom"
													readonly value="<c:out value="${utilisateur.getNom()}" />" required>
											</div>

											<div class="form-label">
												<label for="prenom" class="d-block fw-bold">Prénom
													:</label> <input class="w-100 form-control-plaintext" type="text" id="prenom"
													name="prenom"
													readonly value="<c:out value="${utilisateur.getPrenom()}" />"
													required>
											</div>

											<div class="form-label">
												<label for="pseudo" class="d-block fw-bold">Pseudo
													:</label> <input class="w-100 form-control-plaintext" type="text" id="pseudo"
													name="pseudo"
													readonly value="<c:out value="${utilisateur.getPseudo()}" />"
													required>
											</div>

											<div class="form-label">
												<label for="rue" class="d-block fw-bold">Rue
													:</label> <input class="w-100 form-control-plaintext" type="text" id="rue" name="rue"
													readonly value="<c:out value="${utilisateur.getRue()}" />" required>
											</div>

											<div class="form-label">
												<label for="ville" class="d-block fw-bold">Ville
													:</label> <input class="w-100 form-control-plaintext" type="text" id="ville" name="ville"
													readonly value="<c:out value="${utilisateur.getVille()}" />"
													required>
											</div>
										</div>
										<div class="col-12 col-md-6">
											<div class="form-label">
												<label for="codepostal" class="d-block fw-bold">Code
													postal :</label> <input class="w-100 form-control-plaintext" type="text" id="codepostal"
													name="codepostal"
													readonly value="<c:out value="${utilisateur.getCodePostal()}" />"
													required>
											</div>

											<div class="form-label">
												<label for="tel" class="d-block fw-bold">Télephone
													:</label> <input class="w-100 form-control-plaintext" type="text" id="tel" name="tel"
													readonly value="<c:out value="${utilisateur.getTelephone()}" />"
													required>
											</div>

											<div class="form-label">
												<label for="mail" class="d-block fw-bold">E-mail
													:</label> <input class="w-100 form-control-plaintext" type="email" id="mail" name="mail"
													readonly value="<c:out value="${utilisateur.getEmail()}" />"
													required>
											</div>

											<div class="form-label">
												<label for="mdp" class="d-block fw-bold">Mot
													de passe :</label> <input class="w-100 form-control-plaintext" type="password" id="mdp"
													name="mdp">

											</div>

											<div class="form-label">
												<p class="w-100" class="d-block" style="font-weight: bold">Crédits
													:</p>
												<p class="w-100" class="d-block">
													<c:out value="${utilisateur.getCredit()}"></c:out>
													<span style="font-weight: bold"> P$</span>
												</p>
											</div>
										</div>
									</div>
									<div class="mt-2">

										<button type="button" class="btn btn-secondary"
											id="updateAccount">modifier mon compte</button>
										<button type="submit" class="btn btn-primary d-none"
											id="submitAccount">sauvegarder les modifications</button>
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
								<h2 class="card-title">
									<c:out value="${utilisateur.getPrenom()}" />
									<c:out value="${utilisateur.getNom()}" />
								</h2>
								<p class="card-text">
									<span class="d-block fw-bold">Pseudo : </span> <span><c:out
											value="${utilisateur.getPseudo()}" /></span>
								</p>
								<p class="card-text">
									<span class="d-block fw-bold">Adresse : </span> <span>
										<c:out value="${utilisateur.getRue()}" /> <c:out
											value="${utilisateur.getVille()}" /> <c:out
											value="${utilisateur.getCodePostal()}" />
									</span>
								</p>
								<p class="card-text">
									<span class="d-block fw-bold">Tel : </span> <span>
										<c:out value="${utilisateur.getTelephone()}" />
									</span>
								</p>
								<p class="card-text">
									<span class="d-block fw-bold">Email : </span> <span>
										<c:out value="${utilisateur.getEmail()}" />
									</span>
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
</body>
<!-- Modal -->
<div class="modal fade" id="modal" tabindex="-1" role="dialog"
	aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<form action="<%=request.getContextPath()%>/DeleteUserById"
				method="post">
				<div class="modal-header">
					<h2 class="modal-title text-uppercase" id="exampleModalLongTitle">êtes
						vous sur de vouloir supprimer votre compte ?</h2>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<label for="passwordDelete" class="d-block">pour confirmer
						la suppression de votre compte, renseignez votre mot de passe :</label> <input
						type="password" id="passwordDelete" name="passwordDelete">
					<label for="userId"> <input type="hidden" id="userId"
						name="userId" value="<%=idConnectedUser%>">
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
<%
if (hasBeenUpdated) {
%>
<!-- Toast -->
<div class="toast" role="alert" aria-live="assertive" aria-atomic="true" data-delay="3000"
	style="position: absolute; top: 20px; right: 20px;">
	<div class="toast-header">
		<strong class="mr-auto text-primary">Modification utilisateur</strong>
		<button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
	</div>
	<div class="toast-body">Votre profil a bien été modifié</div>
</div>
<%
}
%>
</body>
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<%
if (hasBeenUpdated) {
%>
<script>
    $(document).ready(function () {
        $('.toast').toast('show');
    });
</script>
<%
}
%>
<script>
	const updateAccount = document.getElementById("updateAccount");
	const submitAccount = document.getElementById("submitAccount");
	const inputArray = [...document.querySelectorAll(".form-label input")]
	
	updateAccount.addEventListener("click", (e)=>{
	    inputArray.forEach((elem) => {
	        elem.removeAttribute("readonly");
	        elem.classList.remove("form-control-plaintext");
	        elem.classList.add("form-control");
	    })
	    e.target.classList.add("d-none");
	    submitAccount.classList.add("d-inline-block");
	    submitAccount.classList.remove("d-none");
	})
</script>
</html>