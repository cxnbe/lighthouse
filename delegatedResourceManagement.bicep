targetScope = 'subscription'

@description('Specify a unique name for your offer')
param mspOfferName string

@description('Name of the Managed Service Provider offering')
param mspOfferDescription string

@description('Specify the tenant id of the Managed Service Provider')
param managedByTenantId string

@description('Specify an array of objects, containing tuples of Azure Active Directory principalId, a Azure roleDefinitionId, and an optional principalIdDisplayName. The roleDefinition specified is granted to the principalId in the provider\'s Active Directory and the principalIdDisplayName is visible to customers.')
param authorizations array

@description('Provide the auhtorizations that will have just-in-time role assignments on customer environments with support for approvals from the managing tenant')
param eligibleAuthorizations array

var mspRegistrationName_var = guid(mspOfferName)
var mspAssignmentName_var = guid(mspOfferName)

resource mspRegistrationName 'Microsoft.ManagedServices/registrationDefinitions@2020-02-01-preview' = {
  name: mspRegistrationName_var
  properties: {
    registrationDefinitionName: mspOfferName
    description: mspOfferDescription
    managedByTenantId: managedByTenantId
    authorizations: authorizations
    eligibleAuthorizations: eligibleAuthorizations
  }
}

resource mspAssignmentName 'Microsoft.ManagedServices/registrationAssignments@2020-02-01-preview' = {
  name: mspAssignmentName_var
  properties: {
    registrationDefinitionId: mspRegistrationName.id
  }
}

output mspOfferName string = 'Managed by ${mspOfferName}'
output authorizations array = authorizations
output eligibleAuthorizations array = eligibleAuthorizations
