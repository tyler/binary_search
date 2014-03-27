#include <ruby.h>

#ifndef RARRAY_PTR
#define RARRAY_PTR(ary) RARRAY(ary)->ptr
#endif
#ifndef RARRAY_LEN
#define RARRAY_LEN(ary) RARRAY(ary)->len
#endif

static ID id_cmp;

static VALUE
binary_index(int *found, int argc, VALUE *argv, VALUE self)
{
    int lower = 0;
    int upper = RARRAY_LEN(self) - 1;
    int i, comp;
    VALUE target;

    int block_given = rb_block_given_p();

    if (block_given) {
        if (argc != 0)
            rb_raise(rb_eArgError, "No arguments allowed when a block is provided");
    } else {
        if (argc != 1)
            rb_raise(rb_eArgError, "Requires only one argument");
        rb_scan_args(argc, argv, "01", &target);
    }

    while (lower <= upper) {
        i = lower + (upper - lower) / 2;

        if (!block_given)
            comp = FIX2INT(rb_funcall(target, id_cmp, 1, RARRAY_PTR(self)[i]));
        else
            comp = FIX2INT(rb_yield(rb_ary_entry(self, i)));

        if (comp == 0) {
            *found = 1;
            return LONG2NUM(i);
        } else if (comp == 1) {
            lower = i + 1;
        } else {
            upper = i - 1;
        }
    }

    *found = 0;
    return LONG2NUM(upper);
}

/*
 * Search a sorted array for a value using a binary search algorithm.
 *
 * @method binary_index
 *
 * @overload binary_index(target)
 *   @param [Object] target the target value.
 *
 * @overload binary_index
 *   @yield [entity] The current entity which the target should be compared
 *     to.  This comparison should be done with something similar to
 *     target <=> entity.
 *
 * @raise [ArgumentError] if no block and no argument are provided.
 * @raise [ArgumentError] if both a block and an argument are provided.
 * @raise [ArgumentError] if too many arguments are provided.
 *
 * @return [Fixnum] the index for an element matching the target value.
 * @return [nil] if the target is not found.
 *
 * @example Find the value '10' in an array
 *   index = [5, 10, 15, 20].binary_index(10)
 *   #=> 1
 *
 * @example Fail to find the value 12 in an array
 *   index = [5, 10, 15, 20].binary_index(12)
 *   #=> nil
 */
static VALUE
rb_array_binary_index(int argc, VALUE *argv, VALUE self)
{
    int found;
    VALUE ret;

    ret = binary_index(&found, argc, argv, self);
    if (!found)
        return Qnil;
    return ret;
}

/*
 * Search a sorted array for a value, or the value immediately smaller than
 * the target value, using a binary search algorithm.
 *
 * @note
 *   This method will not work properly if the array values are not unique.
 *
 * @overload binary_index_approximate(target)
 *   @param [Object] target the target value.
 *
 * @overload binary_index_approximate
 *   @yield [entity] The current entity which the target should be compared
 *     to.  This comparison should be done with something similar to
 *     target <=> entity.
 *
 * @raise [ArgumentError] if no block and no argument are provided.
 * @raise [ArgumentError] if both a block and an argument are provided.
 * @raise [ArgumentError] if too many arguments are provided.
 *
 * @return [Fixnum] the index for an element matching the target value,
 *    or the value found which is smaller than the target value.
 * @return [-1] if the target is smaller than the first element in the array.
 *
 * @example Find the value '10' in an array
 *   index = [5, 10, 15, 20].binary_index(10)
 *   #=> 1
 *
 * @example Fail to find the value 12 in an array
 *   index = [5, 10, 15, 20].binary_index(12)
 *   #=> 1
 */
static VALUE
rb_array_binary_index_approximate(int argc, VALUE *argv, VALUE self)
{
    int found;
    VALUE ret;

    ret = binary_index(&found, argc, argv, self);
    return ret;
}

/*
 * Search a sorted array for a value, and return the object at the found
 * location.  The required block is expected to compare the target with
 * the block argument using the equalavent of the <=> operator.
 *
 * @method binary_search
 *
 * @overload binary_search
 *   @yield [entity] The current entity which the target should be compared
 *     to.  This comparison should be done with something similar to
 *     target <=> entity.
 *
 * @raise [ArgumentError] if no block and no argument are provided.
 * @raise [ArgumentError] if both a block and an argument are provided.
 * @raise [ArgumentError] if too many arguments are provided.
 *
 * @return [Object] the value in the array which matches the search
 *   condition.
 * @return [nil] if no object matches.
 *
 * @example
 *   element = [[1, :a], [2, :b]].binary_search { |x| 2 <=> x[0] }
 *   #=> [2, :b]
 */
static VALUE
rb_array_binary_search(int argc, VALUE *argv, VALUE self)
{
    VALUE ret;
    int found;

    ret = binary_index(&found, argc, argv, self);
    if (!found)
        return Qnil;
    return rb_ary_entry(self, NUM2LONG(ret));
}

void
Init_binary_search_ext()
{
  id_cmp = rb_intern("<=>");
  rb_define_method(rb_cArray, "binary_index", rb_array_binary_index, -1);
  rb_define_method(rb_cArray, "binary_index_approximate", rb_array_binary_index_approximate, -1);
  rb_define_method(rb_cArray, "binary_search", rb_array_binary_search, -1);
}
