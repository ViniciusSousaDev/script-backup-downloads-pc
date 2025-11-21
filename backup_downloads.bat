@echo off
:: Pega a data no formato YYYY-MM-DD
for /f "tokens=2 delims==" %%i in ('"wmic os get LocalDateTime /value | find /i "LocalDateTime""') do set dt=%%i
set data=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%

:: Define os caminhos
set origem=C:\Users\SeuUsuario\Downloads
set destino=E:\Usuario\SeuUsuario\Desktop\
set pastaBackup=Backup Downloads %data%
set destinoFinal=%destino%\%pastaBackup%

:: Cria a nova pasta de backup
mkdir "%destinoFinal%"

echo Iniciando backup de: %origem%
echo Salvando em: %destinoFinal%

:: Copia os arquivos
xcopy "%origem%" "%destinoFinal%" /E /H /C /I /Y

echo Backup concluído com sucesso!

:: Contagem e exclusão de backups antigos (mantém os 4 mais recentes)
setlocal enabledelayedexpansion
set count=0

:: Lista as pastas de backup em ordem cronológica
for /f "delims=" %%F in ('dir "%destino%\Backup Downloads*" /ad /b /o-d') do (
    set /a count+=1
    if !count! GTR 4 (
        echo Excluindo %%F
        rmdir /s /q "%destino%\%%F"
    )
)

endlocal

echo Limpeza de backups antigos concluída!
pause
