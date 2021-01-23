Param(
    [String]$mdfile="sonotaneta.md"
)
$imgList =  Get-ChildItem  -exclude *.md, *.ps1* | Where-Object { ! $_.PSIsContainer }

$Flag=1
$outputarr=@()
$f = (Get-Content $mdfile) -as [string[]]

foreach ($img in $imgList) {
    [String] $imgname="`""+[System.IO.Path]::GetFileName($img) + "`""
    
    foreach ($l in $f) {
        $arr=$l -split "=" -split ">"
        # 配列の内容をすべて出力する。
        for($i=0; $i -lt $arr.Length; $i ++){
            [String] $name=$arr[$i]
            If($name -like $imgname){
                $Flag=0
            }
        }
    }
    IF($Flag -eq 1){
        $outputarr+=$imgname
    }
    $Flag=1
}

foreach ($o in $outputarr) {
    $ca=$o -split "`"" 
    $caption=$ca[1]
    $daimei= [System.IO.Path]::GetFileNameWithoutExtension($caption);
    
   
    Write-Output "`<img width="300" src=$o`>" | Out-File -Append $mdfile -Encoding utf8 -NoNewline
    Write-Output 「$daimei」| Out-File -Append $mdfile -Encoding utf8 -NoNewline
    Write-Output " " | Out-File -Append $mdfile -Encoding utf8 -NoNewline
}


