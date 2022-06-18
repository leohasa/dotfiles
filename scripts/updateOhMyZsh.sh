#!/bin/zsh

OZSH=~/.dotfiles/.oh-my-zsh

echo Cambiando a directorio de oh my zsh
cd $OZSH
echo Guardando cambios en rama actual
git stash save "Cambios propios"
echo Cambiando a rama master
git checkout master
echo Actualizando repositorio
git pull upstream master

echo --------------------------------------------------
echo Cambiando a directorio de powerlevel10k
cd $OZSH/custom/themes/powerlevel10k/
echo Verificando actualizaciones
git pull

echo --------------------------------------------------
echo Cambiando a directorio de enhancd
cd $OZSH/custom/plugins/enhancd/
echo Verificando actualizaciones
git pull

echo --------------------------------------------------
echo Cambiando a directorio de zsh-autosuggestions
cd $OZSH/custom/plugins/zsh-autosuggestions/
echo Verificando actualizaciones
git pull

echo --------------------------------------------------
echo Cambiando a directorio de zsh-completions
cd $OZSH/custom/plugins/zsh-completions/
echo Verificando actualizaciones
git pull

echo --------------------------------------------------
echo Cambiando a directorio de zsh-history-substring-search
cd $OZSH/custom/plugins/zsh-history-substring-search/
echo Verificando actualizaciones
git pull

echo --------------------------------------------------
echo Cambiando a directorio de zsh-syntax-highlighting
cd $OZSH/custom/plugins/zsh-syntax-highlighting/
echo Verificando actualizaciones
git pull

echo ---------------------------------------------------
echo Cambiando a directorio de zsh-docker-aliases
cd $OZSH/custom/plugins/zsh-docker-aliases
echo Guardando cambios
git stash save "cambios propios docker"
echo Verificando actualizaciones
git pull
echo Aplicando cambios
git stash pop

echo --------------------------------------------------
echo Cambiando a directorio de k
cd $OZSH/custom/plugins/k/
echo Verificando actualizaciones
git pull

cd $OZSH
echo Haciendo merge con rama propia
git checkout ohwn-my-zsh
git stash pop
git merge master

#echo Subiendo cambios a fork
#git push

echo Verificacion de actualizaciones finalizada con exito
