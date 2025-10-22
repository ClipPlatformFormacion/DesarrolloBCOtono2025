#Install-Module -Name BcContainerHelper -force

$artifactUrl = Get-BCArtifactUrl -country es -select Latest -type Sandbox -version 26.5

New-BcContainer -accept_eula -artifactUrl $artifactUrl -auth UserPassword -containerName BC26CU5ES -includeTestLibrariesOnly -includeTestToolkit -updateHosts -useBestContainerOS