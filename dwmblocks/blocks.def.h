// blocks.h

// Define the structure for a block
typedef struct {
  char *icon;    // optional icon/text
  char *command; // shell command to run
  int interval;  // in seconds (0 = once)
  int signal;    // signal number for manual update
} Block;

// Define the blocks to show in the status bar
static const Block blocks[] = {
    //{ "", "~/.dotfiles/.config/bin/music.sh",        1,      0 },
    {" ", "~/.dotfiles/.config/bin/wifi.sh", 1, 0},
    {"\uf028 ", "pamixer --get-volume-human", 1, 10},
    {"\uf185 ", "brightnessctl | awk '/Current/ {print $4}' | tr -d '()'", 1,
     12},
    {"\uf017 ", "date '+%a %b %d %I:%M %p '", 10, 13},
};

#define DELIMITER " | "
#define DELIMITERENDLEN 3
