function tellme() {
  echo "$*" \
    | fmt -20 - \
    | osd_cat -c red -p middle -A center \
              -f "-*-*-bold-i-*-*-128-*-*-*-*-*-*-*"
}
