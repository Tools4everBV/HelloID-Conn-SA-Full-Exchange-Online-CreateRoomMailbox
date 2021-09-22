<!-- Requirements -->
## Requirements
This HelloID Service Automation Delegated Form uses the [Exchange Online PowerShell V2 module](https://docs.microsoft.com/en-us/powershell/exchange/exchange-online-powershell-v2?view=exchange-ps)

<!-- Description -->
## Description
This HelloID Service Automation Delegated Form provides Exchange Online (Office365) room mailbox functionality. The following steps will be performed:
 1. Give a name for a new room mailbox to create
 2. Enter the resource capacity
 3. Create the room mailbox

<!-- TABLE OF CONTENTS -->
## Table of Contents
- [Requirements](#requirements)
- [Description](#description)
- [Table of Contents](#table-of-contents)
- [All-in-one PowerShell setup script](#all-in-one-powershell-setup-script)
  - [Getting started](#getting-started)
- [Post-setup configuration](#post-setup-configuration)
- [Manual resources](#manual-resources)
  - [Powershell data source 'Exchange-online-Room-mailbox-Create-CheckMailboxName'](#powershell-data-source-exchange-online-room-mailbox-create-checkmailboxname)
  - [Delegated form task 'Exchange-online-Room-mailbox-Create'](#delegated-form-task-exchange-online-room-mailbox-create)
- [Getting help](#getting-help)
- [HelloID Docs](#helloid-docs)


## All-in-one PowerShell setup script
The PowerShell script "createform.ps1" contains a complete PowerShell script using the HelloID API to create the complete Form including user defined variables, tasks and data sources.

 _Please note that this script asumes none of the required resources do exists within HelloID. The script does not contain versioning or source control_


### Getting started
Please follow the documentation steps on [HelloID Docs](https://docs.helloid.com/hc/en-us/articles/360017556559-Service-automation-GitHub-resources) in order to setup and run the All-in one Powershell Script in your own environment.

 
## Post-setup configuration
After the all-in-one PowerShell script has run and created all the required resources. The following items need to be configured according to your own environment
 1. Update the following [user defined variables](https://docs.helloid.com/hc/en-us/articles/360014169933-How-to-Create-and-Manage-User-Defined-Variables)

| Variable name                     | Description                           | Example value     |
| --------------------------------- | ------------------------------------- | ----------------- |
| ExchangeOnlineAdminUsername       | Exchange admin account                | user@domain.com   |
| ExchangeOnlineAdminPassword       | Exchange admin password               | ********          |
| ExchangeOnlineRoomMalboxDomain    | Exchange Room Malbox Domain suffix    | domain.com        |


## Manual resources
This Delegated Form uses the following resources in order to run

### Powershell data source 'Exchange-online-Room-mailbox-Create-CheckMailboxName'
This Powershell data source checks the available names.

### Delegated form task 'Exchange-online-Room-mailbox-Create'
This delegated form task will create the room mailbox in Exchange.


## Getting help
> _For more information on how to configure a HelloID PowerShell connector, please refer to our [documentation](https://docs.helloid.com/hc/en-us/articles/360012518799-How-to-add-a-target-system) pages_

> _If you need help, feel free to ask questions on our [forum](https://forum.helloid.com)_

## HelloID Docs
The official HelloID documentation can be found at: https://docs.helloid.com/