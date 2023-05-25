INSERT INTO UTILISATEURS VALUES ('TomDu44', 'Gentereau', 'Tom', 'tgentereau@yahoo.com', '0215568457','rue des baobabs','85140','Potatoville','tom44',6000, 0, 1);
INSERT INTO UTILISATEURS VALUES ('JeanneLaBg', 'Bonbeurre', 'Jeanne', 'jbonbeurre@ygmail.com', '0285749654','allée des gens heureux','75420','Babouinland','jeannette',2500, 0, 1);
INSERT INTO UTILISATEURS VALUES ('Totoche', 'Charlier', 'Christophe', 'ccharlier@yahoo.com', '068754842','rue tabaga','13540','Taratata','tom44',453, 0, 1);
INSERT INTO UTILISATEURS VALUES ('Pokemaster', 'Dupont', 'Martin', 'Martin.Dupont.md@gmail.com', '0685412374', '44 rue du du pneu', '29740', 'Plouhinec', 'admin123', 654123, 1, 1);
INSERT INTO UTILISATEURS VALUES('Therock', 'Dwain', 'Jonson', 'dwainjonson@eni.fr', '0606060606', 'place de la croix bonneaux', '44100', 'nantes', 'motDePasseSuperDur', 3954, 0, 1);
INSERT INTO UTILISATEURS VALUES('RubisScube', 'Ofraiz', 'Charlotte', 'CharloOf@Orange.fr', '0698654186', 'rue du temple', '44100', 'nantes', 'sdfdsgg', 8542, 0, 1);
INSERT INTO UTILISATEURS VALUES('xXFortniteXx', 'Frejus', 'Jimmy', 'Jimmy@voila.fr', '0698943186', 'Impasse du souterrain', '93200', 'Paris', 'XxsqueezieX', 268, 0, 1);
INSERT INTO UTILISATEURS VALUES('AcdcRockanRoll', 'Perrat', 'Axel', 'AxelP@gmail.com', '0794563786', 'rue du moulin bleu', '64200', 'Toulouse', 'a45sqz4f', 7954, 0, 1);
INSERT INTO UTILISATEURS VALUES('Fafarouche', 'Kiwito', 'Giles', 'asperge78@gmail.com', '0648513354', '5 Boulevard des tribunes', '94231', 'Marseille', '123', 84561, 1, 1);

INSERT INTO CATEGORIES VALUES ('Autres');
INSERT INTO CATEGORIES VALUES ('Jouets');
INSERT INTO CATEGORIES VALUES ('Véhicules');
INSERT INTO CATEGORIES VALUES ('Vêtements');
INSERT INTO CATEGORIES VALUES ('Meubles');
INSERT INTO CATEGORIES VALUES ('Livre');
INSERT INTO CATEGORIES VALUES ('Jardinage');
INSERT INTO CATEGORIES VALUES ('Numérique');

INSERT INTO ARTICLES_VENDUS VALUES ('Trottinette qui va vite','Super trot de 2015 en moyen état qui va encore méga viiiite !!', '19/05/2023','29/05/2023',300,150,2,3);
INSERT INTO ARTICLES_VENDUS VALUES ('Figurine Star Wars','Figurine sous blister état neuf', '19/05/2023','01/06/2023',25,5,2,2);
INSERT INTO ARTICLES_VENDUS VALUES ('Commode', 'Je vends la commode de ma belle mère, bon état et un peu poussièreuse','16/05/2023','15/06/2023',400,105,3,5);
INSERT INTO ARTICLES_VENDUS VAlUES ('Pull en laine Hulk','Mon pull térrifiant Hulk, porté 2 fois','03/06/2023','15/06/2023',25,8,1,4)
INSERT INTO ARTICLES_VENDUS VAlUES ('Chaussettes verte','Chaussettes neuves jamais portées','06/05/2023','17/05/2023',30,5,1,4)
INSERT INTO ARTICLES_VENDUS VALUES ('Coffret Stargate-SG1','Edition collector des plus beaux films de la saga, 12 DVD, plus de 250h plus 5 hors séries', '19/05/2023','28/06/2023', 45, 150, 5, 8);
INSERT INTO ARTICLES_VENDUS VALUES ('Tondeuse à gazon Harribot','Tondeuse pour gazon de la marque Harribot, bon état, vendu avec le plein', '22/05/2023','13/06/2023', 55, 150, 8, 7);
INSERT INTO ARTICLES_VENDUS VALUES ('Vélo de ville rouge (taille Adulte)','Vélo de ville de couleur rouge, c'est un vélo taille adulte, les pneux sont neuf', '24/05/2023','15/06/2023', 125, 150, 3, 7);

INSERT INTO RETRAITS VALUES (1,'rue de la tartinade','69140', 'Lyon');
INSERT INTO RETRAITS VALUES (2,'rue de la tartinade','69140', 'Lyon');
INSERT INTO RETRAITS VALUES (3,'rue de la moissonerie','50470', 'Cherbourg');
INSERT INTO RETRAITS VALUES (4,'rue des baobabs','05140', 'Potatoville');
INSERT INTO RETRAITS VALUES (5,'rue des baobabs','5140', 'Potatoville');
INSERT INTO RETRAITS VALUES (6,'rue haricots','29740', 'Plouhinec');
INSERT INTO RETRAITS VALUES (7,'Place des troubadours','44300', 'Nantes');
INSERT INTO RETRAITS VALUES (8,'Parking ENI edition','44300', 'Nantes');

INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-22 10:34:23', 120), 305,1,3);
INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-22 19:38:59', 120) ,326,1,3);
INSERT INTO ENCHERES VALUES (CONVERT(datetime, '2023-05-12 18:47:31', 120) ,36,4,2);
