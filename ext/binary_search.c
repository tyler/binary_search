#include <ruby.h>

static ID id_cmp;

static VALUE rb_array_binary_index(VALUE self, VALUE value) {
  int lower = 0;
  int upper = RARRAY(self)->len - 1;
  int i, comp;

  while(lower <= upper) {
    i = lower + (upper - lower) / 2;
    comp = FIX2INT(rb_funcall(value, id_cmp, 1, RARRAY(self)->ptr[i]));

    if(comp == 0) {
      return LONG2NUM(i);
    } else if(comp == 1) {
      lower = i + 1;
    } else {
      upper = i - 1;
    };
  }
  return Qnil;
}

void Init_binary_search() {
  id_cmp = rb_intern("<=>");
  rb_define_method(rb_cArray, "binary_index", rb_array_binary_index, 1);
}
