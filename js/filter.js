document.addEventListener('DOMContentLoaded', function () {
  const filterBtn = document.getElementById('filtre-btn');
  const vehiculesContainer = document.getElementById('vehicules-container');

  function filtrerVehicules() {
    // Récupérer les valeurs des filtres
    const marque = document.getElementById('marque-select').value;
    const prixMin = document.getElementById('prix-min-input').value ? parseInt(document.getElementById('prix-min-input').value) : null;
    const prixMax = document.getElementById('prix-max-input').value ? parseInt(document.getElementById('prix-max-input').value) : null;
    const kilometrageMin = document.getElementById('kilometrage-min-input').value ? parseInt(document.getElementById('kilometrage-min-input').value) : null;
    const kilometrageMax = document.getElementById('kilometrage-max-input').value ? parseInt(document.getElementById('kilometrage-max-input').value) : null;
    const anneeMin = document.getElementById('annee-min-input').value ? parseInt(document.getElementById('annee-min-input').value) : null;
    const anneeMax = document.getElementById('annee-max-input').value ? parseInt(document.getElementById('annee-max-input').value) : null;

    // Récupérer tous les véhicules
    const vehicules = Array.from(document.getElementsByClassName('card'));

    // Appliquer les filtres
    vehicules.forEach(function (vehicule) {
      const vehiculeMarque = vehicule.getAttribute('data-marque');
      const vehiculePrix = parseInt(vehicule.getAttribute('data-prix'));
      const vehiculeKilometrage = parseInt(vehicule.getAttribute('data-kilometrage'));
      const vehiculeAnnee = parseInt(vehicule.getAttribute('data-annee'));

      // Vérifier les conditions pour chaque filtre
      const marqueMatch = marque === 'Toutes' || vehiculeMarque === marque;
      const prixMatch = (prixMin === null || vehiculePrix >= prixMin) && (prixMax === null || vehiculePrix <= prixMax);
      const kilometrageMatch = (kilometrageMin === null || vehiculeKilometrage >= kilometrageMin) && (kilometrageMax === null || vehiculeKilometrage <= kilometrageMax);
      const anneeMatch = (anneeMin === null || vehiculeAnnee >= anneeMin) && (anneeMax === null || vehiculeAnnee <= anneeMax);

      // Afficher ou cacher le véhicule selon les filtres
      if (marqueMatch && prixMatch && kilometrageMatch && anneeMatch) {
        vehicule.style.display = 'block'; // Afficher le véhicule
      } else {
        vehicule.style.display = 'none'; // Cacher le véhicule
      }
    });
  }

  // Écouter le clic sur le bouton de filtre
  filterBtn.addEventListener('click', filtrerVehicules);
});
