
param location string = resourceGroup().location  
param storageName string = 'strtest1${substring(uniqueString(resourceGroup().id),0,5)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: 'xyz${storageName}'
  location: location
  sku:{
     name: 'B1'

  }
}

resource webApplication 'Microsoft.Web/sites@2025-03-01' = {
  name: 'mar${storageName}'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

