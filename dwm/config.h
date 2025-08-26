/* appearance */
static const unsigned int borderpx = 1; /* border pixel of windows */
static const unsigned int snap = 32;    /* snap pixel */
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */
static const int vertpad = 4;           /* vertical padding of bar */
static const int sidepad = 4;           /* horizontal padding of bar */
static const char *fonts[] = {"JetBrains Mono:size=12"};
static const int gappx = 4; /* gaps between windows */

#include "/home/nabaraj/.cache/wal/colors-wal-dwm.h"

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7"};

/* no rules at all */
static const Rule rules[] = {
    {NULL, NULL, NULL, 0, 0, -1},
};

/* layout(s) */
static const float mfact = 0.55;     /* master area size [0.05..0.95] */
static const int nmaster = 1;        /* number of clients in master area */
static const int resizehints = 0;    /* ignore size hints for better tiling */
static const int lockfullscreen = 1; /* force focus on fullscreen window */

static const Layout layouts[] = {
    {"[]=", tile},
    {"[M]", monocle},
    {"><>", NULL},
};

/* key definitions */
#define MODKEY Mod4Mask

#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

#include <X11/XF86keysym.h>

/* commands */
static const char *termcmd[] = {"st", NULL};
static const char *dmenucmd[] = {"dmenu_run", NULL};
static const char *ytcmd[] = {"yt", NULL};
static const char *audioMute[] = {"pactl", "set-sink-mute", "@DEFAULT_SINK@",
                                  "toggle", NULL};
static const char *audioLowerVolume[] = {"pactl", "set-sink-volume",
                                         "@DEFAULT_SINK@", "-5%", NULL};
static const char *audioRaiseVolume[] = {"pactl", "set-sink-volume",
                                         "@DEFAULT_SINK@", "+5%", NULL};
static const char *audioMicMute[] = {"pactl", "set-source-mute",
                                     "@DEFAULT_SOURCE@", "toggle", NULL};
static const char *monBrightnessDown[] = {"brightnessctl", "set", "10%-", NULL};
static const char *monBrightnessUp[] = {"brightnessctl", "set", "+10%", NULL};
static const char *screenshot[] = {"flameshot", "gui", NULL};
static const char *fullscreenshot[] = {
    "flameshot", "full", "-c", "-p", "/home/nabaraj/Pictures/screenshots",
    NULL};

/* key bindings */
static const Key keys[] = {
    /* modifier                     key           function        argument */
    // FUNCTION KEYS
    {0, XF86XK_AudioMute, spawn, {.v = audioMute}},
    {0, XF86XK_AudioLowerVolume, spawn, {.v = audioLowerVolume}},
    {0, XF86XK_AudioRaiseVolume, spawn, {.v = audioRaiseVolume}},
    {0, XF86XK_AudioMicMute, spawn, {.v = audioMicMute}},
    {0, XF86XK_MonBrightnessDown, spawn, {.v = monBrightnessDown}},
    {0, XF86XK_MonBrightnessUp, spawn, {.v = monBrightnessUp}},
    {0, XK_Print, spawn, {.v = screenshot}},
    {MODKEY, XK_Print, spawn, {.v = fullscreenshot}},

    // LAUNCHERS
    {MODKEY, XK_a, spawn, {.v = dmenucmd}},
    {MODKEY, XK_y, spawn, {.v = ytcmd}},
    {MODKEY | ShiftMask, XK_Return, spawn, {.v = termcmd}},

    // WINDOW MANAGEMENT
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_Return, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY | ShiftMask, XK_c, killclient, {0}},

    // LAYOUTS
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_m, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_f, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_space, setlayout, {0}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},

    // MULTI-MONITOR
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},

    // TAG KEYS
    TAGKEYS(XK_1, 0)
    TAGKEYS(XK_2, 1)
    TAGKEYS(XK_3, 2)
    TAGKEYS(XK_4, 3)
    TAGKEYS(XK_5, 4)
    TAGKEYS(XK_6, 5)
    TAGKEYS(XK_7, 6)

    {MODKEY | ShiftMask, XK_q, quit, {0}},
};

/* button definitions */
static const Button buttons[] = {
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
