$ErrorActionPreference = 'Stop'

$outputDir = 'C:/Users/tling/tling0001.github.io'

flutter build web -o $outputDir

$status = git -C $outputDir status --porcelain
if (-not $status) {
  Write-Host 'No changes to commit.'
  exit 0
}

git -C $outputDir add -A
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ssK"
$commitMessage = "Deploy site update ($timestamp)"
git -C $outputDir commit -m $commitMessage
git -C $outputDir push
