-- Création de la base de données
CREATE DATABASE IF NOT EXISTS garage_ecf;
USE garage_ecf;

-- Création de la table attributionrank avec optimisations
CREATE TABLE IF NOT EXISTS attributionrank (
  id INT(11) PRIMARY KEY,
  rank VARCHAR(255) UNIQUE NOT NULL
);

-- Insertion des valeurs dans la table attributionrank avec INSERT IGNORE
INSERT IGNORE INTO attributionrank (id, rank) VALUES
(1, 'Administrateur'),
(2, 'Employé');


-- Création de la table carburants avec optimisations
CREATE TABLE IF NOT EXISTS carburants (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  carburant VARCHAR(45) UNIQUE NOT NULL
);

-- Insertion des valeurs dans la table carburants
INSERT INTO carburants (carburant) VALUES
('ESSENCE SANS PLOMB'),
('DIESEL'),
('GPL'),
('BIOÉTHANOL'),
('BIODIESEL'),
('GAZ NATUREL COMPRESSÉ (GNC)'),
('HYDROGÈNE'),
('ÉLECTRIQUE')
ON DUPLICATE KEY UPDATE carburant = carburant; 
-- Pour éviter les doublons --


-- Création de la table contacts avec optimisations
CREATE TABLE IF NOT EXISTS contacts (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(255) NOT NULL,
  prenom VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  telephone VARCHAR(20) UNIQUE,
  message TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  -- DEFAULT CURRENT_TIMESTAMP remplit automatiquement created_at avec la date et l'heure actuelles --
);

-- Insertion des valeurs dans la table contacts
INSERT INTO contacts (nom, prenom, email, telephone, message) VALUES
('Dupond', 'Jean', 'jean@dupond.fr', '0611223344', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
('Proud', 'Jannot', 'proud@jannot.fr', '0699887766', 'Maecenas ullamcorper turpis at diam aliquet, nec pharetra nulla rhoncus.'),
('Loob', 'Jhana', 'loob@jhana.com', '0789289219', 'Suspendisse potenti. Sed dictum enim vitae lacus venenatis.'),
('Dujon', 'Gerald', 'dujon@gerald.fr', '0798979496', 'Vestibulum tincidunt quam mi, eget pharetra lectus efficitur eget.');

-- Création de la table couleurs
CREATE TABLE IF NOT EXISTS couleurs (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  couleur VARCHAR(45) UNIQUE
);

-- Insertion des valeurs dans la table couleurs
INSERT INTO couleurs (couleur) VALUES
('blanc'),
('noir'),
('bleu'),
('rouge'),
('jaune'),
('orange'),
('vert'),
('rose'),
('marron'),
('violet'),
('gris'),
('turquoise'),
('bordeau'),
('bleu marine'),
('bleu ciel'),
('mauve'),
('ocre'),
('silver');

-- Création de la table employ
CREATE TABLE IF NOT EXISTS employ (
  Id INT(11) AUTO_INCREMENT PRIMARY KEY,
  FirstName VARCHAR(255),
  LastName VARCHAR(255),
  Birthday DATE,
  email VARCHAR(255) UNIQUE,
  password VARCHAR(255),
  role_id INT(11)
);

-- Insertion des valeurs dans la table employ
INSERT INTO employ (FirstName, LastName, Birthday, email, password, role_id) VALUES
('Vincent', 'Parrot', '1980-01-10', 'vincent.parrot@garage.com', '$2y$10$yUlWBTS81ml0jNzDLZc7eO/LyUWAk4yA6AviFTUVusDY/Q5/erQxO', 1),
('John', 'Doe', '1995-05-10', 'john.doe@garage.com', '$2y$10$HPstw4rmynO6msB7JtS/7uhPyVG1db0GPYxIuPJbg4ouX2cXfpmfO', 2),
('janna', 'beld', NULL, 'janna@beld.com', '$2y$10$2jwPvhjRY.lbQrHOB.H98eBXbujIA.qsWcuQkSia9f8vWUNGsoWry', 2);

-- Ajout de la clé étrangère role_id dans la table employ
ALTER TABLE employ
ADD CONSTRAINT fk_employ_role
FOREIGN KEY (role_id)
REFERENCES attributionrank(id);

-- Création de la table equipements
CREATE TABLE IF NOT EXISTS equipements (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  equipement VARCHAR(255) UNIQUE
);

-- Insertion des valeurs dans la table equipements
INSERT INTO equipements (equipement) VALUES
('Système de navigation GPS'),
('Caméra de recul'),
('Système Bluetooth pour les appels mains libres'),
('Aide au stationnement avec capteurs de proximité'),
('Régulateur de vitesse adaptatif'),
('Système d''assistance au maintien de voie'),
('Sièges chauffants'),
('Volant chauffant'),
('Système de surveillance des angles morts'),
('Détecteur de collision avant avec freinage automatique d''urgence'),
('Toit panoramique'),
('Système audio haut de gamme'),
('Connexion Wi-Fi intégrée'),
('Sièges en cuir'),
('Éclairage d''ambiance personnalisable'),
('Démarrage sans clé'),
('Système de démarrage à distance'),
('Système de divertissement arrière avec écrans intégrés aux appuie-têtes'),
('Phares adaptatifs'),
('Système d''assistance au stationnement automatique');

-- Création de la table gearbox
CREATE TABLE IF NOT EXISTS gearbox (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  boite_de_vitesse VARCHAR(45) UNIQUE
);

-- Insertion des valeurs dans la table gearbox
INSERT INTO gearbox (boite_de_vitesse) VALUES
('Boîte de vitesses manuelle'),
('Boîte de vitesses automatique'),
('Boîte de vitesses semi-automatique'),
('Boîte de vitesses à variation continue (CVT)');

-- Création de la table horaires
CREATE TABLE IF NOT EXISTS horaires (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  jours VARCHAR(45),
  ouverture TIME,
  fermeture TIME,
  UNIQUE (jours)
);

-- Insertion des valeurs dans la table horaires
INSERT INTO horaires (jours, ouverture, fermeture) VALUES
('Lundi', '08:00:00', '18:00:00'),
('Mardi', '08:00:00', '18:00:00'),
('Mercredi', '08:00:00', '18:00:00'),
('Jeudi', '08:00:00', '18:00:00'),
('Vendredi', '08:00:00', '18:00:00'),
('Samedi', '09:00:00', '13:00:00'),
('Dimanche', NULL, NULL);

-- Création de la table services
CREATE TABLE IF NOT EXISTS services (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  paragraphe LONGTEXT,
  UNIQUE (title)
);

-- Insertion des valeurs dans la table services
INSERT INTO services (title, paragraphe) VALUES
('Révision de voiture', 'L''intervalle entre deux révisions de votre voiture dépend inévitablement de la marque de la voiture et de sa motorisation. Le carnet d''entretien fourni par le constructeur doit vous indiquer à quel moment réaliser une révision ou une intervention d...'),
('Réparation mécanique', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.'),
('Entretien régulier', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.');

-- Création de la table temoignages
CREATE TABLE IF NOT EXISTS temoignages (
  id INT(11) AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(255),
  commentaire TEXT,
  note INT(11),
  valide INT(11),
  UNIQUE (nom)
);

-- Insertion des valeurs dans la table temoignages
INSERT INTO temoignages (nom, commentaire, note, valide) VALUES
('Mr Bean''s', 'Il a rien dit mais semblé être ravis', 5, 1),
('Jamis LT', 'Trés bon garage !', 4, 1),
('Pat Olive', 'Très bonne adresse', 3, 1),
('Pitch Oune', 'Merci beaucoup vous êtes tous super aimable', 5, 1),
('Jacki Chan', 'On ne m''a pas laisser faire de cascade mais le service reste très agréable, je recommande !', 3, 1),
('Mickel Sch', 'Les voitures d''occasion proposé sont très bien entretenu', 4, 1),
('Harricot Beurre', 'Une qualité de service envoutante !', 3, 1),
('Yod hah', 'Très bon, ce garage il est', 4, 1),
('Luffy M.D', 'Une belle surprise les véhicule d''occasion !', 3, 1),
('Saitama', 'J''avais détruit ma voiture et ils l''ont réparé en un coup de main !', 4, 1),
('Jacques Poireau', 'Les cacahouètes sont excellente a l''accueille', 3, 1),
('Tonton F', 'Vous êtes aux top continué comme ça !', 5, 1),
('Olive & T', 'Service a la hauteur de nos attente, merci l''équipe !', 4, 0),
('Forrest Gump', 'C''est du rapide', 3, 0),
('Ally McBeal', 'Ce garage est tout simplement incroyable ! Un service impeccable, des mécaniciens compétents et des tarifs compétitifs. Je ne pourrais pas être plus satisfaite de mes visites ici. Recommandé à 100%', 4, 0);

-- Création de la table vente_occasion si elle n'existe pas déjà
CREATE TABLE IF NOT EXISTS vente_occasion (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    marque VARCHAR(255),
    modele VARCHAR(255),
    prix DECIMAL(10, 2),
    annee INT(11),
    kilometrage INT(11),
    image VARCHAR(255),
    carburant VARCHAR(255),
    couleur VARCHAR(255),
    boite_de_vitesse VARCHAR(255),
    liste_equipements TEXT,
    gallery1 VARCHAR(255),
    gallery2 VARCHAR(255),
    gallery3 VARCHAR(255),
    UNIQUE (marque, modele, prix, annee)
);


-- Insertion des valeurs dans la table vente_occasion
INSERT INTO vente_occasion (marque, modele, prix, annee, kilometrage, image, carburant, couleur, boite_de_vitesse, liste_equipements, gallery1, gallery2, gallery3) VALUES
('McLaren', '720S', 200000.00, 2020, 15000, 'images/mclaren.jpeg', 'Essence', 'Rouge', 'Automatique', 'Climatisation, GPS, Caméra de recul', 'images/mclaren1-1.jpg', 'images/mclaren1-2.jpeg', 'images/mclaren1-3.jpeg'),
('Toyota', 'Camry', 30000.00, 2021, 10000, 'images/toyota.jpg', 'Essence', 'Noir', 'Automatique', 'Climatisation, Bluetooth', 'images/toyota1-1.jpeg', 'images/toyota1-2.jpg', 'images/toyota1-3.jpg'),
('Volkswagen', 'Golf', 25000.00, 2020, 12000, 'images/volkswagen.jpg', 'Diesel', 'Blanc', 'Manuelle', 'GPS, Régulateur de vitesse', 'images/volkswagen1-1.jpeg', 'images/volkswagen1-2.jpg', 'images/volkswagen1-3.jpeg'),
('Ford', 'Focus', 22000.00, 2019, 18000, 'images/ford.jpeg', 'Essence', 'Bleu', 'Automatique', 'Climatisation', 'images/ford1-1.jpeg', 'images/ford1-2.jpeg', 'images/ford1-3.jpeg'),
('Honda', 'Civic', 20000.00, 2018, 22000, 'images/honda.jpeg', 'Essence', 'Gris', 'Manuelle', 'Bluetooth, Caméra de recul', 'images/honda1-1.jpeg', 'images/honda1-2.jpeg', 'images/honda1-3.jpeg'),
('Chevrolet', 'Impala', 25000.00, 2017, 30000, 'images/chevrolet.jpeg', 'Essence', 'Rouge', 'Automatique', 'Climatisation, GPS', 'images/chevrolet1-1.jpeg', 'images/chevrolet1-2.jpeg', 'images/chevrolet1-3.jpeg'),
('Nissan', 'Altima', 24000.00, 2019, 15000, 'images/nissan.jpeg', 'Essence', 'Noir', 'Automatique', 'Bluetooth, Climatisation', 'images/nissan1-1.jpeg', 'images/nissan1-2.jpeg', 'images/nissan1-3.jpeg'),
('BMW', '320i', 35000.00, 2021, 5000, 'images/bmw.jpeg', 'Essence', 'Blanc', 'Automatique', 'GPS, Régulateur de vitesse', 'images/bmw1-1.jpeg', 'images/bmw1-2.jpeg', 'images/bmw1-3.jpeg'),
('Mercedes-Benz', 'C-Class', 40000.00, 2020, 8000, 'images/mercedes.jpg', 'Essence', 'Argent', 'Automatique', 'Climatisation, Caméra de recul', 'images/mercedes1-1.jpg', 'images/mercedes1-2.jpeg', 'images/mercedes1-3.jpeg'),
('Audi', 'A4', 37000.00, 2019, 12000, 'images/audi.jpeg', 'Essence', 'Noir', 'Automatique', 'GPS, Bluetooth', 'images/audi1-1.jpeg', 'images/audi1-2.jpeg', 'images/audi1-3.jpeg'),
('Hyundai', 'Elantra', 19000.00, 2021, 7000, 'images/hyundai.jpeg', 'Essence', 'Bleu', 'Manuelle', 'Climatisation', 'images/hyundai1-1.jpeg', 'images/hyundai1-2.jpeg', 'images/hyundai1-3.jpeg'),
('Kia', 'Optima', 22000.00, 2018, 15000, 'images/kia.jpeg', 'Essence', 'Rouge', 'Automatique', 'GPS, Bluetooth', 'images/kia1-1.jpeg', 'images/kia1-2.jpeg', 'images/kia1-3.jpeg'),
('Tesla', 'Model 3', 35000.00, 2022, 3000, 'images/tesla.jpg', 'Électrique', 'Noir', 'Automatique', 'Climatisation, GPS', 'images/tesla1-1.jpeg', 'images/tesla1-2.jpg', 'images/tesla1-3.jpeg'),
('Subaru', 'Impreza', 24000.00, 2020, 12000, 'images/subaru.jpeg', 'Essence', 'Bleu', 'Manuelle', 'Caméra de recul', 'images/subaru1-1.jpeg', 'images/subaru1-2.jpeg', 'images/subaru1-3.jpeg'),
('Mazda', 'Mazda3', 23000.00, 2021, 9000, 'images/mazda.jpeg', 'Essence', 'Noir', 'Automatique', 'Climatisation, Bluetooth', 'images/mazda1-1.jpeg', 'images/mazda1-2.jpeg', 'images/mazda1-3.jpeg'),
('Fiat', '500', 15000.00, 2019, 18000, 'images/fiat.jpeg', 'Essence', 'Rouge', 'Manuelle', 'Climatisation', 'images/fiat1-1.jpeg', 'images/fiat1-2.jpeg', 'images/fiat1-3.jpeg'),
('Renault', 'Clio', 12000.00, 2020, 20000, 'images/renault.jpeg', 'Essence', 'Blanc', 'Automatique', 'Bluetooth', 'images/renault1-1.jpeg', 'images/renault1-2.jpeg', 'images/renault1-3.jpeg'),
('Peugeot', '208', 14000.00, 2021, 15000, 'images/peugeot.jpeg', 'Essence', 'Noir', 'Automatique', 'Climatisation', 'images/peugeot1-1.jpeg', 'images/peugeot1-2.jpeg', 'images/peugeot1-3.jpeg'),
('Jaguar', 'XE', 50000.00, 2020, 8000, 'images/jaguar.jpeg', 'Essence', 'Bleu', 'Automatique', 'GPS, Caméra de recul', 'images/jaguar1-1.jpeg', 'images/jaguar1-2.jpeg', 'images/jaguar1-3.jpeg'),
('Land Rover', 'Range Rover', 90000.00, 2019, 10000, 'images/landrover.jpeg', 'Diesel', 'Argent', 'Automatique', 'Climatisation, Bluetooth', 'images/landrover1-1.jpeg', 'images/landrover1-2.jpeg', 'images/landrover1-3.jpeg'),
('Volvo', 'XC60', 60000.00, 2020, 12000, 'images/volvo.jpeg', 'Essence', 'Rouge', 'Automatique', 'GPS, Caméra de recul', 'images/volvo1-1.jpeg', 'images/volvo1-2.jpeg', 'images/volvo1-3.jpeg'),
('Porsche', 'Macan', 70000.00, 2019, 8000, 'images/porsche.jpeg', 'Essence', 'Noir', 'Automatique', 'Climatisation', 'images/porsche1-1.jpeg', 'images/porsche1-2.jpeg', 'images/porsche1-3.jpeg'),
('Aston Martin', 'DB11', 200000.00, 2021, 3000, 'images/astonmartin.jpeg', 'Essence', 'Argent', 'Automatique', 'GPS, Caméra de recul', 'images/astonmartin1-1.jpeg', 'images/astonmartin1-2.jpeg', 'images/astonmartin1-3.jpeg'),
('Ferrari', '488', 250000.00, 2020, 5000, 'images/ferrari.jpeg', 'Essence', 'Rouge', 'Automatique', 'Climatisation', 'images/ferrari1-1.jpeg', 'images/ferrari1-2.jpeg', 'images/ferrari1-3.jpeg'),
('Lamborghini', 'Huracán', 300000.00, 2021, 2000, 'images/lamborghini.jpeg', 'Essence', 'Jaune', 'Automatique', 'GPS, Caméra de recul', 'images/lamborghini1-1.jpeg', 'images/lamborghini1-2.jpeg', 'images/lamborghini1-3.jpeg'),
('Bentley', 'Continental GT', 400000.00, 2020, 1500, 'images/bentley.jpeg', 'Essence', 'Argent', 'Automatique', 'Climatisation', 'images/bentley1-1.jpeg', 'images/bentley1-2.jpeg', 'images/bentley1-3.jpeg');

-- Création de la table voitures_occasion si elle n'existe pas déjà
CREATE TABLE IF NOT EXISTS voitures_occasion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    modele VARCHAR(50) NOT NULL,
    prix DECIMAL(10, 2) NOT NULL,
    image LONGBLOB,
    annee INT NOT NULL,
    kilometrage INT NOT NULL
);

-- Insertion des valeurs dans la table voitures_occasion
INSERT INTO voitures_occasion (id, marque, modele, prix, image, annee, kilometrage)
VALUES
(1, 'McLaren', '720S', 250000.00, LOAD_FILE('images/mclaren.jpeg'), 2020, 15000),
(2, 'Toyota', 'Corolla', 20000.00, LOAD_FILE('images/toyota.jpeg'), 2019, 25000),
(3, 'Volkswagen', 'Golf', 30000.00, LOAD_FILE('images/volkswagen.jpeg'), 2021, 12000),
(4, 'Ford', 'Focus', 25000.00, LOAD_FILE('images/ford.jpeg'), 2018, 30000),
(5, 'Honda', 'Civic', 22000.00, LOAD_FILE('images/honda.jpeg'), 2020, 20000),
(6, 'Chevrolet', 'Malibu', 24000.00, LOAD_FILE('images/chevrolet.jpeg'), 2019, 27000),
(7, 'Nissan', 'Altima', 23000.00, LOAD_FILE('images/nissan.jpeg'), 2021, 15000),
(8, 'BMW', '3 Series', 40000.00, LOAD_FILE('images/bmw.jpeg'), 2019, 30000),
(9, 'Mercedes-Benz', 'C-Class', 45000.00, LOAD_FILE('images/mercedes.jpeg'), 2020, 20000),
(10, 'Audi', 'A4', 42000.00, LOAD_FILE('images/audi.jpeg'), 2020, 18000),
(11, 'Hyundai', 'Elantra', 18000.00, LOAD_FILE('images/hyundai.jpeg'), 2021, 10000),
(12, 'Kia', 'Optima', 19000.00, LOAD_FILE('images/kia.jpeg'), 2020, 22000),
(13, 'Tesla', 'Model 3', 35000.00, LOAD_FILE('images/tesla.jpeg'), 2021, 12000),
(14, 'Subaru', 'Impreza', 23000.00, LOAD_FILE('images/subaru.jpeg'), 2018, 35000),
(15, 'Mazda', 'Mazda3', 21000.00, LOAD_FILE('images/mazda.jpeg'), 2020, 20000),
(16, 'Fiat', '500', 15000.00, LOAD_FILE('images/fiat.jpeg'), 2019, 18000),
(17, 'Renault', 'Clio', 16000.00, LOAD_FILE('images/renault.jpeg'), 2020, 17000),
(18, 'Peugeot', '208', 18000.00, LOAD_FILE('images/peugeot.jpeg'), 2021, 13000),
(19, 'Jaguar', 'XE', 45000.00, LOAD_FILE('images/jaguar.jpeg'), 2019, 25000),
(20, 'Land Rover', 'Evoque', 60000.00, LOAD_FILE('images/landrover.jpeg'), 2020, 15000),
(21, 'Volvo', 'XC40', 40000.00, LOAD_FILE('images/volvo.jpeg'), 2021, 12000),
(22, 'Porsche', 'Macan', 70000.00, LOAD_FILE('images/porsche.jpeg'), 2020, 18000),
(23, 'Aston Martin', 'DB11', 205000.00, LOAD_FILE('images/astonmartin.jpeg'), 2019, 20000),
(24, 'Ferrari', '488', 250000.00, LOAD_FILE('images/ferrari.jpeg'), 2020, 10000),
(25, 'Lamborghini', 'Huracán', 250000.00, LOAD_FILE('images/lamborghini.jpeg'), 2019, 5000),
(26, 'Rolls-Royce', 'Phantom', 450000.00, LOAD_FILE('images/rollsroyce.jpeg'), 2020, 8000),
(27, 'Bentley', 'Continental', 300000.00, LOAD_FILE('images/bentley.jpeg'), 2019, 12000),
(28, 'Maserati', 'Ghibli', 70000.00, LOAD_FILE('images/maserati.jpeg'), 2020, 15000),
(29, 'Mini', 'Cooper', 25000.00, LOAD_FILE('images/mini.jpeg'), 2018, 30000),
(30, 'Alfa Romeo', 'Giulia', 35000.00, LOAD_FILE('images/alfaromeo.jpeg'), 2019, 22000),
(31, 'Lexus', 'IS', 40000.00, LOAD_FILE('images/lexus.jpeg'), 2020, 18000),
(32, 'Tesla', 'Model S', 80000.00, LOAD_FILE('images/tesla.jpeg'), 2020, 10000),
(33, 'Alpine', 'A110', 60000.00, LOAD_FILE('images/alpine.jpeg'), 2021, 5000)
ON DUPLICATE KEY UPDATE 
marque = VALUES(marque),
modele = VALUES(modele),
prix = VALUES(prix),
image = VALUES(image),
annee = VALUES(annee),
kilometrage = VALUES(kilometrage);
-- avec ON DUPLICATE KEY UPDATE, si une ligne avec un id existant est insérée, elle sera mise à jour au lieu de provoquer une erreur --