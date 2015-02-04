function Push-Nuget($path, $csproj) {
    $fullPathToCsprog = Join-Path -Path $path -ChildPath $csproj -resolve;
    
    nuget pack $fullPathToCsprog -Prop Configuration=Release -IncludeReferencedProjects -Symbols
    
    get-childitem -Filter *.nupkg -name | foreach ($_) {
        Write-Host "Pushing " $_ -backgroundcolor darkgreen -foregroundcolor white;
    
        nuget push $_
        Remove-Item $_
        
        Write-Host "Done " $_ -backgroundcolor darkgreen -foregroundcolor white;
    }
}

Push-Nuget "Poly2Tri" "Poly2Tri.csproj"