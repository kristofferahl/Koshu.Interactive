if (get-module Koshu-Interactive) {
	remove-module Koshu-Interactive
}
$module = (join-path (resolve-path .\..) 'tools\Koshu-Interactive.psm1')
import-module $module -disablenamechecking -global -args $config

task default -depends Interactive, Build, Deploy

task Interactive {
	# Setting interactive to $false will disable prompting during script execution
	# Set-Interactive $false

	# Using get-interactive prompts the user to set the InteractiveMode variable
	Get-Interactive
}

task Build {
	if ((Read-Switch 'Do you want to run the build?') -eq $true) {
		Write-Host "OK, let's build..."

		Execute-Interactive -message 'Build project?' {
			Write-Host "Running build..."
		}

		Execute-Interactive -message 'Pre-compile javascript?' {
			Write-Host "Pre-compiling javascript..."
		}

		Execute-Interactive -message 'Run tests?' {
			Write-Host "Running tests..."
		}
	}
}

task Deploy -precondition { return Read-Switch 'Run deployment task?' } {
	$environment = Read-Option -message "Deploy to environment?" -options @('Dev','QA','Production') -abortable -onabort {
		Write-Error 'Deployment aborted...'
	}

	Write-Host "Deploying application to $environment environment!"
}