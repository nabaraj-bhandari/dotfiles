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
    {"  \uf1eb ",  "sb wifi", 1, 0},
    {"\uf028 ",  "sb volume", 1, 10},
    {"\uf185 ",  "sb brightness", 1,12},
    {"\uf538 ",  "sb memory", 10, 14},
    {"\uf0a0 ",  "sb disk", 60,  0},
    {"\uf073 ",  "sb date", 10, 13},
    {"\uf017 ",  "sb time", 10, 13},
};

#define DELIMITER " | "
#define DELIMITERENDLEN 3
