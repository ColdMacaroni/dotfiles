// Simple script to get a battery icon from the arg, written in C for speed
// TODO: Takes in `status` `charge`
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>

int get_capacity() {
  FILE *cap = fopen("/sys/class/power_supply/BAT1/capacity", "r");

  // Shouldn't need to read more than 3 characters
  char buf[4] = {0};
  fread(buf, 1, 3, cap);
  fclose(cap);

  return atoi(buf);
}

/**
 * From the kernel code, these are the statuses.
 * https://github.com/torvalds/linux/blob/master/include/linux/power_supply.h
 *
 * POWER_SUPPLY_STATUS_UNKNOWN:      U
 * POWER_SUPPLY_STATUS_CHARGING:     C
 * POWER_SUPPLY_STATUS_DISCHARGING:  D
 * POWER_SUPPLY_STATUS_NOT_CHARGING: N
 * POWER_SUPPLY_STATUS_FULL:         F
 */
char get_status() {
  FILE *status = fopen("/sys/class/power_supply/BAT1/status", "r");

  // We shouldn't need more than one character to identify status.
  char c;
  fread(&c, 1, 1, status);

  fclose(status);
  return c;
}

/* Returns the icon for a discharging battery */
int discharging_batticon(int bat) {
  if (bat >= 90) {
    return 0xf0079; // 󰁹
  } else if (bat >= 80) {
    return 0xf0082; // 󰂂
  } else if (bat >= 70) {
    return 0xf0081; // 󰂁
  } else if (bat >= 60) {
    return 0xf0080; // 󰂀
  } else if (bat >= 50) {
    return 0xf007f; // 󰁿
  } else if (bat >= 40) {
    return 0xf007e; // 󰁾
  } else if (bat >= 30) {
    return 0xf007d; // 󰁽
  } else if (bat >= 20) {
    return 0xf007c; // 󰁼
  } else if (bat >= 10) {
    return 0xf007b; // 󰁻
  } else if (bat >= 8) {
    return 0xf007a; // 󰁺
  } else {
    return 0xf0083; // 󰂃
  }
}

/* Returns the icon for a charging battery */
int charging_batticon(int bat) {
  if (bat >= 90) {
    return 0xf0085; // 󰂅  100
  } else if (bat >= 80) {
    return 0xf008b; // 󰂋  90
  } else if (bat >= 70) {
    return 0xf008a; // 󰂊  80
  } else if (bat >= 60) {
    return 0xf089e; // 󰢞  70
  } else if (bat >= 50) {
    return 0xf0089; // 󰂉  60
  } else if (bat >= 40) {
    return 0xf089d; // 󰢝  50
  } else if (bat >= 30) {
    return 0xf0088; // 󰂈  40
  } else if (bat >= 20) {
    return 0xf0087; // 󰂇  30
  } else if (bat >= 10) {
    return 0xf0086; // 󰂆  20
  } else if (bat >= 8) {
    return 0xf089c; // 󰢜  10
  } else {
    return 0xf089f; // 󰢟  low
  }
}

int main(int argc, char **argv) {
  setlocale(LC_CTYPE, "");

  char status = get_status();
  int bat = get_capacity();

  switch (status) {
  case 'F':
  case 'D':
    putwchar(discharging_batticon(bat));
    break;

  case 'C':
    putwchar(charging_batticon(bat));
    break;

  default:
    putwchar(0xf0091); // 󰂑
  }

  putwchar('\n');
}

/*
 * f0079 󰁹
 * f007a 󰁺
 * f007b 󰁻
 * f007c 󰁼
 * f007d 󰁽
 * f007e 󰁾
 * f007f 󰁿
 * f0080 󰂀
 * f0081 󰂁
 * f0082 󰂂
 * f0083 󰂃
 * f0084 󰂄
 * f0085 󰂅
 * f0086 󰂆
 * f0087 󰂇
 * f0088 󰂈
 * f0089 󰂉
 * f008a 󰂊
 * f008b 󰂋
 * f008c 󰂌
 * f008d 󰂍
 * f008e 󰂎
 * f008f 󰂏
 * f0090 󰂐
 * f0091 󰂑
 */
