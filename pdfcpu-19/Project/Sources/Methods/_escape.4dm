//%attributes = {"invisible":true}
#DECLARE($in : Text)->$out : Text

$out:=$in

var $i; $len : Integer

Case of 
	: (Is Windows:C1573)
		
/*
argument escape for cmd.exe; other programs may be incompatible
*/
		
		$shoudQuote:=False:C215
		
		$metacharacters:="&|<>()%^\" "
		
		$len:=Length:C16($metacharacters)
		
		For ($i; 1; $len)
			$metacharacter:=Substring:C12($metacharacters; $i; 1)
			$shoudQuote:=$shoudQuote | (Position:C15($metacharacter; $out; *)#0)
			If ($shoudQuote)
				$i:=$len
			End if 
		End for 
		
		If ($shoudQuote)
			If (Substring:C12($out; Length:C16($out))="\\")
				$out:="\""+$out+"\\\""
			Else 
				$out:="\""+$out+"\""
			End if 
		End if 
		
	: (Is macOS:C1572)
		
/*
argument escape for bash or zsh; other programs may be incompatible
*/
		
		$metacharacters:="\\!\"#$%&'()=~|<>?;*`[] "
		
		For ($i; 1; Length:C16($metacharacters))
			$metacharacter:=Substring:C12($metacharacters; $i; 1)
			$out:=Replace string:C233($out; $metacharacter; "\\"+$metacharacter; *)
		End for 
		
End case 
