@echo off
REM Christmas Accounting 
REM
setlocal EnableDelayedExpansion
if "%*" == "" (
 set day=today
 for /f "tokens=2,3 delims=/ " %%a in ('echo %date%') do (
  set mm=%%a
  set dd=%%b
 )
 set dd=1!dd!
 set /a dd-=100
 set mm=1!mm!
 set /a mm-=100
 if !mm!==12 (
  if !dd! GEQ 25 set /a day=!dd!-24
 )
 if !mm!==1 (
  if !dd! LEQ 5 set /a day=!dd!+7
 )
 if !day! == today echo It is not a day of Christmas today ^(!mm!/!dd!^). 
)
if NOT "%*" == "" (
 set day=%1
)
if exist %0 (
 set filename=%0
) else (
 if exist %0.bat (
  set filename=%0.bat
 ) else (
  set filename=%0.cmd
 )
)
if !day! GEQ 1 (
 if !day! LEQ 12 (
  if !day! == 1 set suffix=st
  if !day! == 2 set suffix=nd
  if !day! == 3 set suffix=rd
  if !day! GEQ 4 set suffix=th
  set array=-1
  for /f "tokens=1* delims= " %%a in ('type !filename!') do (
   if "%%a" == "DATA" (
    set /a array=!array!+1
    set gift.!array!=%%b
   )
  )
  echo Because it's the !day!!suffix! day of Christmas, 
  echo by now my true love should have sent to me: 
  set multi=1
  for /l %%a in (!day!,-1,1) do (
   set /a num=%%a*!multi!
   if !num! LEQ 9 set num= !num!
   if %%a == 1 (
    if !day! == 1 (
     echo     !num! !gift.0!
    ) else echo and !num! !gift.%%a! 
   )
   if %%a GTR 1 echo     !num! !gift.%%a!
   REM Well, the song doesn't really specify. So add everything up.  
   set /a multi+=1   
  ) 
 ) else echo Usage: %0 [1-12]
) else echo Usage: %0 [1-12]

exit /b

DATA partridge in a pear tree.
DATA partridges in pear trees.
DATA turtle doves
DATA French hens,
DATA calling birds,
DATA golden rings^!
DATA geese a-laying,
DATA swans a-swimming,
DATA maids a-milking,
DATA ladies dancing,
DATA lords a-leaping,
DATA pipers piping,
DATA drummers drumming,