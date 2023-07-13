
# Connect to Office 365
try{
    write-information  "Connecting to Office 365.."

    $module = Import-Module ExchangeOnlineManagement

    # Connect to Exchange Online in an unattended scripting scenario using user credentials (MFA not supported).
    $securePassword = ConvertTo-SecureString $ExchangeOnlineAdminPassword -AsPlainText -Force
    $credential = [System.Management.Automation.PSCredential]::new($ExchangeOnlineAdminUsername,$securePassword)
    $exchangeSession = Connect-ExchangeOnline -Credential $credential -ShowBanner:$false -ShowProgress:$false -ErrorAction Stop
 
}catch{
     Write-Error "Error connecting to Exchange Online. Error: $($_.Exception.Message)"
    $Log = @{
            Action            = "CreateResource" # optional. ENUM (undefined = default) 
            System            = "Exchange Online" # optional (free format text) 
            Message           = "Failed to connect to Exchange Online" # required (free format text) 
            IsError           = $true # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = "Exchange Online" # optional (free format text) 
            
        }
    #send result back  
    Write-Information -Tags "Audit" -MessageData $log
}
 

# Create room mailbox
try {
    $roomMailboxParams = @{
        Name                        = $form.Naming.name
        DisplayName                 = $form.Naming.displayname
        Alias                       = $form.Naming.alias
        ResourceCapacity            = $form.ResourceCapacity
        PrimarySmtpAddress          = $form.Naming.primarySmtpAddress
    }

    $Createdmailbox = New-Mailbox @roomMailboxParams -Room
      
       $Log = @{
            Action            = "CreateResource" # optional. ENUM (undefined = default) 
            System            = "Exchange Online" # optional (free format text) 
            Message           = "Created Mailbox  $($roomMailboxParams.displayName)" # required (free format text) 
            IsError           = $false # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $($roomMailboxParams.displayName) # optional (free format text) 
            TargetIdentifier  = $([string]$Createdmailbox.Guid)  # optional (free format text) 
        }
        #send result back  
    write-information "Successfully created room mailbox $($Createdmailbox.Name)"
   
} catch {
    
     Write-Error "Error creating shared mailbox for $($roomMailboxParams.displayName).  Error: $($_.Exception.Message)"
    $Log = @{
            Action            = "CreateResource" # optional. ENUM (undefined = default) 
            System            = "Exchange Online" # optional (free format text) 
            Message           = "Error creating shared mailbox for $($roomMailboxParams.displayName)." # required (free format text) 
            IsError           = $true # optional. Elastic reporting purposes only. (default = $false. $true = Executed action returned an error) 
            TargetDisplayName = $($roomMailboxParams.displayName) # optional (free format text) 
            
        }
    #send result back  
    Write-Information -Tags "Audit" -MessageData $log
   
} finally {
    
    $exchangeSessionEnd = Disconnect-ExchangeOnline -Confirm:$false -Verbose:$false -ErrorAction Stop
    write-information "Successfully disconnected from Office 365"
}



