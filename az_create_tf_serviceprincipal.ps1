# To run, use Azure Cloud Shell and use the following 2 commands:
# curl -O < DIRECT URL TO SCRIPT IN GIT REPO .ps1>
# pwsh -File ./az_create_tf_serviceprincipal.ps1

# Make sure you are logged into the correct subscription

# Variables
$spName = "az-sp-babble-tf"
$secretExpiration = (Get-Date).AddMonths(3).ToString("yyyy-MM-dd")

# Create the service principal with a 3-month expiration for the secret
$sp = az ad sp create-for-rbac `
    --name $spName `
    --role "Contributor" `
    --scopes $(az account show --query id -o tsv) `
    --years 0 `
    --password-validity-period "PT90D" `
    --only-show-errors -o json | ConvertFrom-Json

if ($null -eq $sp) {
    Write-Error "Failed to create the service principal."
    return
}

# Output the Application ID and Secret
Write-Output "Application ID: $($sp.appId)"
Write-Output "Secret: $($sp.password)"
Write-Output "Tenant ID: $($sp.tenant)"

# Validate the expiration date and output a warning if it doesn't align
if ($sp.passwordExpires -ne $secretExpiration) {
    Write-Warning "Secret expiration date is $($sp.passwordExpires), which may not align with the intended 3-month period. Please verify."
}

# Note: Use the outputted Application ID and Secret carefully and securely.
