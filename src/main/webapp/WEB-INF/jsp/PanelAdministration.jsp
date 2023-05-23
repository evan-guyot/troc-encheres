<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Panel Admin</title>
</head>
<body>
<div class="container">
	<table class="table table-striped">
        <thead>
          <tr>
            <th>Pseudo</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Etat</th>
            <th>Supprimer</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Ganondorf</td>
            <td>Kiroul</td>
            <td>Pierre</td>
            <td><button type="button" class="btn btn-success">Désactiver</button></td>
            <td><button type="button" class="btn btn-danger">Supprimer</button></td>
          </tr>
        </tbody>
      </table>
</div>
</body>
</html>