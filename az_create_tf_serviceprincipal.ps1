# To run, use Azure Cloud Shell and use the following 3 commands:
# $scriptUrl = "https://raw.githubusercontent.com/ChrissR3/terraform/main/az_create_tf_serviceprincipal.ps1"
# Invoke-WebRequest -Uri $scriptUrl -OutFile "./az_create_tf_serviceprincipal.ps1"
#./az_create_tf_serviceprincipal.ps1

# Make sure you are logged into the correct subscription

# Variables
$subid = az account show --query id -o tsv
$spName = "az-sp-babble-tf"
$secretExpiration = (Get-Date).AddMonths(12).ToString("yyyy-MM-dd")

# Create the service principal with a 12-month expiration for the secret
$sp = az ad sp create-for-rbac `
    --name $spName `
    --role "Contributor" `
    --scopes /subscriptions/$(az account show --query id -o tsv) `
    --years 1 `
    --only-show-errors -o json | ConvertFrom-Json

if ($null -eq $sp) {
    Write-Error "Failed to create the service principal."
    return
}

# Output the Application ID and Secret
Write-Output "Application ID: $($sp.appId)"
Write-Output "Secret: $($sp.password)"
Write-Output "Tenant ID: $($sp.tenant)"
Write-Output "Subscription ID: $subid"

# Validate the expiration date and output a warning if it doesn't align
if ($sp.passwordExpires -ne $secretExpiration) {
    Write-Warning "Secret expiration date is $($sp.passwordExpires), which may not align with the intended 12-month period. Please verify."
}


# Note: Use the outputted Application ID and Secret carefully and securely.
