# HelloID-Conn-SA-Full-Exchange-Online-CreateRoomMailbox

| :information_source: Information                                                                                                                                                                                                                                                                                                                                                          |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements. |

## Description
_HelloID-Conn-SA-Full-Exchange-Online-CreateRoomMailbox_ is a template designed for use with HelloID Service Automation (SA) Delegated Forms. It can be imported into HelloID and customized according to your requirements.

This delegated form creates room mailboxes in Exchange Online. The delegated form supports the following flow:
1. Enter room mailbox details (display name, mail prefix/domain, alias, resource capacity)
2. Validate uniqueness for display name, email address, and alias in Microsoft Entra ID
3. Create the room mailbox in Exchange Online using app-only authentication

## Getting started
### Requirements

- **HelloID On-Premises Service Automation agent**
  For security reasons, the HelloID cloud agent does not support importing PowerShell modules. This form requires the ExchangeOnlineManagement module to be imported, therefore an on-premises agent is required.
- **ExchangeOnlineManagement PowerShell module**:
  The delegated form task and mailbox lookup data source use Exchange Online cmdlets.
- **Microsoft Entra application registration (certificate-based)**:
  The connector authenticates with app-only certificate authentication.
- **Office 365 Exchange Online application permission**:
  Configure and grant admin consent for `Exchange.ManageAsApp`.
- **Microsoft Graph application permissions**:
  Configure and grant admin consent for:
  - `User.Read.All`
  - `Domain.Read.All`

### Connection settings

The following user-defined variables are used by the connector.

| Setting                        | Description                                                                | Mandatory |
|--------------------------------|----------------------------------------------------------------------------|-----------|
| EntraIdTenantId                | Microsoft Entra tenant ID                                                  | Yes       |
| EntraIdOrganization            | Exchange Online organization domain (for example: contoso.onmicrosoft.com) | Yes       |
| EntraIdAppId                   | Application (client) ID of the app registration                            | Yes       |
| EntraIdCertificateBase64String | Base64 encoded certificate (including private key) used for authentication | Yes       |
| EntraIdCertificatePassword     | Password for the certificate                                               | Yes       |

## Remarks

### Uniqueness Validation In Microsoft Entra ID
- The form validates display name, alias, and email address against Microsoft Graph before creation.
- Validation checks both `mail` and `proxyAddresses` to prevent duplicate SMTP/proxy values.

### Room Mailbox Creation Behavior
- The task uses `New-Mailbox` with `Room = $true` and sets display name, primary SMTP address, and resource capacity.
- If an alias is provided, it is included in the create action; otherwise Exchange Online determines the alias.

### Domain Selection
- Available mail domains are retrieved from Microsoft Entra ID (`/v1.0/domains`) and used in the mail domain dropdown.

## Development resources

### API endpoints

The following endpoints are used by the connector.

| Endpoint                                                                 | Description                                                                 |
|--------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| `https://login.microsoftonline.com/{tenantId}/oauth2/token`             | Retrieve Microsoft Graph access token using certificate-based auth          |
| `https://graph.microsoft.com/v1.0/users?...`                            | Validate uniqueness of display name, alias, and email address              |
| `https://graph.microsoft.com/v1.0/domains`                              | Retrieve available mail domains                                             |
| `Connect-ExchangeOnline`                                                 | Open app-only Exchange Online session                                       |
| `New-Mailbox -Room`                                                      | Create the room mailbox                                                     |
| `Disconnect-ExchangeOnline`                                              | Close Exchange Online session                                               |

### API documentation

- https://learn.microsoft.com/graph/api/overview
- https://learn.microsoft.com/graph/api/user-list
- https://learn.microsoft.com/graph/api/domain-list
- https://learn.microsoft.com/powershell/module/exchange/connect-exchangeonline
- https://learn.microsoft.com/powershell/module/exchange/new-mailbox

## Getting help
> :bulb: **Tip:**
> _For more information on Delegated Forms, please refer to our [documentation](https://docs.helloid.com/en/service-automation/delegated-forms.html) pages_.

## HelloID docs
The official HelloID documentation can be found at: https://docs.helloid.com/