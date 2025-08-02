cufunction Get-EvenNumber {
    [CmdletBinding()]
    param (
        # Accepts integers 1–100 from pipeline with help message
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            HelpMessage = "Provide an integer between 1 and 100"
        )]
        [ValidateRange(1, 100)]
        [int[]]$Number
    )

    begin {
        Write-Verbose "Starting even number check..."
    }

    process {
        foreach ($n in $Number) {
            if ($n % 2 -eq 0) {
                Write-Output $n
            }
            else {
                Write-Verbose "$n is not even"
            }
        }
    }

    end {
        Write-Verbose "Done checking numbers."
    }
}
