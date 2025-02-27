//%attributes = {"invisible":true}
/*
PDFファイルのページ数を取得する例題
*/

var $PDF : 4D:C1709.File

$PDF:=File:C1566("/DATA/sample.pdf")

$pages:=pdf_get_pages($PDF)

ALERT:C41(String:C10($pages)+" pages")