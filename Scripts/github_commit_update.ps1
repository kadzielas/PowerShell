[String]$script:commit = "";
[String]$script:pathToRepo = "C:\Users\Administrator\Desktop\GITHUB_PowerShell\";
[String]$script:spaceText = "-----------------------------------------------------------------------------------"

function commitUpdateToRepo {

[CmdLetBinding()]

param ()

    begin {
    Write-Verbose "Starting script..."

    cd $script:pathToRepo

    Write-Host "GIT status below:"
    Write-Host $script:spaceText

    git status

    Write-Host $script:spaceText
    

    $script:commit = Read-Host "Provide description of commit that you want to push into repository"

    }


    process {
    try {
    Write-Verbose "Received mandatory information, processing..."

    git add .
    git commit -m "$script:commit"
    git push

    if ($script:LASTEXITCODE -ne 0) {
        throw "Git push failed with exit code $script:LASTEXITCODE"
    }

    } catch {
    Write-Host "An error occured: $_"
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