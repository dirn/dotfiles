#!/bin/bash

battery() {
  battery_symbol=$1
  battery_symbol_count=$2
  if [ $battery_symbol_count = "auto" ]; then
    columns=$(tmux display -p '#{client_width}' || echo 80)
    if [ $columns -gt 80 ]; then
      battery_symbol_count=10
    else
      battery_symbol_count=5
    fi
  fi
  battery_full_fg=$3
  battery_empty_fg=$4

  battery_symbol_heart_full=♥
  battery_symbol_heart_empty=♥
  battery_symbol_block_full=◼
  battery_symbol_block_empty=◻
  eval battery_symbol_full='$battery_symbol_'"$battery_symbol"'_full'
  eval battery_symbol_empty='$battery_symbol_'"$battery_symbol"'_empty'

  uname_s=$(uname -s)
  if [ $uname_s = Darwin ]; then
    batt=$(pmset -g batt)
    percentage=$(echo $batt |egrep -o [0-9]+%) || return
    charge="${percentage%%%} / 100"
  elif [ $uname_s = Linux ]; then
    batpath=/sys/class/power_supply/BAT0
    if [ ! -d $batpath ]; then
      batpath=/sys/class/power_supply/BAT1
    fi
    batfull=$batpath/energy_full
    batnow=$batpath/energy_now
    if [ ! -r $batfull -o ! -r $batnow ]; then
      return
    fi
    charge="$(cat $batnow) / $(cat $batfull)" || return
  fi

  full=$(printf %.0f $(echo "$charge * $battery_symbol_count" | bc -l))
  [ $full -gt 0 ] && \
    printf '#[fg=%s]' $battery_full_fg  && \
    printf "%0.s$battery_symbol_full" $(seq 1 $full)
  empty=$(($battery_symbol_count - $full))
  [ $empty -gt 0 ] && \
    printf '#[fg=%s]' $battery_empty_fg  && \
    printf "%0.s$battery_symbol_empty" $(seq 1 $empty)
}

echo $(battery $1 $2 $3 $4)
