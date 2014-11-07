Param(
	[Parameter(Position=0,Mandatory=1)] [hashtable]$parameters,
	[Parameter(Position=1,Mandatory=1)] [hashtable]$config
)

if (get-module Koshu-Interactive) {
	remove-module Koshu-Interactive
}
$module = (join-path (resolve-path $parameters.packageDir) 'tools\Koshu-Interactive.psm1')
import-module $module -disablenamechecking -global -args $config