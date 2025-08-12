/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;       	/* border pixel of windows */
static const unsigned int snap      = 32;      	/* snap pixel */
static const int showbar            = 1;       	/* 0 means no bar */
static const int topbar             = 1;       	/* 0 means bottom bar */
static const int vertpad 			= 2; 		/* vertical padding of bar */
static const int sidepad 			= 4; 		/* vertical padding of bar */
static const char *fonts[]          = { "JetBrains Mono:size=12",
                                        "Noto Color Emoji:pixelsize=12:antialias=true:autohint=true" };
static const int gappx 		    = 4;       /* gaps between windows */

#include "/home/nabaraj/.cache/wal/colors-wal-dwm.h"

/*
static char *colors[][3] = {
    [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
    [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};
*/

/* Volume control commands */
static const char *audioMute[]      = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };
static const char *audioLowerVolume[]= { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL };
static const char *audioRaiseVolume[]= { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL };
static const char *audioMicMute[]   = { "pactl", "set-source-mute", "@DEFAULT_SOURCE@", "toggle", NULL };

/* Brightness control commands */
static const char *monBrightnessDown[]= { "brightnessctl", "set", "10%-", NULL };
static const char *monBrightnessUp[]= { "brightnessctl", "set", "+10%", NULL };

/* Player control commands */
static const char *audioPlay[]      = { "playerctl", "play-pause", NULL };
static const char *audioStop[]      = { "playerctl", "stop", NULL };
static const char *audioPrev[]      = { "playerctl", "previous", NULL };
static const char *audioNext[]      = { "playerctl", "next", NULL };

/* tagging */
static const char *tags[] = { "", "", "", "", "", "", "", " " };

/* Rules for floating windows, etc. */
static const Rule rules[] = {
    // class            instance    title       tags mask   isfloating   monitor
    { "st",      		NULL,       NULL,       1 << 0,     0,           -1 },
    { "firefox",        NULL,       NULL,       1 << 1,     0,           -1 },
    { "Code",           NULL,       NULL,       1 << 2,     0,           -1 },
    { "Thunar",         NULL,       NULL,       1 << 3,     0,           -1 },
    { "Qemu-system-x86_64", NULL,   "kali",		1 << 4,     0,           -1 },
    { "Qemu-system-x86_64", NULL,   "win11",	1 << 5,     0,           -1 },
    { "scrcpy",         NULL,       NULL,       1 << 0,     1,           -1 },
    { "mpv", 			NULL,   	NULL,		1 << 6,     0,           -1 },
};


/* layout(s) */
static const float mfact     = 0.55;  /* master area size [0.05..0.95] */
static const int nmaster     = 1;     /* number of clients in master area */
static const int resizehints = 1;     /* respect size hints in tiled resizals */
static const int lockfullscreen = 1;  /* force focus on fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    { "[]=",      tile },
    { "><>",      NULL },
    { "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
    { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
    { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
    { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* includes */
#include <X11/XF86keysym.h>

/* commands */
static const char *termcmd[]  = { "st", NULL };
static const char *dmenucmd[] = { "dmenu_run", NULL };
static const char *screenshot[] = { "scrot", "-s", "-e", "mv $f ~/Pictures/screenshots/", NULL };
static const char *fullscreenshot[] = { "scrot", "-e", "mv $f ~/Pictures/screenshots/", NULL };
//static const char *scrcpy[] = {"scrcpy",NULL };
static const char *kalicmd[]  = { "/home/nabaraj/.dotfiles/.config/bin/kali.sh", NULL };
static const char *win11cmd[]  = { "/home/nabaraj/.dotfiles/.config/bin/win11.sh", NULL };
static const char *ytcmd[]  = { "/home/nabaraj/.dotfiles/.config/bin/yt-media.sh", NULL };
static const char *localcmd[]  = { "/home/nabaraj/.dotfiles/.config/bin/media-play.sh", NULL };


/* key bindings */
static const Key keys[] = {
    /* modifier                     key           function        argument */
    // FUNCTION KEYS
    { 0,                            XF86XK_AudioMute,           spawn,  {.v = audioMute} },
    { 0,                            XF86XK_AudioLowerVolume,    spawn,  {.v = audioLowerVolume} },
    { 0,                            XF86XK_AudioRaiseVolume,    spawn,  {.v = audioRaiseVolume} },
    { 0,                            XF86XK_AudioMicMute,        spawn,  {.v = audioMicMute} },
    { 0,                            XF86XK_MonBrightnessDown,   spawn,  {.v = monBrightnessDown} },
    { 0,                            XF86XK_MonBrightnessUp,     spawn,  {.v = monBrightnessUp} },
    { 0,                            XK_Print, 			spawn,  {.v = screenshot } },
    { MODKEY,                       XK_Print, 			spawn,  {.v = fullscreenshot } },

    // MEDIA KEYS
    { 0,                            XF86XK_AudioPlay,           spawn,  {.v = audioPlay} },
    { 0,                            XF86XK_AudioStop,           spawn,  {.v = audioStop} },
    { 0,                            XF86XK_AudioPrev,           spawn,  {.v = audioPrev} },
    { 0,                            XF86XK_AudioNext,           spawn,  {.v = audioNext} },

    // LAUNCHERS
    { MODKEY,                       XK_a,      spawn,          {.v = dmenucmd } },
    { MODKEY,                       XK_y,      spawn,          {.v = ytcmd } },
    { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
    { MODKEY,                       XK_v,      spawn,          {.v = kalicmd } },
    { MODKEY, 			    XK_5,      view, 	       {.ui = 1 << 4} },
    { MODKEY,                       XK_w,      spawn,          {.v = win11cmd } },
    { MODKEY, 			    XK_6,      view, 	       {.ui = 1 << 5} },


    // WINDOW MANAGEMENT
    { MODKEY,                       XK_b,      togglebar,      {0} },
    { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
    { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
    { MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
    { MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
    { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
    { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
    { MODKEY,                       XK_Return, zoom,           {0} },
    { MODKEY,                       XK_Tab,    view,           {0} },
    { MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
    
    // LAYOUTS
    { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
    { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
    //{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
    { MODKEY,                       XK_m,      spawn,      		{.v = localcmd } },
    { MODKEY,                       XK_space,  setlayout,      {0} },
    { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },

    // MULTI-MONITOR
    { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
    { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
    { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
    { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
    { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
    { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },

    // TAG KEYS (only 5 tags)
    TAGKEYS(                        XK_1,                      0)
    TAGKEYS(                        XK_2,                      1)
    TAGKEYS(                        XK_3,                      2)
    TAGKEYS(                        XK_4,                      3)
    TAGKEYS(                        XK_5,                      4)
    TAGKEYS(                        XK_6,                      5)
    TAGKEYS(                        XK_7,                      6)
    TAGKEYS(                        XK_8,                      7)

    { MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
    /* click                event mask      button          function        argument */
    { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
    { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
    { ClkWinTitle,          0,              Button2,        zoom,           {0} },
    { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
    { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
    { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
    { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
    { ClkTagBar,            0,              Button1,        view,           {0} },
    { ClkTagBar,            0,              Button3,        toggleview,     {0} },
    { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
    { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

