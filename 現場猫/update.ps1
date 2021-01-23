Param(
    [String]$mdfile="genbaneko.md"
)
$imgList =  Get-ChildItem -LiteralPath ./figs -exclude *.md, *.ps1* | Where-Object { ! $_.PSIsContainer }

$Flag=1
$outputarr=@()
$f = (Get-Content $mdfile) -as [string[]]

foreach ($img in $imgList) {
    [String] $imgname="./figs/"+[System.IO.Path]::GetFileName($img)
    
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
    $daimei= [System.IO.Path]::GetFileNameWithoutExtension($o);
    
   
    Write-Output "`<img width="250" src=$o>" | Out-File -Append $mdfile -Encoding utf8 -NoNewline
    Write-Output 「$daimei」| Out-File -Append $mdfile -Encoding utf8 -NoNewline
    Write-Output " " | Out-File -Append $mdfile -Encoding utf8 -NoNewline
}
