Param(
    [String]$mdfile="README.md"
)


#$imgList =  Get-ChildItem -Recurse -exclude *.md, *.ps1* | Where-Object { ! $_.PSIsContainer }
$categoly=@("./仕事猫/figs","./仕事猫/ネタ/figs","./現場猫/figs","./現場猫/ネタ/figs","./その他/figs","./その他/ネタ/figs")
foreach ($cate in $categoly) {

 $imgList=Get-ChildItem -LiteralPath $cate -exclude *.md, *.ps1* | Where-Object { ! $_.PSIsContainer }

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
            $filemei= [System.IO.Path]::GetFileName($imgname);
            $imgname=$cate+"/"+$filemei
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
  
    $filemei= [System.IO.Path]::GetFileName($o);
    $outputname=$cate+"/"+$filemei

    $rink="["+$daimei+"]"+"("+$outputname+")"
   
    Write-Output "`<img width="300" src=$outputname>" | Out-File -Append $mdfile -Encoding utf8 -NoNewline
    Write-Output 「$rink」| Out-File -Append $mdfile -Encoding utf8 -NoNewline
    Write-Output " " | Out-File -Append $mdfile -Encoding utf8 -NoNewline
}

}