ln -s /data/data/org.gnu.emacs/files/ ~/emacs
ln -s ~/ ~/emacs/termux
mkdir ~/.emacs.d
ln -s ~/.emacs.d ~/emacs/.emacs.d
ln -s ~/storage ~/emacs/storage

cp *.el ~/.emacs.d/
