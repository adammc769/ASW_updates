@echo off
title ADAMSOFTWARE 1.2 - multimenialny dysk
echo TLC LOADER
color 1F
mode con: cols=60 lines=25
chcp 65001 > nul

echo ustawienie: Ścieżki
set "ROOT=%~dp0"
set "APPS=%ROOT%apps"
set "DANE=%ROOT%dane"
set "SYS=%ROOT%system"

echo Sprawdzenie folderów
if not exist "%APPS%" mkdir "%APPS%"
if not exist "%DANE%" mkdir "%DANE%"
if not exist "%SYS%" mkdir "%SYS%"

::autorun pliku
start TLCLOAD\auto\auto.bat
if exist TLCLOAD\update\update.bat (
    echo wykryto aktualizacje
    echo program będzie sie aktualizował za 3 sek.
    timeout /t 3 /nobreak > nul
    start TLCLOAD\update\update.bat
    exit
)
:MENU
cls
echo ==================================================
echo              ADAMSOFTWARE 1.2 - multimedialny dysk          
echo ==================================================
echo [1] Uruchom program z katalogu APPS
echo [2] Wyświetl dane użytkownika
echo [3] Informacje o systemie
echo [4] Otwórz folder ADAMSOFTWARE
echo [5] Zakończ
echo [6] otwarzacze
echo [7] dokumenty
echo --------------------------------------------------
set /p wybor=Wybierz opcję: 

if "%wybor%"=="1" goto PROGRAMY
if "%wybor%"=="2" goto DANE
if "%wybor%"=="3" goto INFO
if "%wybor%"=="4" start "" "%ROOT%" & goto MENU
if "%wybor%"=="5" exit
if "%wybor%"=="6" (
    goto otw
    
)
if "%wybor%"=="7" (
    cls
    start DOC.bat
    goto MENU
)
goto MENU

:PROGRAMY
cls
echo === Programy w folderze APPS ===
set i=0
for %%f in ("%APPS%\*") do (
    set /a i+=1
    echo !i! - %%~nxf
)
echo (Umieść pliki w folderze ADAMSOFTWARE/apps/)
pause
goto MENU

:DANE
cls
if exist "%DANE%\pliki.txt" (
    type "%DANE%\pliki.txt"
) else (
    echo Brak pliku: dane\pliki.txt
)
pause
goto MENU

:INFO
cls
echo === Informacje o systemie ASW ===
echo Wersja systemu: 
if exist "%SYS%\wersja.txt" (
    type "%SYS%\wersja.txt"
) else (
    echo Brak pliku wersji.
)
echo.
echo Data systemowa: %DATE%
echo Czas: %TIME%
echo Nazwa użytkownika: %USERNAME%
echo Folder ASW: %ROOT%
pause
goto MENU

:otw
cls
echo ============ OTWÓRZ ODTWARZACZ =============
echo [1] AVS Media Player (wideo)
echo [2] JetAudio (muzyka)
echo [3] IrfanView (zdjęcia)
echo [4] Wróć do głównego menu
echo --------------------------------------------
set /p otwopt=Wybierz program: 

if "%otwopt%"=="1" (
    if exist "Mediaplayer\AVSMediaPlayer.exe" (
        start "" "Mediaplayer\AVSMediaPlayer.exe"
    ) else (
        echo [BŁĄD] Brak: AVSMediaPlayer.exe
        pause
    )
    goto MENU
)

if "%otwopt%"=="2" (
    if exist "musicplayer\JetAudio.exe" (
        start "" "musicplayer\JetAudio.exe"
    ) else (
        echo [BŁĄD] Brak: JetAudio.exe
        pause
    )
    goto MENU
)

if "%otwopt%"=="3" (
    if exist "photowiever\i_view64.exe" (
        start "" "photowiever\i_view64.exe"
    ) else (
        echo [BŁĄD] Brak: i_view64.exe
        pause
    )
    goto MENU
)

if "%otwopt%"=="4" goto MENU

goto otw
