# brew nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# language
LANG="en_US.UTF-8"
# LC_COLLATE="ko_KR.UTF-8"
# LC_CTYPE="ko_KR.UTF-8"
# LC_MESSAGES="ko_KR.UTF-8"
# LC_MONETARY="ko_KR.UTF-8"
# LC_NUMERIC="ko_KR.UTF-8"
# LC_TIME="ko_KR.UTF-8"
# LC_ALL=

# Add postgresql@11 to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:/usr/local/opt/postgresql@11/bin"
export PGHOST=localhost
