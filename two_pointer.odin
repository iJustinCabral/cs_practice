package practice

import "core:fmt"
import "core:slice"
import "core:testing"


main :: proc() {
    
}

// Two pointer version of summing two pairs
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

// Two pointer verison of summing multiple pairs
pair_sum_sorted_all_pairs :: proc(nums: []int, start: int, target: int) -> [][2]int {
    pairs := [dynamic][2]int{}
    left, right := start, len(nums) - 1

    for left < right {
	sum := nums[left] + nums[right]
	if sum == target {
	    append(&pairs, [2]int{nums[left], nums[right]})
	    left += 1

	    for left < right && nums[left] == nums[left - 1] {
		left += 1
	    }
	}
	else if sum < target {
	    left += 1
	}
	else {
	    right -= 1
	}
    }
    return pairs[:]    
}

// Two pointer implementation of triplet sum
triplet_sum :: proc(nums: []int, target: int) -> [][]int {
    triplets: [dynamic][]int = {}
    slice.sort(nums) 

    for i in 0..<len(nums) - 1 {
	if nums[i] > 0 do break
	if i > 0 && nums[i] == nums[i - 1] do continue

	pairs := pair_sum_sorted_all_pairs(nums, i + 1, -nums[i])
	for pair in pairs {
	    triplet := make([]int, 3)
	    triplet[0] = nums[i]
	    triplet[1] = pair[0]
	    triplet[2] = pair[1]
	    append(&triplets, triplet)
	}
    }
    return triplets[:] 
}

// Sum Two Pairs Test
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

// Sum Triplet Sum Test
@(test)
test_empty_array_trip:: proc(^testing.T) {
    triplets := triplet_sum({}, 0)
    assert(len(triplets) == 0)
}
