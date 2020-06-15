![image](https://user-images.githubusercontent.com/3623889/29297542-c85086e0-819c-11e7-9245-70ea55b3bdc3.png)



```
wget https://ftp.gnu.org/gnu/emacs/emacs-26.3.tar.gz
tar zxvf emacs-26.3.tar.gz
cd emacs-26.3
./configure --without-x -with-gnutls=no
sudo make install

git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd
wget https://raw.githubusercontent.com/hsnks100/emacsdots/master/.spacemacs 
```
