#-------------------------------------------------------------------------------------------------------
#Description: Function to automate checking connection and collect only the most necessary information.
#-------------------------------------------------------------------------------------------------------

$script:isValid = $false

function validURL {
    do {
        try {
            [uri]$output = Read-Host "Provide URL to check"

            if ($output.Scheme -in @('https', 'http')) {
                checkConnection -url $output -Verbose
                $script:isValid = $true
            }
            else {
                Write-Error "Provided URL is invalid, please try again"
            }
        }
        catch {
            Write-Error "Something went wrong: $_"
        }

    } while (-not $script:isValid)
}

function checkConnection {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [uri]$url
    )

    begin {
        Write-Verbose "Starting script..."
        [string]$urlWithoutPrefixProtocol = $url -replace '^https://', '' -replace '/$', ''
        $urlWithoutPrefixProtocol
    }

    process {
        Write-Verbose "Validating provided data and processing..."

        try {

            if ($script:curlResult = Invoke-WebRequest -Uri $url -TimeoutSec 10) {
                Write-Verbose "Finished Invoke-WebRequest successfully"
            }
            if ($script:tcResult = Test-Connection $urlWithoutPrefixProtocol) {
                Write-Verbose "Finished Test-Connection succesffully"
            }
            if ($script:tracertResult = tracert $url) {
                Write-Verbose "Finished Tracert successfully"
            }
            
            if (($script:curlResult).statuscode -eq 200) {

                Write-Host "Connection to $url succeeded!"

            }
            else {

                Write-Host "Connection to $url is not working"

            }
            
        }
        catch {
            Write-Error "Connection to $url failed: $_"
        }
    }

    end {
        Write-Verbose "Finished checking $url"
    }
}


validURL
