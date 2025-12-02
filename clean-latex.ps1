# PowerShell script to clean LaTeX auxiliary files and caches
# Usage: .\clean-latex.ps1

Write-Host "Cleaning LaTeX auxiliary files and caches..." -ForegroundColor Yellow

# Change to src directory
Set-Location -Path "$PSScriptRoot\src"

$extensions = @(
    "*.aux", "*.log", "*.out", "*.fdb_latexmk", "*.fls", 
    "*.synctex.gz", "*.synctex(busy)", "*.toc", "*.lof", "*.lot", "*.bbl", 
    "*.blg", "*.idx", "*.ind", "*.ilg", "*.nav", "*.snm", 
    "*.vrb", "*.figlist", "*.makefile", "*.fignums",
    "*.bcf", "*.run.xml", "*.xdv"
)

$filesRemoved = 0
foreach ($ext in $extensions) {
    $files = Get-ChildItem -Path . -Filter $ext -ErrorAction SilentlyContinue
    if ($files) {
        $files | Remove-Item -Force
        $filesRemoved += $files.Count
        Write-Host "Removed $($files.Count) $ext files" -ForegroundColor Green
    }
}

if ($filesRemoved -eq 0) {
    Write-Host "No auxiliary files found to clean." -ForegroundColor Cyan
} else {
    Write-Host "Total auxiliary files removed: $filesRemoved" -ForegroundColor Green
}

# Clean LuaTeX font cache
Write-Host "`nCleaning LuaTeX font cache..." -ForegroundColor Yellow
try {
    $cacheOutput = & luaotfload-tool --cache=erase 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "LuaTeX font cache cleared successfully" -ForegroundColor Green
        # Rebuild cache
        Write-Host "Rebuilding font database..." -ForegroundColor Yellow
        & luaotfload-tool --update --force --quiet 2>&1 | Out-Null
        Write-Host "Font database rebuilt" -ForegroundColor Green
    }
} catch {
    Write-Host "Warning: Could not clear LuaTeX cache (luaotfload-tool not available)" -ForegroundColor DarkYellow
}

# Clean LuaTeX names cache
try {
    $namesCache = "$env:LOCALAPPDATA\MiKTeX\luatex-cache\generic\names"
    if (Test-Path $namesCache) {
        Remove-Item -Path "$namesCache\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "LuaTeX names cache cleared" -ForegroundColor Green
    }
} catch {
    Write-Host "Warning: Could not clear names cache" -ForegroundColor DarkYellow
}

Set-Location -Path $PSScriptRoot
Write-Host "`nLaTeX cleanup complete!" -ForegroundColor Green