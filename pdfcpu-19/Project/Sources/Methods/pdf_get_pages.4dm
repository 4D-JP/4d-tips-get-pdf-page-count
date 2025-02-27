//%attributes = {"invisible":true}
#DECLARE($PDF : 4D:C1709.File)->$pageCount : Integer

$PDF:=_expand($PDF)

If ($PDF#Null:C1517)
	If ($PDF.exists) & ($PDF.extension=".pdf")
		
		var $pdfcpu : 4D:C1709.File
		var $cmd : Text
		
		Case of 
			: (Is macOS:C1572)
				$pdfcpu:=File:C1566(File:C1566("/RESOURCES/bin/macOS/pdfcpu").platformPath; fk platform path:K87:2)
				SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY"; $pdfcpu.parent.platformPath)
				SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "true")
				LAUNCH EXTERNAL PROCESS:C811("chmod +x pdfcpu")
				$cmd:=_escape($pdfcpu.path)+" info -json "+_escape($PDF.path)
			: (Is Windows:C1573)
				$pdfcpu:=File:C1566(File:C1566("/RESOURCES/bin/Windows/pdfcpu.exe").platformPath; fk platform path:K87:2)
				$cmd:=_escape($pdfcpu.platformPath)+" info -json "+_escape($PDF.platformPath)
		End case 
		
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS"; "true")
		If (Is Windows:C1573)
			SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
		End if 
		
		var $stdIn; $stdOut; $stdErr : Blob
		LAUNCH EXTERNAL PROCESS:C811($cmd; $stdIn; $stdOut; $stdErr)
		
		var $json : Object
		Case of 
			: (Is macOS:C1572)
				$json:=JSON Parse:C1218(Convert to text:C1012($stdOut; "utf-8"); Is object:K8:27)
			: (Is Windows:C1573)
				$json:=JSON Parse:C1218(Convert to text:C1012($stdOut; "utf-16le"); Is object:K8:27)
		End case 
		
		$pageCount:=$json.infos.sum("pageCount")
		
	End if 
End if 