![version](https://img.shields.io/badge/version-19%2B-5682DF)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)
[![license](https://img.shields.io/github/license/4D-JP/4d-tips-get-pdf-page-count)](LICENSE)
![downloads](https://img.shields.io/github/downloads/4D-JP/4d-tips-get-pdf-page-count/total)

# 4d-tips-get-pdf-page-count
PDFファイルのページ数を取得する例題

```4d
var $PDF : 4D.File
$PDF:=File("/DATA/sample.pdf")
$pages:=pdf_get_pages($PDF)
```
