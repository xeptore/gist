if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

mkcd() {
  mkdir -p "$@" && cd "${@: -1}"
}
