Function fShow-LastCommands {
	<#
		.NOTES
			Author: Buchser Roger
		
		.SYNOPSIS
			Will display the Time in Seconds, the last Command took to execute.
			
		.PARAMETER Last
			Use this Paramater for the Number of last Commands to view. Default is 1.
			
		.DESCRIPTION
			Sometimes it is nice to to know about the Time, the last Commands took on Console.
	#>
	
	PARAM (
		[Int]$Last = 1
	)
	
	$LastCommands = Get-History -Count $Last
	If ($LastCommands) {
		$Result = @()
		ForEach ($Command in $LastCommands) {
			$RunTime = $Command.EndExecutionTime - $Command.StartExecutionTime
			$Obj = New-Object PsObject
			$Obj | Add-Member NoteProperty -Name 'Execution Time' -Value $Command.EndExecutionTime
			$Obj | Add-Member NoteProperty -Name 'Executed Command' -Value "[PS] $($Command.CommandLine)"
			$Obj | Add-Member NoteProperty -Name 'Elapsed Time' -Value "$($RunTime.Seconds) Seconds"
			$Result += $Obj
		}
		Return $Result
	} Else {
		Write-Host "`nNo Command executed yet...`n" -f DarkYellow
		Return $Null
	} 
}