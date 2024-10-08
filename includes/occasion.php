<!-- Véhicules d'occasion -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="css/occasion.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

<?php
// Connexion à la base de données (assurez-vous d'avoir un fichier de configuration pour cela)
include 'config.php'; // Assurez-vous que ce fichier contient votre configuration de connexion PDO

// Définir le nombre de véhicules d'occasion à afficher par page
$nombreVehiculesParPage = 9;

// Récupérer le numéro de la page actuelle
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
if ($page < 1) {
    $page = 1; // S'assurer que la page est au moins 1
}

// Calculer les limites de la requête SQL
$offset = ($page - 1) * $nombreVehiculesParPage;
$limit = $nombreVehiculesParPage;

// Récupérer les véhicules d'occasion depuis la base de données
$query = "SELECT * FROM vente_occasion LIMIT :offset, :limit";
$statement = $connection->prepare($query);
$statement->bindValue(':offset', $offset, PDO::PARAM_INT);
$statement->bindValue(':limit', $limit, PDO::PARAM_INT);
$statement->execute();
$vehiculesOccasion = $statement->fetchAll();
?>

<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-10">
      <h2>Véhicules d'occasion</h2>
      <div id="voitures-occasion" class="card-deck">
        <?php foreach ($vehiculesOccasion as $voiture): ?>
          <div data-marque="<?php echo htmlspecialchars($voiture['marque']); ?>"
               data-prix="<?php echo htmlspecialchars($voiture['prix']); ?>"
               data-kilometrage="<?php echo htmlspecialchars($voiture['kilometrage']); ?>"
               data-annee="<?php echo htmlspecialchars($voiture['annee']); ?>"
               class="card">
            <h5 class="card-title"><?php echo htmlspecialchars($voiture['marque']); ?></h5>
            <h6 class="card-text"><?php echo htmlspecialchars($voiture['modele']); ?></h6>

            <?php
            // Vérification si une image principale existe dans la base de données ou utilisation d'une image par défaut
            if (!empty($voiture['image']) && file_exists($voiture['image'])) {
                $imageSrc = $voiture['image'];
            } else {
                $imageSrc = 'images/defaut.jpg'; // Image par défaut
            }
            ?>
            <!-- Affichage de l'image principale -->
            <img src="<?php echo htmlspecialchars($imageSrc); ?>" class="card-img-top" alt="Image du véhicule">

            <div class="card-body">
              <p class="card-text">Prix : <?php echo htmlspecialchars($voiture['prix']); ?>€</p>
              <p class="card-text">Kilométrage : <?php echo htmlspecialchars($voiture['kilometrage']); ?> km</p>
              <p class="card-text">Année : <?php echo htmlspecialchars($voiture['annee']); ?></p>
            </div>

            <div class="card-footer">
              <button type="button" class="btn-detail" onclick="showDetails(this)">Plus de détails</button>
              <div class="details" style="display: none;">
                <h3>Galerie d'images</h3>
                <div id="gallery-carousel-<?php echo $voiture['id']; ?>" class="carousel slide" data-ride="carousel">
                  <ol class="carousel-indicators">
                    <li data-target="#gallery-carousel-<?php echo $voiture['id']; ?>" data-slide-to="0" class="active"></li>
                    <li data-target="#gallery-carousel-<?php echo $voiture['id']; ?>" data-slide-to="1"></li>
                    <li data-target="#gallery-carousel-<?php echo $voiture['id']; ?>" data-slide-to="2"></li>
                  </ol>
                  <div class="carousel-inner">
                    <?php
                    // Gestion des images de la galerie (gallery1, gallery2, gallery3)
                    $galleryImages = [];
                    for ($i = 1; $i <= 3; $i++) {
                        $gallerySrc = !empty($voiture["gallery$i"]) && file_exists($voiture["gallery$i"])
                            ? $voiture["gallery$i"]
                            : 'images/defaut.jpg'; // Image par défaut
                        $galleryImages[] = $gallerySrc;
                    }
                    ?>

                    <!-- Affichage des images de la galerie -->
                    <?php foreach ($galleryImages as $index => $src): ?>
                      <div class="carousel-item <?php echo ($index === 0) ? 'active' : ''; ?>">
                        <img src="<?php echo htmlspecialchars($src); ?>" class="d-block w-100" alt="Image du véhicule, vue <?php echo $index + 1; ?>">
                      </div>
                    <?php endforeach; ?>
                  </div>
                  <a class="carousel-control-prev" href="#gallery-carousel-<?php echo $voiture['id']; ?>" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Précédent</span>
                  </a>
                  <a class="carousel-control-next" href="#gallery-carousel-<?php echo $voiture['id']; ?>" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Suivant</span>
                  </a>
                </div>

                <h3>Caractéristiques</h3>
                <p class="card-text">Boîte de vitesse : <?php echo htmlspecialchars($voiture['boite_de_vitesse']); ?></p>
                <p class="card-text">Couleur : <?php echo htmlspecialchars($voiture['couleur']); ?></p>
                <p class="card-text">Carburant : <?php echo htmlspecialchars($voiture['carburant']); ?></p>
                <p class="card-text">Équipements : <?php echo htmlspecialchars($voiture['liste_equipements']); ?></p>
              </div>
              <div class="icons text-center">
                <a href="tel:0123456789"><i class="fa fa-phone text-white"></i></a>
                <a href="#contact"><i class="fa fa-envelope text-white"></i></a>
                <a href="#services"><i class="fa fa-wrench text-white"></i></a>
                <a href="#horaires"><i class="fa fa-calendar text-white"></i></a>
              </div>
            </div>
          </div>
        <?php endforeach; ?>
      </div>
    </div>
  </div>
</div>

<script>
function showDetails(button) {
  var card = button.closest('.card');
  var details = card.querySelector('.details');

  if (details.style.display === 'none') {
    details.style.display = 'block';
  } else {
    details.style.display = 'none';
  }
}
</script>

<?php
// Calculer le nombre total de véhicules d'occasion
$queryCount = "SELECT COUNT(*) as total FROM vente_occasion";
$statementCount = $connection->prepare($queryCount);
$statementCount->execute();
$totalVehicules = $statementCount->fetchColumn();

// Calculer le nombre total de pages
$totalPages = ceil($totalVehicules / $nombreVehiculesParPage);
?>

<!-- Afficher la pagination -->
<?php if ($totalPages > 1): ?>
  <nav aria-label="Pagination">
    <ul class="pagination justify-content-center">
      <?php for ($i = 1; $i <= $totalPages; $i++): ?>
        <?php if ($i == $page): ?>
          <li class="page-item active">
            <a class="page-link active-page" href="index.php?page=<?php echo $i; ?>#occasion"><?php echo $i; ?></a>
          </li>
        <?php else: ?>
          <li class="page-item">
            <a class="page-link" href="index.php?page=<?php echo $i; ?>#occasion"><?php echo $i; ?></a>
          </li>
        <?php endif; ?>
      <?php endfor; ?>
    </ul>
  </nav>
<?php endif; ?>

<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
