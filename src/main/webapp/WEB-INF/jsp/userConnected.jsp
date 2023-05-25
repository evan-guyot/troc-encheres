<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur" %>
<%
    Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
    Boolean hasBeenUpdated = (Boolean) request.getAttribute("hasBeenUpdated");
    Integer idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ENI - Encheres</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
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
        	<div class="mt-3 float-right">
        		<a
							href="<%=request.getContextPath() + "/"%>" class="btn btn-light">Accueil</a>
				<a href="utilisateur?id=<%=idConnectedUser%>" class="btn btn-primary" role="button" aria-pressed="true">Voir mon profil</a>
           		<a href="DeconnectionUtilisateur" class=" btn btn-dark" role="button" aria-pressed="true">Se déconnecter</a>
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
                        <%
                            if (idConnectedUser != null && idConnectedUser == Integer.parseInt(request.getParameter("id"))) {
                        %>
                        <div class="card-body">
                            <form action="<%=request.getContextPath()%>/utilisateur?id=<%=request.getParameter("id")%>"
                                  method="POST">
                                <div class="row">
                                    <div class="col-12 col-md-6">
                                        <div class="form-label">
                                            <label for="nom" class="d-block font-weight-bold">Nom :</label>
                                            <input class="w-100" type="text" id="nom" name="nom" value="<c:out value="${utilisateur.getNom()}" />" required>
                                        </div>

                                        <div class="form-label">
                                            <label for="prenom" class="d-block font-weight-bold">Prénom :</label>
                                            <input class="w-100" type="text" id="prenom" name="prenom" value="<c:out value="${utilisateur.getPrenom()}" />" required>
                                        </div>

                                        <div class="form-label">
                                            <label for="pseudo" class="d-block font-weight-bold">Pseudo :</label>
                                            <input class="w-100" type="text" id="pseudo" name="pseudo" value="<c:out value="${utilisateur.getPseudo()}" />" required>
                                        </div>

                                        <div class="form-label">
                                            <label for="rue" class="d-block font-weight-bold">Rue :</label>
                                            <input class="w-100" type="text" id="rue" name="rue" value="<c:out value="${utilisateur.getRue()}" />" required>
                                        </div>

                                        <div class="form-label">
                                            <label for="ville" class="d-block font-weight-bold">Ville :</label>
                                            <input class="w-100" type="text" id="ville" name="ville" value="<c:out value="${utilisateur.getVille()}" />" required>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <div class="form-label">
                                            <label for="codepostal" class="d-block font-weight-bold">Code postal :</label>
                                            <input class="w-100" type="text" id="codepostal" name="codepostal" value="<c:out value="${utilisateur.getCodePostal()}" />" required>
                                        </div>

                                        <div class="form-label">
                                            <label for="tel" class="d-block font-weight-bold">Télephone :</label>
                                            <input class="w-100" type="text" id="tel" name="tel" value="<c:out value="${utilisateur.getTelephone()}" />" required>
                                        </div>

                                        <div class="form-label">
                                            <label for="mail" class="d-block font-weight-bold">E-mail :</label>
                                            <input class="w-100" type="email" id="mail" name="mail" value="<c:out value="${utilisateur.getEmail()}" />" required>
                                        </div>

                                        <div class="form-label">
                                            <label for="mdp" class="d-block font-weight-bold">Mot de passe :</label> <input
                                                 class="w-100" type="password" id="mdp" name="mdp">
                                        </div>
                                        
                                        <div class="form-label">
                                            <p class="w-100" class="d-block" style="font-weight:bold">Crédits :</p> 
                                            <p class="w-100" class="d-block"><c:out value="${utilisateur.getCredit()}"></c:out><span style="font-weight:bold"> P$</span></p> 
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-2">
                                    <button type="submit" class="btn btn-primary">
                                        modifier mon compte
                                    </button>
                                    <button type="button" class="btn btn-primary"
                                            data-toggle="modal" data-target="#modal">supprimer
                                        mon compte
                                    </button>
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
</body>
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
                            data-dismiss="modal">Close
                    </button>
                    <button type="submit" class="btn btn-primary">supprimer
                        mon compte
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<%
    if (hasBeenUpdated) {
%>
<!-- Toast -->
<div class="toast" data-autohide="true" data-delay="3000" style="position: absolute; top: 20px; right: 20px;">
    <div class="toast-header">
        <strong class="mr-auto text-primary">Modification utilisateur</strong>
        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
    </div>
    <div class="toast-body">
        Votre profil a bien été modifié
    </div>
</div>
<%
    }
%>
</body>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
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
</html>