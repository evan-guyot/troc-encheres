<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="fr.eni.trocenchere.bo.Article" %>
<%@ page import="fr.eni.trocenchere.bo.Categorie" %>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<%
    int idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
    Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
    int noCategorie = 0;

    String radioFilterParameter = (String) request.getAttribute("radioFilterParameter") != null
            ? (String) request.getAttribute("radioFilterParameter")
            : "";
    Boolean selectFilterParameter = (Boolean) request.getAttribute("selectFilterParameter") != null
            ? (Boolean) request.getAttribute("selectFilterParameter")
            : true;

    if (request.getAttribute("filtreCategorie") != null) {
        noCategorie = (int) request.getAttribute("filtreCategorie");
    }

    String nomArticle = (String) request.getAttribute("filtreArticle");
%>
<nav class="navbar navbar-expand-lg bg-body-secondary" data-bs-theme="dark">
    <div class="container-fluid">
        <div class="navbar-brand">
            <h1>
                <a class="nav-link active"
                   href="<%=request.getContextPath() + "/"%>"> ENI - Encheres </a>
            </h1>
        </div>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0" style="margin-left:auto;margin-right:5px!important">
                <li class="nav-item">
                    <a class="nav-link" aria-current="page" href="VendreArticle">Vendre un article</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="utilisateur?id=<%=idConnectedUser%>">Voir mon profil</a>
                </li>
                <% if (utilisateur.isAdministrateur()) { %>
                <li class="nav-item">
                    <a href="PanelAdministration" class="nav-link">
                        Administration
                    </a>
                </li>
                <% } %>
                <li class="nav-item">
                    <a class="nav-link" href="DeconnectionUtilisateur">Se déconnecter</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-12 mt-5">
            <h2 class="text-center">Liste des enchères</h2>
        </div>
        <div class="col-12">
            <form action="<%=request.getContextPath() + "/"%>" method="POST"
                  class="mt-5 mb-5">
                <div class="row">
                    <div class="col-12 col-md-6">
                        <div class="d-flex flex-wrap">
                            <div class="form-label w-100 order-2 order-md-1">
                                <label for="nomArticle">Filtres :</label>
                                <c:set var="filtreArticle" scope="page" value="${filtreArticle}"/>
                                <c:out value="${filtreArticle}"/>
                                <c:choose>
                                    <c:when test="${filtreArticle != null}">
                                        <input type="text" name="filtreArticle" id="filtreArticle"
                                               placeholder="le nom de l'article contient"
                                               value="<c:out value="${filtreArticle}"/>" class="w-100">
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" name="filtreArticle" id="filtreArticle"
                                               placeholder="le nom de l'article contient" class="w-100">
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="form-label w-100 order-3 order-md-2">
                                <label for="categorie">Catégories :</label>

                                <c:set var="filtreCategorie" scope="page" value="${filtreCategorie}"/>
                                <select class="w-100" name="filtreCategorie" id="filtreCategorie">
                                    <option value="0">Toutes les catégories</option>
                                    <c:forEach var="categorie" items="${categories}">
                                        <c:choose>
                                            <c:when test="${filtreCategorie == categorie.getNoCategorie()}">
                                                <option value="<c:out value='${categorie.getNoCategorie()}'/>" selected>
                                                    <c:out value="${categorie.getLibelle()}"/>
                                                </option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="<c:out value='${categorie.getNoCategorie()}'/>">
                                                    <c:out value="${categorie.getLibelle()}"/>
                                                </option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-label w-100 order-1 order-md-3">
                                <div class="row">
                                    <div class="col-12 col-md-8 col-lg-6">
                                        <div class="mt-3 radio_group radio_group_achat">
                                            <label for="1">Achat</label> <input type="radio"
                                                                                class="radio_select" id="1"
                                                                                name="select" value="1"
                                            <%=selectFilterParameter ? "checked" : ""%>>

												<div class="form-label">
													<label class="radio_elem" for="enchere_ouvertes">enchères ouvertes</label>
													<input class="radio_elem" type="radio"
														id="enchere_ouvertes" name="paramFilter"
														value="enchere_ouvertes"
														<%=radioFilterParameter.equalsIgnoreCase("enchere_ouvertes") ? "checked" : ""%>>
												</div>

                                            <div class="form-label">
                                                <label class="radio_elem" for="mes_encheres">mes
                                                    enchères</label> <input class="radio_elem" type="radio"
                                                                            id="mes_encheres" name="paramFilter"
                                                                            value="mes_encheres"
                                                <%=radioFilterParameter.equalsIgnoreCase("mes_encheres") ? "checked" : ""%>>
                                            </div>

                                            <div class="form-label">
                                                <label class="radio_elem" for="mes_encheres_remportes">mes
                                                    enchères remportées</label> <input class="radio_elem" type="radio"
                                                                                       id="mes_encheres_remportes"
                                                                                       name="paramFilter"
                                                                                       value="mes_encheres_remportes"
                                                <%=radioFilterParameter.equalsIgnoreCase("mes_encheres_remportes") ? "checked" : ""%>>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-8 col-lg-6">
                                        <div class="mt-3 radio_group radio_group_ventes">
                                            <label for="2">Mes ventes</label> <input type="radio"
                                                                                     class="radio_select" id="2"
                                                                                     name="select" value="2"
                                            <%=selectFilterParameter ? "" : "checked"%>>

                                            <div class="form-label">
                                                <label class="radio_elem" for="mes_ventes_en_cours">mes
                                                    ventes en cours</label> <input class="radio_elem" type="radio"
                                                                                   id="mes_ventes_en_cours"
                                                                                   name="paramFilter"
                                                                                   value="mes_ventes_en_cours"
                                                <%=radioFilterParameter.equalsIgnoreCase("mes_ventes_en_cours") ? "checked" : ""%>>
                                            </div>

                                            <div class="form-label">
                                                <label class="radio_elem" for="ventes_non_debutes">mes
                                                    ventes non débutées</label> <input class="radio_elem" type="radio"
                                                                                       id="ventes_non_debutes"
                                                                                       name="paramFilter"
                                                                                       value="ventes_non_debutes"
                                                <%=radioFilterParameter.equalsIgnoreCase("ventes_non_debutes") ? "checked" : ""%>>
                                            </div>

                                            <div class="form-label">
                                                <label class="radio_elem" for="ventes_terminees">mes ventes
                                                    terminées</label>
                                                <input class="radio_elem" type="radio" id="ventes_terminees"
                                                       name="paramFilter" value="ventes_terminees"
                                                    <%= radioFilterParameter.equalsIgnoreCase("ventes_terminees") ? "checked" : ""%>>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6">
                        <button class="btn btn-secondary mt-4" id="clear_filter" type="button">Effacer les filtres
                        </button>
                        <button class="btn btn-primary w-50 mt-4" type="submit">Rechercher</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-12">
            <ul class="list-unstyled row">
                <c:forEach var="article" items="${articles}">
                    <li class="col-12 col-sm-4 col-md-4 col-lg-3">
                        <div class="card mb-5">
                            <img class="card-img-top" src="https://picsum.photos/200/200"
                                 alt="Card image cap">
                            <div class="card-body">
                                <h2 class="card-title fw-bold">
                                    <c:out value="${article.getNom()}"/>
                                </h2>
                                <p class="card-text">
                                    <c:out value="${article.getDescription()}"/>
                                </p>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">
                                    <span class="fw-bold">Prix : </span>
                                    <c:choose>
                                        <c:when test="${article.getEnchere() != null}">
                                            <p style="color: blue; font-weight: 500;" class="card-text">
                                                <c:out value="${article.getEnchere().getMontantEnchere()}"/>
                                            </p>
                                        </c:when>
                                        <c:otherwise>
                                            <p style="color: blue; font-weight: 500;" class="card-text">
                                                <c:out value="${article.getMiseAPrix()}"/>
                                            </p>
                                        </c:otherwise>
                                    </c:choose>
                                </li>
                                <li class="list-group-item">
                                    <span class="fw-bold">Fin enchères : </span>
                                    <c:out value="${article.getDateFinEnchere()}"/>
                                </li>
                                <li class="list-group-item">
                                    <span class="fw-bold">Vendeur : </span>
                                    <a href="<c:out value="${request.getContextPath()}utilisateur?id=${article.getUtilisateur().getNoUtilisateur()}"/>">
                                        <span><c:out value="${article.getUtilisateur().getPseudo()}"/></span>
                                    </a>
                                </li>
                            </ul>
                            <div class="card-body">
                                <c:set var="connectedUser" scope="page" value="${connectedUserId}"/>
                                <c:choose>
                                    <c:when test="${article.getUtilisateur().getNoUtilisateur() != connectedUser}">
                                        <c:choose>
                                            <c:when test="${article.getDateFinEnchere().isAfter(LocalDate.now())}">
                                                <a href="Encherir?id=<c:out value="${article.getNoArticle()}"/>"
                                                   class="Encherir btn btn-primary">Enchérir</a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="FinEnchere?id=<c:out value="${article.getNoArticle()}"/>"
                                                   class="Encherir btn btn-primary">Fiche article</a>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="Encherir?id=<c:out value="${article.getNoArticle()}"/>"
                                           class="Encherir btn btn-primary">Voir Article</a>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${article.getUtilisateur().getNoUtilisateur() == connectedUserId && article.getDateDebutEnchere().isAfter(LocalDate.now())}">
                                    <a class="btn btn-outline-primary"
                                       href="<c:out value="ModifierVente?id=${article.getNoArticle()}"/>"
                                       role="button">Modifier</a>
                                </c:if>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
</div>
</body>
<style>
    .radio_elem {
        pointer-events: none;
        color: #999;
    }

    .radio_select:checked ~ .form-label input {
        pointer-events: all;
    }

    .radio_select:checked ~ .form-label label {
        color: #212529;
        pointer-events: all;
    }
</style>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const radio_input = [...document.querySelectorAll(".radio_group > input[type=radio]")];
    const radio_group_ventes = [...document.querySelectorAll(".radio_group_ventes input[type=radio]")];
    const radio_group_achat = [...document.querySelectorAll(".radio_group_achat input[type=radio]")];
    const button_clear_filters = document.getElementById("clear_filter");
    const filtre_article = document.getElementById("filtreArticle");
    const filtre_categorie = document.getElementById("filtreCategorie");
    const first_input = document.getElementById("1");
    const second_input = document.getElementById("2");
    const enchere_ouvertes = document.getElementById("enchere_ouvertes");
    const mes_ventes_en_cours = document.getElementById("mes_ventes_en_cours");

    function uncheck(elems) {
        elems.map(elem => {
            elem.checked = false;
        })
    }

    button_clear_filters.addEventListener("click", () => {
        uncheck([...radio_group_ventes, ...radio_group_achat]);
        first_input.checked = true;
		enchere_ouvertes.checked = true;
        filtre_article.value = "";
        filtre_categorie.value = 0;
    });

    radio_input.forEach(elem => {
        elem.addEventListener("change", (e) => {
            if (e.target.value === "1") {
                uncheck(radio_group_ventes);
            } else {
                uncheck(radio_group_achat);
            }
        });
    })

	first_input.addEventListener("change", ()=> { enchere_ouvertes.checked = true; })
	second_input.addEventListener("change", ()=> { mes_ventes_en_cours.checked = true; })
</script>
</html>