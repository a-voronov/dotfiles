# Because the path of the zshrc changes upon rebuild, we cannot source it
# directly from the (vanilla) ~/.zshrc. Instead this script is created, which
# will source the latest zshrc.
#
# The zshrc script should be evaluated from the actual ~/.zshrc:
#   if [ -x "$(command -v zshrc)" ]; then $(zshrc); fi
{writeScriptBin}:
writeScriptBin "zshrc"
  ''
    echo ". ${./zshrc}"
  ''