
# Connect to Office 365
try{
    HID-Write-Status -Event Warning -Message "Connecting to Office 365.."

    $module = Import-Module ExchangeOnlineManagement

    # Connect to Exchange Online in an unattended scripting scenario using user credentials (MFA not supported).
    $securePassword = ConvertTo-SecureString $ExchangeOnlineAdminPassword -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ($ExchangeOnlineAdminUsername, $securePassword)
    $exchangeSession = Connect-ExchangeOnline -Credential $credential -ShowBanner:$false -ShowProgress:$false -ErrorAction Stop

    HID-Write-Status -Event Success -Message "Successfully connected to Office 365"
}catch{
    throw "Could not connect to Exchange Online, error: $_"
}

# Create room mailbox
try {
    $roomMailboxParams = @{
        Name                        = $Name
        DisplayName                 = $DisplayName
        Alias                       = $Alias
        ResourceCapacity            = $ResourceCapacity
        PrimarySmtpAddress          = $PrimarySmtpAddress
    }

    $null = New-Mailbox @roomMailboxParams -Room
    HID-Write-Status -Event Success -Message "Successfully created room mailbox $Name"
    HID-Write-Summary -Event Success -Message "Successfully created room mailbox $Name"
} catch {
    HID-Write-Status -Event Error -Message "Error creating room mailbox $Name. Error: $($_)"
    HID-Write-Summary -Event Failed -Message "Error creating room mailbox $Name"
} finally {
    HID-Write-Status -Event Warning -Message "Disconnecting from Office 365.."
    $exchangeSessionEnd = Disconnect-ExchangeOnline -Confirm:$false -Verbose:$false -ErrorAction Stop
    HID-Write-Status -Event Success -Message "Successfully disconnected from Office 365"
}

