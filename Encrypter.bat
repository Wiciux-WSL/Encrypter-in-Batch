@echo off
title Encrypter
chcp 65001 >nul

:menu
cls
echo ==========================   
echo       Choose encryption        EEEEEEE  NNN   NN   CCCCCCC    RRRRRRR    YY    YY PPPPPPP   TTTTTTTT  EEEEEEE  RRRRRRR
echo ==========================     EE       NNNN  NN  CCC   CCC   RR    RR    YY  YY  PP    PP  TT TT TT  EE       RR    RR
echo [1] Base64                     EEEEEEE  NN NN NN  CCC         RRRRRRR      YYYY   PPPPPPP      TT     EEEEEEE  RRRRRRR
echo [2] Bcrypt (not working)       EE       NN  NNNN  CCC   CCC   RR  RR        YY    PP           TT     EE       RR  RR
echo [3] MD5                        EEEEEEE  NN   NNN   CCCCCCC    RR   RR       YY    PP           TT     EEEEEEE  RR   RR
echo [4] SHA-256                        ====================
echo [5] ROT13                              BY  - WICIUX
echo [6] Caesar Cipher (+3)             ====================
echo [7] HEX
echo [8] Binary
echo [9] Reverse
echo [10]Github
echo [0] Exit
echo ==========================
set /p choice= Select option: 

if "%choice%"=="1" goto base64
if "%choice%"=="2" goto menu
if "%choice%"=="3" goto md5
if "%choice%"=="4" goto sha256
if "%choice%"=="5" goto rot13
if "%choice%"=="6" goto caesar
if "%choice%"=="7" goto hex
if "%choice%"=="8" goto binary
if "%choice%"=="9" goto reverse
if "%choice%"=="10" goto github
if "%choice%"=="0" exit
goto menu

:base64
cls
set /p text= Enter text: 
powershell -NoProfile -Command "[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('%text%'))"
pause
goto menu

:bcrypt
cls
set /p text= Enter text: 
powershell -NoProfile -Command "$pass = '%text%'; Add-Type -TypeDefinition '[DllImport(\"BCrypt.dll\")] public static extern int BCryptHashPassword(string password, int workFactor);' -Name 'BCrypt' -Namespace 'Security'; [Security.BCrypt]::BCryptHashPassword($pass,10)"
pause
goto menu

:md5
cls
set /p text= Enter text: 
powershell -NoProfile -Command "$hash = [System.Security.Cryptography.MD5]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes('%text%')); [BitConverter]::ToString($hash) -replace '-'"
pause
goto menu

:sha256
cls
set /p text= Enter text: 
powershell -NoProfile -Command "$hash = [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes('%text%')); [BitConverter]::ToString($hash) -replace '-'"
pause
goto menu

:rot13
cls
set /p text= Enter text: 
powershell -NoProfile -Command "$input = '%text%'; $rot13 = $input.ToCharArray() | ForEach-Object { if ($_ -match '[a-zA-Z]') { $ascii = [int]$_; if ($_ -cmatch '[A-Z]') { [char](65 + ($ascii - 65 + 13) %% 26) } else { [char](97 + ($ascii - 97 + 13) %% 26) } } else { $_ } }; -join $rot13"
pause
goto menu

:caesar
cls
set /p text= Enter text: 
powershell -NoProfile -Command "$input = '%text%'; $caesar = $input.ToCharArray() | ForEach-Object { if ($_ -match '[a-zA-Z]') { $ascii = [int]$_; if ($_ -cmatch '[A-Z]') { [char](65 + ($ascii - 65 + 3) %% 26) } else { [char](97 + ($ascii - 97 + 3) %% 26) } } else { $_ } }; -join $caesar"
pause
goto menu

:hex
cls
set /p text= Enter text: 
powershell -NoProfile -Command "[BitConverter]::ToString([Text.Encoding]::UTF8.GetBytes('%text%')) -replace '-'"
pause
goto menu

:binary
cls
set /p text= Enter text: 
powershell -NoProfile -Command "$input = '%text%'; $binary = ($input.ToCharArray() | ForEach-Object { [Convert]::ToString([byte][char]$_,2).PadLeft(8,'0') }) -join ' '; Write-Output $binary"
pause
goto menu

:reverse
cls
set /p text= Enter text: 
powershell -NoProfile -Command "$input = '%text%'; $reversed = -join ($input.ToCharArray() | ForEach-Object { $_ })[-1..-($input.Length)]; Write-Output $reversed"
pause
goto menu

:github
start https://github.com/Wiciux-WSL
goto menu