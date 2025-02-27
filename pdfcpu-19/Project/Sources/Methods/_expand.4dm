//%attributes = {"invisible":true}
#DECLARE($in : Object)->$out : Object

If (OB Instance of:C1731($in; 4D:C1709.File)) | (OB Instance of:C1731($in; 4D:C1709.Folder))
	
	$out:=OB Class:C1730($in).new($in.platformPath; fk platform path:K87:2)
	
End if 