static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    [SchemeNorm] = {"#7ac3c8", "#050909"},
    [SchemeSel] = {"#7ac3c8", "#0E3A46"},
    [SchemeOut] = {"#7ac3c8", "#0F748B"},
};

static int topbar = 1;
static const char *fonts[] = {"JetBrains Mono:size=14"};
static const char *prompt = NULL;
static unsigned int lines = 10;
static const char worddelimiters[] = " ";
