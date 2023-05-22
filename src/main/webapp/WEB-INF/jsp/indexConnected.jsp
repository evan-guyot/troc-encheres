<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="fr.eni.trocenchere.bo.Article" %>
<%@ page import="fr.eni.trocenchere.bo.Categorie" %>
<%@ page import="fr.eni.trocenchere.bo.Utilisateur"%>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ENI - Encheres</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<%
		int idConnectedUser = (int) request.getSession().getAttribute("connectedUserId");
		Utilisateur utilisateur = (Utilisateur) request.getAttribute("utilisateur");
        int noCategorie = 0;

        if (request.getAttribute("filtreCategorie") != null) {
            noCategorie = (int) request.getAttribute("filtreCategorie");
        }

        String nomArticle = (String) request.getAttribute("filtreArticle");
    %>
    <div class="row">
        <div class="col-6">
            <h1>
                <a class="text-secondary text-decoration-none" href="<%=request.getContextPath() + "/"%>">ENI -
                    Encheres</a>
            </h1>
        </div>
        <div class="col-6">
            <%
				if (utilisateur.isAdministrateur()) {
				%>
				<a href="PanelAdministration" class="btn btn-warning "
					role="button" aria-pressed="true" style="color:white!important;background-color:orange">Administration</a>
				<%
				}
				%>
				<a class="btn btn-success"  role="button" aria-pressed="true"  href="VendreArticle">Vendre un article</a>
                <a href="utilisateur?id=<%=idConnectedUser%>" class="btn btn-primary" role="button" aria-pressed="true">Voir
                    mon profil</a>
                <a href="DeconnectionUtilisateur" class=" btn btn-secondary" role="button" aria-pressed="true">Se
                    déconnecter</a>

        </div>
        <div class="col-12">
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

                                <%
                                    if (nomArticle != null) {
                                %>
                                <input type="text" name="filtreArticle" id="filtreArticle"
                                       placeholder="le nom de l'article contient"
                                       value="<%=nomArticle%>" class="w-100">

                                <%
                                } else {
                                %>
                                <input type="text" name="filtreArticle" id="filtreArticle"
                                       placeholder="le nom de l'article contient" class="w-100">
                                <%
                                    }
                                %>
                            </div>

                            <div class="form-label w-100 order-3 order-md-2">
                                <label for="categorie">Catégories :</label>
                                <select class="w-100"
                                        name="filtreCategorie" id="filtreCategorie">
                                    <option value="0">Toutes les catégories</option>
                                    <%
                                        for (Categorie categorie : (List<Categorie>) request.getAttribute("categories")) {
                                            if (noCategorie == categorie.getNoCategorie()) {
                                    %>

                                    <option value="<%=categorie.getNoCategorie()%>" selected><%=categorie.getLibelle()%>
                                    </option>
                                    <%
                                    } else {
                                    %>

                                    <option value="<%=categorie.getNoCategorie()%>"><%=categorie.getLibelle()%>
                                    </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-label w-100 order-1 order-md-3">
                                <div class="row">
                                    <div class="col-12 col-md-8 col-lg-6">
                                        <div class="mt-3 radio_group radio_group_achat">
                                            <label for="1">Achat</label>
                                            <input type="radio" class="radio_select" id="1" name="select" value="1"
                                                   checked>

                                            <div class="form-label">
                                                <label class="radio_elem" for="enchere_ouvertes">enchères
                                                    ouvertes</label>
                                                <input class="radio_elem" type="radio" id="enchere_ouvertes"
                                                       name="select-1" value="enchere_ouvertes">
                                            </div>

                                            <div class="form-label">
                                                <label class="radio_elem" for="mes_enchere">mes enchères</label>
                                                <input class="radio_elem" type="radio" id="mes_enchere"
                                                       name="select-1" value="mes_enchere">
                                            </div>

                                            <div class="form-label">
                                                <label class="radio_elem" for="mes_enchere_remportes">mes enchères
                                                    remportées</label>
                                                <input class="radio_elem" type="radio" id="mes_enchere_remportes"
                                                       name="select-1" value="mes_enchere_remportes">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-8 col-lg-6">
                                        <div class="mt-3 radio_group radio_group_ventes">
                                            <label for="2">Mes ventes</label>
                                            <input type="radio" class="radio_select" id="2" name="select" value="2">

                                            <div class="form-label">
                                                <label class="radio_elem" for="mes_ventes_en_cours">mes ventes en
                                                    cours</label>
                                                <input class="radio_elem" type="radio" id="mes_ventes_en_cours"
                                                       name="select-2" value="mes_ventes_en_cours">
                                            </div>

                                            <div class="form-label">
                                                <label class="radio_elem" for="ventes_non_debutes">ventes non
                                                    débutées</label>
                                                <input class="radio_elem" type="radio" id="ventes_non_debutes"
                                                       name="select-2" value="ventes_non_debutes">
                                            </div>

                                            <div class="form-label">
                                                <label class="radio_elem" for="ventes_terminees">ventes
                                                    terminées</label>
                                                <input class="radio_elem" type="radio" id="ventes_terminees"
                                                       name="select-2" value="ventes_terminees">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-md-6">
                        <button class="btn btn-primary w-100 mt-4" type="submit">Rechercher</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="col-12">
            <ul class="list-unstyled row">
                <%
                    for (Article article : (List<Article>) request.getAttribute("articles")) {
                %>
                <li class="col-12 col-md-4 col-lg-3">
                    <div class="card mb-5">
                        <img class="card-img-top" src="https://picsum.photos/200/300"
                             alt="Card image cap">
                        <div class="card-body">
                            <h2 class="card-title fw-bold"><%=article.getNom()%>
                            </h2>
                            <p class="card-text"><%=article.getDescription()%>
                            </p>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><span class="fw-bold">Prix
									: </span> <% if (article.getEnchere() != null) {
 %>									<p style="color: blue; font-weight: 500;" class="card-text">
											<%=article.getEnchere().getMontantEnchere()%></p>
<%
 } else {%>
											<p style="color: blue; font-weight: 500;" class="card-text"><%=article.getMiseAPrix()%>
                            </p><%
									}
									%></li>
                            <li class="list-group-item"><span class="fw-bold">Fin
									enchères : </span><%=article.getDateFinEnchere()%>
                            </li>
                            <li class="list-group-item">
                                <span class="fw-bold">Vendeur : </span>
                                <a href="<%=request.getContextPath() + "/utilisateur?id=" + article.getUtilisateur().getNoUtilisateur()%>">
                                    <span><%=article.getUtilisateur().getPseudo()%></span>
                                </a></li>
                        </ul>
                        <div class="card-body">
                            <%
								if (article.getDateFinEnchere().isAfter(LocalDate.now())) {
								%>
								<a href="Encherir?id=<%=article.getNoArticle()%>"
									class="Encherir btn btn-primary">Enchérir</a>
                            <%
								} else {
								%>
								<a href="FinEnchere?id=<%=article.getNoArticle()%>" class="Encherir btn btn-primary">Fiche article</a>
								<%
								}
								%>
                        </div>
                    </div>
                </li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>
</div>
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
<script>
    const radio_input = [...document.querySelectorAll(".radio_group > input[type=radio]")];
    const radio_group_ventes = [...document.querySelectorAll(".radio_group_ventes input[type=radio]")]
    const radio_group_achat = [...document.querySelectorAll(".radio_group_achat input[type=radio]")]

    function uncheck(elems) {
        elems.map(elem => {
            elem.checked = false;
        })
    }

    radio_input.forEach(elem => {
        elem.addEventListener("change", (e) => {
            if (e.target.value === "1") {
                uncheck(radio_group_ventes);
            } else {
                uncheck(radio_group_achat);
            }
        });
    })
</script>
</body>
</html>