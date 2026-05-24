# Linux evdev scancodes (KEY_* from input-event-codes.h)
# Use for non-latin layout support — scancodes map to physical keys
{
  # Letters (row by row, QWERTY)
  Q = 16; W = 17; E = 18; R = 19; T = 20; Y = 21; U = 22; I = 23; O = 24; P = 25;
  A = 30; S = 31; D = 32; F = 33; G = 34; H = 35; J = 36; K = 37; L = 38;
  Z = 44; X = 45; C = 46; V = 47; B = 48; N = 49; M = 50;

  # Numbers
  "1" = 2; "2" = 3; "3" = 4; "4" = 5; "5" = 6;
  "6" = 7; "7" = 8; "8" = 9; "9" = 10; "0" = 11;

  # Function keys
  F1 = 59; F2 = 60; F3 = 61; F4 = 62; F5 = 63; F6 = 64;
  F7 = 65; F8 = 66; F9 = 67; F10 = 68; F11 = 87; F12 = 88;

  # Modifiers
  LeftCtrl = 29; LeftShift = 42; LeftAlt = 56; LeftMeta = 125;
  RightCtrl = 97; RightShift = 54; RightAlt = 100; RightMeta = 126;
  CapsLock = 58; Tab = 15; Enter = 28; Space = 57; Backspace = 14; Esc = 1;

  # Navigation
  Insert = 110; Delete = 111; Home = 102; End = 107;
  PageUp = 104; PageDown = 109;
  Up = 103; Down = 108; Left = 105; Right = 106;
}
