// Simple script to get a battery icon from the arg, written in C for speed
#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <wchar.h>

struct output {
  wchar_t *text;
  wchar_t *alt;
  wchar_t *tooltip;
  wchar_t *class;
  int percentage;
};

void print_output(struct output *output) {
  wprintf(L"{\"text\":\"%ls\",\"alt\":\"%ls\",\"tooltip\":\"%ls\",\"class\":["
          L"\"battery\",\"%ls\"],\"percentage\":%d}\n",
          output->text, output->alt, output->tooltip, output->class,
          output->percentage);
}

// {{{ Getters
int get_energy() {
  FILE *fn = fopen("/sys/class/power_supply/BAT1/energy_now", "r");

  char buf[9] = {0};
  fread(buf, 1, 8, fn);
  fclose(fn);

  return atoi(buf);
}

int get_power() {
  FILE *fn = fopen("/sys/class/power_supply/BAT1/power_now", "r");

  // It only goes to 8 when charging, but i'm adding one more order of magnitude
  // jic
  char buf[10] = {0};
  fread(buf, 1, 9, fn);
  fclose(fn);

  return atoi(buf);
}

int get_full_energy() {
  FILE *cap = fopen("/sys/class/power_supply/BAT1/energy_full", "r");

  char buf[9] = {0};
  fread(buf, 1, 8, cap);
  fclose(cap);

  return atoi(buf);
}

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

/* Gets the alt text
 * Format: 110% (123456:23 left) 󰂑
 * 22 wchars + 1 null
 */
wchar_t *get_alt(int capacity, wchar_t icon, char status) {
  int energy = get_energy();
  int power = get_power();

  // Get how much time until full charge when charging
  double hours_left = status == 'C'
                          ? (double)(get_full_energy() - energy) / (double)(power)
                          : (double)energy / (double)power;

  int hours = (int)hours_left;
  int minutes = (int)((hours_left - hours) * 60);

  wchar_t *str;
  if (hours >= 0) {
    str =  calloc(sizeof(wchar_t), 25);
    wmemset(str, 0, 25);
    swprintf(str, 24, L"%d%% (%02d:%02d left) %lc ", capacity, hours, minutes, icon);
  } else {
    // Integer overflowed
    str =  calloc(sizeof(wchar_t), 21);
    wmemset(str, 0, 21);
    swprintf(str, 20, L"%d%% (Very long) %lc ", capacity, icon);

  }

  return str;
}
// }}}

// {{{ Icon getters
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
// }}}

int main(int argc, char **argv) {
  setlocale(LC_CTYPE, "");

  struct output output;

  char status = get_status();
  int bat = get_capacity();
  output.percentage = bat;

  wchar_t icon;
  wchar_t *alt = NULL;

  switch (status) {
  case 'F':
  case 'D':
    icon = discharging_batticon(bat);
    break;

  case 'C':
    icon = charging_batticon(bat);
    break;

  default:
    icon = 0xf0091; // 󰂑
  }

  switch (status) {
  case 'F':
    output.class = L"full";
    output.tooltip = L"Full";
    break;

  case 'D':
    output.class = bat <= 20 ? L"critical" : L"discharging";
    output.tooltip = L"Discharging";
    break;

  case 'C':
    output.class = L"charging";
    output.tooltip = L"Charging";
    break;

  case 'N':
    output.class = L"not-charging";
    output.tooltip = L"Not charging";
    break;

  default:
    output.class = L"unknown";
    output.tooltip = L"Unknown";
  }

  // Longest string: 100%󰁹
  wchar_t *text = calloc(sizeof(wchar_t), 8);
  wmemset(text, 0, 8);
  swprintf(text, 7, L"%d%% %lc ", bat, icon);

  alt = get_alt(bat, icon, status);

  output.text = text;
  output.alt = alt == NULL ? L"" : alt;

  print_output(&output);
  free(text);
  free(alt);
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
