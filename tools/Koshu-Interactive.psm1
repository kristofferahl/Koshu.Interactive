function Read-Option {
	Param(
		[Parameter(Position=0,Mandatory=1)] [string]$message,
		[Parameter(Position=1,Mandatory=0)] $options=@('yes','no'),
		[Parameter(Position=2,Mandatory=0)] [string]$separator='/',
		[Parameter(Position=3,Mandatory=0)] [switch]$abortable,
		[Parameter(Position=4,Mandatory=0)] [scriptblock]$onAbort,
		[Parameter(Position=5,Mandatory=0)] [switch]$force
	)

	if ($force -eq $false -and (Get-Interactive) -eq $false) {
		Write-Error "Read-Option is not allowed when InteractiveMode is set to false. Use 'Set-Interactive $True' to enable 'Read-Option'."
	}

	if ($abortable -eq $true -and ($options -contains 'abort') -eq $false) {
		$options += 'abort'
	}

	$prompt = "$message [ $($options | join-string -separator $separator) ]"
	$result = Read-Host -prompt $prompt
	if ($options -contains $result) {
		if ($result -eq 'abort' -and $onAbort) {
			& $onAbort
		}
		return $result
	} else {
		Write-Host 'Please enter a valid option...' -fore yellow
		return Read-Option $message $options $separator $abortable $onAbort $force
	}
}

function Read-Switch {
	Param(
		[Parameter(Position=0,Mandatory=1)] [string]$message,
		[Parameter(Position=1,Mandatory=0)] [switch]$force
	)

	if ((InteractiveMode-Set) -eq $true -and (Get-Interactive) -eq $false) {
		return $true
	} else {
		$result = Read-Option -message $message -options @('yes', 'no') -separator '/' $false $null $force
		if ($result.ToLower() -eq 'yes') {
			return $true
		} else {
			return $false
		}
	}
}

function InteractiveMode-Set {
	$interactive = $script:InteractiveMode
	if ($interactive -ne $true -and $interactive -ne $false) {
		return $false
	} else {
		return $true
	}
}

function Set-Interactive {
	Param(
		[Parameter(Position=0,Mandatory=1,ValueFromPipeline=1)] [bool]$interactive
	)

	$script:InteractiveMode = $interactive
	Write-Host "InteractiveMode set to $interactive"
}

function Get-Interactive {
	$interactive = $script:InteractiveMode
	if ((InteractiveMode-Set) -eq $false) {
		$interactive = Read-Switch -message 'Run script in interactive mode?' -force
		Set-Interactive $interactive
	}
	return $interactive
}

function Execute-Interactive {
	Param(
		[Parameter(Position=0,Mandatory=1)] [string]$message,
		[Parameter(Position=1,Mandatory=1)] [scriptblock]$action
	)

	$interactive = Get-Interactive
	if ($interactive -eq $true) {
		$execute = Read-Switch -message $message
		if ($execute) {
			& $action
		}
	} else {
		& $action
	}
}

export-modulemember -function Read-Option, Read-Switch, Set-Interactive, Get-Interactive, Execute-Interactive, InteractiveMode-Set