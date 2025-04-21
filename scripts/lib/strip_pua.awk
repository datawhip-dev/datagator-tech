# strip_pua.awk — removes Unicode Private Use Area (PUA) codepoints from UTF-8 input
function utf8_to_cp(b,    n, cp) {
  split(b, n, " ")
  if (length(n) == 1) return strtonum("0x" n[1])
  else if (length(n) == 2) return ((strtonum("0x" n[1]) AND 0x1F) << 6) + (strtonum("0x" n[2]) AND 0x3F)
  else if (length(n) == 3) return ((strtonum("0x" n[1]) AND 0x0F) << 12) + ((strtonum("0x" n[2]) AND 0x3F) << 6) + (strtonum("0x" n[3]) AND 0x3F)
  else if (length(n) == 4) return ((strtonum("0x" n[1]) AND 0x07) << 18) + ((strtonum("0x" n[2]) AND 0x3F) << 12) + ((strtonum("0x" n[3]) AND 0x3F) << 6) + (strtonum("0x" n[4]) AND 0x3F)
  return -1
}
{
  i = 1
  while (i <= NF) {
    c1 = strtonum("0x" $i)
    if (c1 < 0x80) len = 1
    else if ((c1 AND 0xE0) == 0xC0) len = 2
    else if ((c1 AND 0xF0) == 0xE0) len = 3
    else if ((c1 AND 0xF8) == 0xF0) len = 4
    else len = 1

    b = ""; for (j = 0; j < len; j++) b = b $((i + j)) " "
    cp = utf8_to_cp(b)

    if (!((cp >= 0xE000  && cp <= 0xF8FF) || (cp >= 0xF0000 && cp <= 0xFFFFD) || (cp >= 0x100000 && cp <= 0x10FFFD))) {
      for (j = 0; j < len; j++) printf "%s", sprintf("%c", strtonum("0x" $((i + j))))
    }
    i += len
  }
}
