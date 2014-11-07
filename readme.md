# Koshu.Interactive

Koshu plugin for simplifying user interactions in your psake scripts

## Usage

### Configuration

This plugin currently does not support configuration.

	config @{
		"Koshu.Interactive"=@{}
	}

### Read-Option

	Read-Option `
		-message <Message> `
		-options <OptionsArray> `
		-separator [<Separator>] ` # Optional. Defaults to '/'
		-abortable ` # Optional switch for adding an 'abort' option
		-onAbort [<ScriptBlock>] ` # Optional script block to execute if the abort option is specified
		-force # Optional switch for triggering a prompt even when InteractiveMode is set to $False

### Read-Switch

	Read-Switch `
		-message <Message> `
		-force # Optional switch for triggering a prompt even when InteractiveMode is set to $False

### Execute-Interactive

	Execute-Interactive `
		-message <Message> `
		-action <ScriptBlock> # Script block to execute if the user replies 'yes' to the prompt

### Set-Interactive

	Set-Interactive `
		-interactive <Bool>

Sets the InteractiveMode variable to the $True or $False

### Get-Interactive

	Get-Interactive

Returns the value of the InteractiveMode variable. If the variable hasn't been set, the user will be prompted to set it.

### InteractiveMode-Set

	InteractiveMode-Set

Returns $True if the InteractiveMode variable has been and $False if it hasn't been set.

### Examples

You can browse through the sample koshufile.ps1 in the examples directory if you need help getting started.

## License
MIT (http://opensource.org/licenses/mit-license.php)

## Contact
Kristoffer Ahl (project founder)  
Email: koshu@77dynamite.net  
Twitter: http://twitter.com/kristofferahl  
Website: http://www.77dynamite.com/