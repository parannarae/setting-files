# use bashrc
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi  

# virtualenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# language
LANG="en_US.UTF-8"
# LC_COLLATE="ko_KR.UTF-8"
# LC_CTYPE="ko_KR.UTF-8"
# LC_MESSAGES="ko_KR.UTF-8"
# LC_MONETARY="ko_KR.UTF-8"
# LC_NUMERIC="ko_KR.UTF-8"
# LC_TIME="ko_KR.UTF-8"
# LC_ALL=

# mysql 5.7 version
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
