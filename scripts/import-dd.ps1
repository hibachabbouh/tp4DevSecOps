param([string]$Url = "http://localhost:8081", [string]$Token)

$scans = @(
  @{ type = "Gitleaks Scan";  file = "gitleaks.json" },
  @{ type = "Trivy Scan";     file = "trivy-config.json" },
  @{ type = "Trivy Scan";     file = "trivy-image.json" },
  @{ type = "Bandit Scan";    file = "bandit.json" },
  @{ type = "pip-audit Scan"; file = "pip-audit.json" }
)

foreach ($s in $scans) {
  if (-not (Test-Path $s.file)) { Write-Host "Absent : $($s.file)"; continue }
  Write-Host "Import $($s.file) ($($s.type))"
  curl.exe -s -X POST "$Url/api/v2/import-scan/" `
    -H "Authorization: Token $Token" `
    -F "scan_type=$($s.type)" `
    -F "file=@$($s.file)" `
    -F "product_type_name=DevSecOps" `
    -F "product_name=Webapp" `
    -F "engagement_name=CI" `
    -F "test_title=$($s.file)" `
    -F "auto_create_context=true" `
    -F "deduplication_on_engagement=true"
  Write-Host ""
}