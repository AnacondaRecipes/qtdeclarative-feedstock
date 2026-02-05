@REM https://bugreports.qt.io/browse/QTBUG-107009
@REM Short build path on C: to avoid Windows path length limits on CI
set "BUILD_DIR=%SystemDrive%\qtdecl_%PKG_VERSION%"
set "PATH=%BUILD_DIR%\lib\qt6\bin;%PATH%"

cmake --log-level STATUS -S"%SRC_DIR%\%PKG_NAME%" -B"%BUILD_DIR%" -GNinja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ^
    -DINSTALL_BINDIR=lib/qt6/bin ^
    -DINSTALL_PUBLICBINDIR=bin ^
    -DINSTALL_LIBEXECDIR=lib/qt6 ^
    -DINSTALL_DOCDIR=share/doc/qt6 ^
    -DINSTALL_ARCHDATADIR=lib/qt6 ^
    -DINSTALL_DATADIR=share/qt6 ^
    -DINSTALL_INCLUDEDIR=include/qt6 ^
    -DINSTALL_MKSPECSDIR=lib/qt6/mkspecs ^
    -DINSTALL_EXAMPLESDIR=share/doc/qt6/examples ^
    -DINSTALL_DATADIR=share/qt6
if errorlevel 1 exit 1

cmake --build "%BUILD_DIR%" --target install
if errorlevel 1 exit 1

xcopy /y /s %LIBRARY_PREFIX%\lib\qt6\bin\*.dll %LIBRARY_PREFIX%\bin
if errorlevel 1 exit 1

copy %LIBRARY_PREFIX%\lib\qt6\bin\qml.exe %LIBRARY_PREFIX%\bin\qml6.exe
if errorlevel 1 exit 1
copy %LIBRARY_PREFIX%\lib\qt6\bin\qmlpreview.exe %LIBRARY_PREFIX%\bin\qmlpreview6.exe
if errorlevel 1 exit 1
copy %LIBRARY_PREFIX%\lib\qt6\bin\qmlscene.exe %LIBRARY_PREFIX%\bin\qmlscene6.exe
if errorlevel 1 exit 1
copy %LIBRARY_PREFIX%\lib\qt6\bin\qmleasing.exe %LIBRARY_PREFIX%\bin\qmleasing6.exe
if errorlevel 1 exit 1

rd /s /q "%BUILD_DIR%" 2>nul
