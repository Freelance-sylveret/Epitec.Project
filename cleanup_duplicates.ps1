# Script pour nettoyer tous les doublons dans toutes les pages

# Menu exact de index.html sans aucun doublon
$menuExact = @'
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

# Liste des fichiers à nettoyer
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

Write-Host "Nettoyage de tous les doublons dans toutes les pages..."

foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "Nettoyage de $file..."
        
        $content = Get-Content $file -Raw
        
        # Trouver le début et la fin du menu
        $menuStart = $content.IndexOf("<!-- Menu -->")
        $menuEnd = $content.IndexOf("</ul>", $menuStart)
        
        if ($menuStart -ge 0 -and $menuEnd -gt $menuStart) {
            # Remplacer tout le bloc du menu par le menu exact
            $beforeMenu = $content.Substring(0, $menuStart)
            $afterMenu = $content.Substring($menuEnd + 5)
            
            $newContent = $beforeMenu + $menuExact + $afterMenu
            
            Set-Content $file $newContent -Encoding UTF8
            Write-Host "✅ $file nettoyé - plus de doublons"
        } else {
            Write-Host "⚠️ Menu non trouvé dans $file"
        }
    } else {
        Write-Host "❌ Fichier $file non trouvé"
    }
}

Write-Host "Nettoyage terminé ! Tous les doublons ont été supprimés."
