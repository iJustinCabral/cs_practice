package practice

import "core:fmt"
import "core:testing"


main :: proc() {
    
}

pair_sum_sorted :: proc(nums: []int, target: int) -> []int {
    left, right : int = 0, len(nums) - 1

    for left < right {
	sum := nums[left] + nums[right]

	if sum < target {
	    left += 1
	}
	else if sum > target {
	    right -= 1
	}
	else {
	    output : []int = {left, right}
	    return output
	}
    }

    return {}
}

@(test)
test_empty_array :: proc(^testing.T) {
    pair := pair_sum_sorted({}, 0)
    assert(len(pair) == 0)
}

@(test)
test_one_element_array :: proc(^testing.T) {
    pair := pair_sum_sorted({1}, 1)
    assert(len(pair) == 0)
}

@(test)
test_two_element_array :: proc(^testing.T) {
    pair := pair_sum_sorted({2, 3}, 5)
    assert(pair[0] == 0)
    assert(pair[1] == 1)
}

@(test)
test_no_pair :: proc(^testing.T) {
    pair := pair_sum_sorted({2, 2, 3}, 5)
    assert(pair[0] == 0)
    assert(pair[1] == 2)
}

@(test)
test_negative_numbers :: proc(^testing.T) {
    pair := pair_sum_sorted({-1, 2, 3}, 2)
    assert(pair[0] == 0)
    assert(pair[1] == 2)
}

@(test)
test_all_negative :: proc(^testing.T) {
    pair := pair_sum_sorted({-3, -2, -1}, -5)
    assert(pair[0] == 0)
    assert(pair[1] == 1)
}

