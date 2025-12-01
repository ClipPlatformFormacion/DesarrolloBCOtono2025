#Install-Module -Name BcContainerHelper -force

$artifactUrl = Get-BCArtifactUrl -country es -select Latest -type Sandbox -version 27.1

New-BcContainer -accept_eula -artifactUrl $artifactUrl -auth UserPassword -containerName BC27CU1ES -includeTestLibrariesOnly -includeTestToolkit -updateHosts -useBestContainerOS