
/* the rate at which the mouse moves in Hz
 * does not change its speed */
static const unsigned int move_rate = 50;

/* the default speed of the mouse pointer
 * in pixels per second */
static const unsigned int default_speed = 500;

/* changes the speed of the mouse pointer */
static SpeedBinding speed_bindings[] = {
    /* key             speed */  
    { XK_Super_L,      3000 },
    { XK_r,            1500 },
    { XK_e,              10 },
    { XK_w,             100 },
};

/* moves the mouse pointer
 * you can also add any other direction (e.g. diagonals) */
static MoveBinding move_bindings[] = {
    /* key         x      y */
    { XK_j,        -1,     0 },
    { XK_l,         1,     0 },
    { XK_i,         0,    -1 },
    { XK_k,         0,     1 },
};

/* 1: left
 * 2: middle
 * 3: right */
static ClickBinding click_bindings[] = {
    /* key         button */  
    { XK_space,    1 },
    { XK_f,        1 },
    { XK_d,        2 },
    { XK_s,        3 },
    { XK_y,        8 },
};

/* scrolls up, down, left and right
 * a higher value scrolls faster */
static ScrollBinding scroll_bindings[] = {
    /* key        x      y */
    { XK_n,        0 ,    25 },
    { XK_o,        0 ,   -25 },
    { XK_plus,     0 ,    80 },
    { XK_minus,    0 ,   -80 },
    { XK_h,        25,    0  },
    { XK_g,       -25,    0  },
};

/* executes shell commands */
static ShellBinding shell_bindings[] = {
	/* key         command */  
	{ XK_b,        "wmctrl -a firefox" },
	{ XK_0,        "xdotool mousemove 0 0" },
};

/* exits on key release which allows click and exit with one key */
static KeySym exit_keys[] = {
  	XK_Escape, XK_q, 0xffffff
};
