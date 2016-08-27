#define DIGIT_TO_I(C) (C - '0')
#define IS_DIGIT(C) ('0' <= C && C <= '9')
#define IS_LOWER(C) ('a' <= C && C <= 'z')
#define UPCASE(C)   (IS_LOWER(C) ? C - ('a' - 'A') : C)

int compare(char* a_str, int a_length, char* b_str, int b_length) {
  int a_pos = 0;
  int b_pos = 0;
  int a_number = 0;
  int b_number = 0;
  char a, b;
  int diff = 0;

  for (a_pos = 0, b_pos = 0; a_pos < a_length && b_pos < b_length; a_pos++, b_pos++) {
    a = a_str[a_pos];
    b = b_str[b_pos];

    if ( IS_DIGIT(a) && !IS_DIGIT(b)) return -1;
    if (!IS_DIGIT(a) &&  IS_DIGIT(b)) return +1;

    if (IS_DIGIT(a) && IS_DIGIT(b)) {
      while (IS_DIGIT(a)) {
        a_number = a_number * 10 + DIGIT_TO_I(a);
        a_pos++;
        a = a_str[a_pos];
      }

      while (IS_DIGIT(b)) {
        b_number = b_number * 10 + DIGIT_TO_I(b);
        b_pos++;
        b = b_str[b_pos];
      }

      diff = a_number - b_number;
      if (diff != 0) return diff;

      a_number = 0;
      b_number = 0;
      a_pos--;
      b_pos--;
    } else {
      diff = UPCASE(a) - UPCASE(b);
      if (diff != 0) return diff;
    }
  }

  return a_length - b_length;
}
