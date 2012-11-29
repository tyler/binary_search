#include <ruby.h>

#ifndef RARRAY_PTR
#define RARRAY_PTR(ary) RARRAY(ary)->ptr
#endif
#ifndef RARRAY_LEN
#define RARRAY_LEN(ary) RARRAY(ary)->len
#endif

static ID id_cmp;

static VALUE rb_array_binary_index(VALUE self, VALUE value) {
  int lower = 0;
  int upper = RARRAY_LEN(self) - 1;
  int i, comp;

  while(lower <= upper) {
    i = lower + (upper - lower) / 2;
    comp = FIX2INT(rb_funcall(value, id_cmp, 1, RARRAY_PTR(self)[i]));

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

void Init_binary_search_ext() {
  id_cmp = rb_intern("<=>");
  rb_define_method(rb_cArray, "binary_index", rb_array_binary_index, 1);
}
