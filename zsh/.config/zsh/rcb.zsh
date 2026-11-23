# rcb — Claude Code Remote Control „do batohu“
# Použití: v repu spusť `rcb` (volitelně `rcb "název session"`).
#          `rcb --resume` = pokračovat ve starším chatu.
# Hranice baterie: RCB_MIN_BATT=20 rcb   (výchozí 15 %)

rcb() {
  emulate -L zsh

  case "$1" in
    --check)
      if pmset -g | grep -q 'SleepDisabled[[:space:]]*1'; then
        print "⚠ Uspávání je VYPNUTÉ – Mac po zavření víka nespí. Zapni: rcb --disable"
      else
        print "✓ Uspávání je zapnuté – Mac po zavření víka normálně usne."
      fi
      return ;;
    --disable)
      sudo pmset -a disablesleep 0 && print "✓ Uspávání zase zapnuto."
      return ;;
    -h|--help)
      print "rcb [název]   spustí Remote Control a vypne uspávání"
      print "rcb --check   ukáže, jestli Mac po zavření víka usne"
      print "rcb --resume  vybereš starší chat a pokračuješ v něm z telefonu"
      print "rcb --disable vrátí normální uspávání"
      return ;;
  esac

  local mode=new
  if [[ "$1" == --resume || "$1" == resume ]]; then
    mode=resume; shift
  fi

  local name="${1:-${PWD:t}}"
  local min_batt="${RCB_MIN_BATT:-15}"

  command -v claude >/dev/null || { print -u2 "✗ claude není v PATH"; return 1 }

  # Internet (hotspot) – jen varování
  curl -s -m 4 -o /dev/null https://claude.ai \
    || print -u2 "⚠ Nevidím internet – zapni hotspot, jinak se session po ~10 min odpojí."

  print "→ Vypínám uspávání (i při zavřeném víku)…"
  sudo pmset -a disablesleep 1 || return 1

  # Hlídač: drží sudo naživu a při nízké baterii vrátí uspávání,
  # takže se Mac v batohu uspí a nevybije se do nuly.
  (
    while sleep 60; do
      sudo -n -v 2>/dev/null
      local batt="$(pmset -g batt)"
      if [[ $batt == *"Battery Power"* ]]; then
        local pct=$(print -r -- "$batt" | grep -Eo '[0-9]+%' | head -1 | tr -d %)
        if (( pct <= min_batt )); then
          sudo -n pmset -a disablesleep 0
          osascript -e "display notification \"Baterie ${pct} % – uspávání zapnuto\" with title \"rcb\""
          break
        fi
      fi
    done
  ) &!
  local watcher=$!

  # Po ukončení (i Ctrl-C) vše vrátit
  trap "kill $watcher 2>/dev/null; sudo pmset -a disablesleep 0; print '→ Uspávání zase zapnuto.'" EXIT

  if [[ $mode == resume ]]; then
    print "→ Vyber chat. Remote Control se zapne sám (kdyby ne, napiš /rc)."
    claude --resume --remote-control
  else
    print "→ Spouštím Remote Control „$name“ (mezerník = QR kód)"
    claude remote-control --name "$name"
  fi
}
