#-------------------------------------------------------------------------------------------------------
#Description: Function to automate checking connection and collect only the most necessary information.
#-------------------------------------------------------------------------------------------------------


[hashtable]$script:connectionInfo = @{};
[string]$script:destinationIp;
[string]$script:destinationHostname;
[string]$script:destinationServer;
[int]$script:statusCode;
[string]$script:clienIp;
[string]$script:clientHostname;
[string]$script:traceRoute = "";
[int]$script:hopsCount;
[bool]$script:dnsResolved = $false;
[bool]$script:isRedirecting = $false;
[int]$script:rawContentLength;


function Test-Connection-HTTPS {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [uri]$url
    )

    begin {

        Write-Verbose "Validating provided URL - $url"
        if (-not $url) {
            [uri]$url = Read-Host "Provide URL to check"
            if ($url.Scheme -in @('https', 'http')) {
                Write-Output "URL is correct: $url"
            }
        }
        else {
            Write-Error "Provided URL [$url] is invalid, please try again"
            exit 1
        }

        Write-Verbose "Establishing connection..."
        [string]$urlWithoutPrefixProtocol = $url -replace '^https://', '' -replace '/$', ''
        [string]$title = ((Get-Date -format yy-mm-dd-mm-ss) + "-" + $urlWithoutPrefixProtocol -replace '\.', "-")
        [string]$script:path = Join-Path $PWD "$title"
    }

    process {
        Write-Verbose "Validating provided data and processing..."

        try {

            if ($script:curlResult = Invoke-WebRequest -Uri $url -TimeoutSec 10) {
                Write-Verbose "Successfully finished Invoke-WebRequest"
                
            }
            #if ($script:tncResult = Test-NetConnection $urlWithoutPrefixProtocol -TraceRoute -InformationLevel Detailed) {
            #    Write-Verbose "Successfully finished Test-NetConnection"
            #}

            if ($script:webRequestResult = [System.Net.WebRequest]::Create($url)) {
                $script:webRequestResult.AllowAutoRedirect = $false;
                $script:statusCode = [int]$script:webRequestResult.getresponse().statuscode;
                Write-Verbose "Successfully finished test request"
            }
            #if (Resolve-DnsName $urlWithoutPrefixProtocol) {
            #    $script:dnsResolved = $true;
            #    Write-Verbose "Successfully finished resolving DNS"
            #}
            
            if ($script:statusCode -eq 200) {

                Write-Output "Connection to $url succeeded!"

            }
            elseif ($script:statusCode -ge 300 -and $script:statusCode -lt 400) {
                $isRedirecting = $true;
                Write-Output "Connecting to $url succeeded!"
                Write-Output "Connecting to $url is redirecting to another address"
            }
            elseif ($script:statusCode -ge 500) {
                Write-Output "Connection cannot be established due to server performance: $_"
            }
            else {

                Write-Output "Connection $url cannot be established: $_"

            }
            
        }
        catch {
            Write-Error "Connection to $url failed: $_"
        }

        try {
            #arp -a (looking for hosts inside local network)
            #$script:destinationIp = $script:tncResult.RemoteAddress
            #$script:destinationHostname = ([System.Net.Dns]::GetHostEntry($script:destinationIp).HostName)
            $script:destinationServer = $script:webRequestResult.GetResponse().server
            #$script:clienIp = ($script:tncResult.SourceAddress).ToString()
            $script:clientHostname = hostname
            $script:statusCode = $script:statusCode
            #$script:traceRoute = ($script:tncResult | Select-Object -ExpandProperty traceroute)
            # $script:hopsCount = ($script:tncResult.TraceRoute | Measure-Object).Count
            $script:rawContentLength = $script:curlResult.RawContentLength
            

            $script:connectionInfo = @{
                Destination_URL    = $url
                #Destination_IP       = $script:destinationIp
                #Destination_Hostname = $script:destinationHostname
                Destination_Server = $script:destinationServer
                #Client_IP            = $script:clienIp
                Client_Hostname    = $script:clientHostname
                Status_Code        = $script:statusCode
                #Trace_Route          = $script:traceRoute -replace " ", " -> "
                #Hops_Count           = $script:hopsCount
                #DNS_Name_Resolved    = $script:dnsResolved
                Redirecting        = $script:isRedirecting
                Raw_Content_Length = $script:rawContentLength
                
            } 

            $script:connectionInfo

        }
        catch {
            Write-Error "Error during collecting information: $_"
        }
    }

    end {
        @"
|----------------------------------------------------
| Date: $(Get-Date -Format "yyyy-mm-dd HH:mm")
| URL: $url
| Status: $($script:webRequestResult.getresponse().statuscode)
|----------------------------------------------------

Connetion diagnostic details:
$($script:connectionInfo | Out-String)

-----------------------------------------------------
"@ | Out-File -FilePath "$script:path.txt" -Encoding UTF8

        $script:connectionInfo | Export-Csv -Path "$script:path.csv" -Encoding UTF8

        Write-Verbose "Finished diagnosting connection: $url"
        
        exit
    }
}