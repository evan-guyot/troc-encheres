INSERT INTO UTILISATEURS VALUES ('TomDu44', 'Gentereau', 'Tom', 'tgentereau@yahoo.com', '0215568457','rue des baobabs','85140','Potatoville','tom44',400, 0, 1);
INSERT INTO UTILISATEURS VALUES ('JeanneLaBg', 'Bonbeurre', 'Jeanne', 'jbonbeurre@ygmail.com', '0285749654','allée des gens heureux','75420','Babouinland','jeannette',2500, 0, 1);
INSERT INTO UTILISATEURS VALUES ('Totoche', 'Charlier', 'Christophe', 'ccharlier@yahoo.com', '068754842','rue tabaga','13540','Taratata','tom44',400, 0, 1);
INSERT INTO UTILISATEURS VALUES ('Pokemaster', 'Dupont', 'Martin', 'Martin.Dupont.md@gmail.com', '0685412374', '44 rue du du pneu', '29740', 'Plouhinec', 'admin123', 350000, 1, 1);
INSERT INTO UTILISATEURS VALUES('Therock', 'Dwain', 'Jonson', 'dwainjonson@eni.fr', '0606060606', 'place de la croix bonneaux', '44100', 'nantes', 'motDePasseSuperDur', 3954, 0, 1);
INSERT INTO UTILISATEURS VALUES('RubisScube', 'Ofraiz', 'Charlotte', 'CharloOf@Orange.fr', '0698654186', 'rue du temple', '44100', 'nantes', 'sdfdsgg', 8542, 0, 1);

INSERT INTO CATEGORIES VALUES ('Autres');
INSERT INTO CATEGORIES VALUES ('Jouets');
INSERT INTO CATEGORIES VALUES ('Véhicules');
INSERT INTO CATEGORIES VALUES ('Vêtements');
INSERT INTO CATEGORIES VALUES ('Meubles');
INSERT INTO CATEGORIES VALUES ('Livre');
INSERT INTO CATEGORIES VALUES ('Jardinage');
INSERT INTO CATEGORIES VALUES ('Numérique');

INSERT INTO ARTICLES_VENDUS VALUES ('Trottinette qui va vite','Super trot de 2015 en moyen état qui va encore méga viiiite !!', '19/05/2023','29/05/2023',300,150,2,3);
INSERT INTO ARTICLES_VENDUS VALUES ('Barbie en mode sexy','Ma super barbie troo kawai UwU toute rose et mignonne que j ai depuis 6ans', '19/05/2023','01/06/2023',25,5,2,2);
INSERT INTO ARTICLES_VENDUS VALUES ('Commode', 'Je vends la commode de ma belle mère, bon état et un peu poussièreuse','16/05/2023','15/06/2023',400,105,3,5);
INSERT INTO ARTICLES_VENDUS VAlUES ('Pull en laine Hulk','Mon pull térifiant Hulk, ca donne trop de charisme pour draguer des minettes','03/06/2023','15/06/2023',25,8,1,4)
INSERT INTO ARTICLES_VENDUS VAlUES ('Chaussettes verte','Chaussettes neuves jamais portées','06/05/2023','17/05/2023',30,5,1,4)
INSERT INTO ARTICLES_VENDUS VALUES ('Coffret Stargate-SG1','Edition collector des plus beaux films de la saga, 12 DVD, plus de 250h plus 5 hors séries', '19/05/2023','28/06/2023', 45, 150, 5, 8);

INSERT INTO RETRAITS VALUES (1,'rue de la tartinade','69140', 'Lyon');
INSERT INTO RETRAITS VALUES (2,'rue de la tartinade','69140', 'Lyon');
INSERT INTO RETRAITS VALUES (3,'rue de la moissonerie','50470', 'Cherbourg');
INSERT INTO RETRAITS VALUES (4,'rue des baobabs','05140', 'Potatoville');
INSERT INTO RETRAITS VALUES (5,'rue des baobabs','5140', 'Potatoville');
INSERT INTO RETRAITS VALUES (6,'rue haricots','29740', 'Plouhinec');

INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-22 10:34:23', 120), 305,1,3);
INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-22 19:38:59', 120) ,326,1,3);
INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-12 18:47:31', 120) ,36,4,2);
