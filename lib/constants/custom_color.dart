Map<String, Map<String, int>> colors = {
  "grass": {"base": 0xff49d0b0, "background": 0xff60e1c8},
  "fire": {"base": 0xfffc6c6d, "background": 0xfffd8482},
  "water": {"base": 0xff76befe, "background": 0xff8ed0ff},
  "electric": {"base": 0xffffd76f, "background": 0xffffe580},
  "poison": {"base": 0xff6100ff, "background": 0xff8135fc},
  "ground": {"base": 0xff724d25, "background": 0xffad8151},
  "fairy": {"base": 0xfff2bfae, "background": 0xffffe3d9},
  "rock": {"base": 0x8a8f89, "background": 0xffa8a8a8},
  "ghost": {"base": 0xff1b1414, "background": 0xff634949},
  "default": {"base": 0xff0f0f0f, "background": 0xffdedcdc}
};

int getCustomColor(String type, String part) {
  if (type.isEmpty || part.isEmpty || colors[type] == null) return 0xffcccccc;

  return colors[type]![part] ?? 0xffcccccc;
}
