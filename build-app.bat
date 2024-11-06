@echo off
set BUILD_DIR="dist"
echo "Creation du dossier de build DIST s il n existe pas"
if not exist %BUILD_DIR% (
md %BUILD_DIR%
)
echo "Copie des fichiers sources dans le dossier de build"
copy index.html %BUILD_DIR%\
copy script.js %BUILD_DIR%\
copy style.css %BUILD_DIR%\
copy Dockerfile %BUILD_DIR%\
copy .dockerignore %BUILD_DIR%\
copy build-app.bat %BUILD_DIR%\
echo "Compression des fichiers HTML, CSS et JS"
for %%F in (index.html script.js style.css) do (
echo Compression de %%F...
compact /c %%F
)
echo "Creation de l image de l application Web"
docker build -t image-from-jenkins .
echo "Creation du conteneur correspondant"

docker run -d -p 2020:80 --name container-from-jenkins image-from-jenkins

echo "Verification de la presence du conteneur sur Docker"
docker ps
echo "Build terminé."