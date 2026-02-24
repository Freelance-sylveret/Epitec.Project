# Script pour appliquer le menu exact de index.html à toutes les pages

# Récupérer le menu exact de index.html
$menuContent = @'
                        <!-- Menu -->
                        <ul class="nav-menu" id="nav-menu">
                            <li><a href="index.html">ACCUEIL</a></li>
                            <li><a href="acheter.html">ACHETER</a></li>
                            <li class="dropdown">
                                <a href="location.html">LOUER <i class="fas fa-chevron-down arrow"></i></a>
                                <ul class="dropdown-menu">
                                    <li><a href="louer.html">Appartements</a></li>
                                    <li><a href="maison.html">Maisons et Villas</a></li>
                                    <li><a href="terrain.html">Terrains</a></li>
                                    <li><a href="location.html">Tous nos biens</a></li>
                                </ul>
                            </li>
                            <li><a href="gestion.html">GESTION LOCATIVE</a></li>
                            <li><a href="rendezvous.html">PRENDRE RENDEZ-VOUS</a></li>
                            <li class="dropdown">
                                <a href="#">RESSOURCES <i class="fas fa-chevron-down arrow"></i></a>
                                <ul class="dropdown-menu">
                                    <li><a href="actualites.html">Actualités</a></li>
                                    <li><a href="#">Guides immobiliers</a></li>
                                    <li><a href="#">Conseils d'experts</a></li>
                                    <li><a href="#">Blog</a></li>
                                </ul>
                            </li>
                            <li class="dropdown">
                                <a href="#">NOS AGENCES <i class="fas fa-chevron-down arrow"></i></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#">Abidjan</a></li>
                                    <li><a href="#">San Pedro</a></li>
                                    <li><a href="#">Grand Bassam</a></li>
                                    <li><a href="#">Toutes les agences</a></li>
                                </ul>
                            </li>
                        </ul>
'@

# Liste des fichiers à mettre à jour
$files = @(
    "acheter.html",
    "louer.html", 
    "maison.html",
    "terrain.html",
    "location.html",
    "gestion.html",
    "rendezvous.html",
    "actualites.html",
    "transaction.html",
    "vendre.html",
    "syndic.html",
    "confirmation.html"
)

Write-Host "Application du menu exact de index.html à toutes les pages..."

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Mise à jour de $file..."
        
        $content = Get-Content $file -Raw
        
        # Remplacer tout le bloc du menu (de <!-- Menu --> jusqu'à </ul>)
        $pattern = '(?s)<!-- Menu -->.*?</ul>'
        $replacement = "<!-- Menu -->`n$menuContent"
        
        $content = $content -replace $pattern, $replacement
        
        Set-Content $file $content -Encoding UTF8
        Write-Host "✅ $file mis à jour avec le menu exact de index.html"
    } else {
        Write-Host "❌ Fichier $file non trouvé"
    }
}

Write-Host "Mise à jour terminée ! Toutes les pages ont maintenant le même menu que index.html"
