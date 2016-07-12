#include <ruby.h>

static VALUE rb_mUnnatural;
static VALUE rb_mFast;

#define DIGIT_TO_I(C) (C - '0')
#define IS_DIGIT(C) ('0' <= C && C <= '9')
#define IS_LOWER(C) ('a' <= C && C <= 'z')
#define UPCASE(C)   (IS_LOWER(C) ? C - ('a' - 'A') : C)

VALUE compare(VALUE self, VALUE a_value, VALUE b_value) {
  int a_length = RSTRING_LEN(a_value);
  int b_length = RSTRING_LEN(b_value);
  char* a_str = RSTRING_PTR(a_value);
  char* b_str = RSTRING_PTR(b_value);
  int a_pos = 0;
  int b_pos = 0;
  int a_number = 0;
  int b_number = 0;
  char a, b;
  int diff = 0;

  for (a_pos = 0, b_pos = 0; a_pos < a_length && b_pos < b_length; a_pos++, b_pos++) {
    a = a_str[a_pos];
    b = b_str[b_pos];

    if ( IS_DIGIT(a) && !IS_DIGIT(b)) return INT2FIX(-1);
    if (!IS_DIGIT(a) &&  IS_DIGIT(b)) return INT2FIX(+1);

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
      if (diff != 0) return INT2FIX(diff);

      a_number = 0;
      b_number = 0;
      a_pos--;
      b_pos--;
    } else {
      diff = UPCASE(a) - UPCASE(b);
      if (diff != 0) return INT2FIX(diff);
    }
  }

  diff = a_length - b_length;
  if (diff != 0) return INT2FIX(diff);

  return INT2FIX(0);
}

void Init_fast_compare() {
  rb_mUnnatural = rb_define_module("Unnatural");
  rb_mFast = rb_define_module_under(rb_mUnnatural, "Fast");
  rb_define_singleton_method(rb_mFast, "compare", compare, 2);
}
