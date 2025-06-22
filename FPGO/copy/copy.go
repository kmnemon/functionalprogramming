package copy

import "fmt"

type item struct {
	name  string
	price float32
}

// shallow copy with structural sharing
func shallowCopy() {
	//s1 = [item1, item2]
	s1 := make([]item, 0, 9)
	s1 = append(s1, item{"a", 1.1})
	s1 = append(s1, item{"b", 2.2})

	s2 := s1 //shallow copy, both s1 and s2 point to same array

	s1 = append(s1, item{"d", 4.4})
	// s1 = [{a 1.1} {b 2.2} { d 4.4}]
	// s2 = [{a 1.1} {b 2.2} { d 4.4}]

	s2 = append(s2, item{"c", 3.3}) // s1[2] is replaced
	// s1 = [{a 1.1} {b 2.2} { c 3.3}]
	// s2 = [{a 1.1} {b 2.2} { c 3.3}]
	s2[1].price = 9

	fmt.Println(s1) //[{a 1.1} {b 9} {c 3.3}]
	fmt.Println(s2) //[{a 1.1} {b 9} {c 3.3}]
}

func shallowCopyToDeepCopy() {
	s1 := make([]item, 0, 2)
	s1 = append(s1, item{"a", 1.1})
	s1 = append(s1, item{"b", 2.2})

	s2 := s1 //shallow copy

	s2 = append(s2, item{"c", 3.3}) //change the underlying array, deep copy
	s2[1].price = 9

	fmt.Println(s1) //[{a 1.1} {b 2.2}]
	fmt.Println(s2) //[{a 1.1} {b 9} {c 3.3}]
}
