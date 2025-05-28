#------------------------------------------------------------------------------------------
#Description: Function to automate pushing commits into my PowerShell repository on GitHub.
#------------------------------------------------------------------------------------------



[string]$script:commit = ""
[string]$script:pathToRepo = "C:\Users\Administrator\Desktop\GITHUB_PowerShell\"
[string]$script:spaceText = "-----------------------------------------------------------------------------------"



function commitUpdateToRepo {
    [CmdletBinding()]
    param ()

    begin {
        Write-Verbose "Starting script..."

        Set-Location -Path $script:pathToRepo

        Write-Host "GIT status below:"
        Write-Host $script:spaceText
        git status
        Write-Host $script:spaceText

        $script:commit = Read-Host "Provide description of commit that you want to push into repository"
    }

    process {
        try {
            Write-Verbose "Received mandatory information, processing..."

            git add . | Out-Null
            git commit -m "$script:commit" | Out-Null
            git push 2>$null

        }
        catch {
            Write-Host "An error occurred: $_"
        }
        finally {
            Write-Verbose "Processing finished..."
        }
    }

    end {
        Write-Verbose "Script has successfully finished!"
        Start-Sleep -Seconds 5
    }
}


commitUpdateToRepo -Verbose
