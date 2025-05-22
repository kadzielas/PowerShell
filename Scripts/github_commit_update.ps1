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

            git add .;
            git commit -m "$script:commit";
            git push;

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
    }
}


commitUpdateToRepo -Verbose
