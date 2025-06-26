package copy

import "fmt"

type Item struct {
	name  string
	price float32
}

// shallow copy with structural sharing
func shallowCopy() {
	s1 := make([]Item, 0, 9)
	s1 = append(s1, Item{"a", 1.1})
	s1 = append(s1, Item{"b", 2.2})

	s2 := s1 //shallow copy, both s1 and s2 point to same array

	s1 = append(s1, Item{"d", 4.4})
	// s1 = [{a 1.1} {b 2.2} { d 4.4}]
	// s2 = [{a 1.1} {b 2.2} { d 4.4}]

	s2 = append(s2, Item{"c", 3.3}) // s1[2] is replaced
	// s1 = [{a 1.1} {b 2.2} { c 3.3}]
	// s2 = [{a 1.1} {b 2.2} { c 3.3}]
	s2[1].price = 9

	fmt.Println(s1) //[{a 1.1} {b 9} {c 3.3}]
	fmt.Println(s2) //[{a 1.1} {b 9} {c 3.3}]
}

func shallowCopyToDeepCopy() {
	s1 := make([]Item, 0, 2)
	s1 = append(s1, Item{"a", 1.1})
	s1 = append(s1, Item{"b", 2.2})

	s2 := s1 //shallow copy

	s2 = append(s2, Item{"c", 3.3}) //change the underlying array, deep copy
	s2[1].price = 9

	fmt.Println(s1) //[{a 1.1} {b 2.2}]
	fmt.Println(s2) //[{a 1.1} {b 9} {c 3.3}]
}

func notSupportShallowCopyAndStructuralSharing() {
	s1 := make([]Item, 0, 9)
	s1 = append(s1, Item{"a", 1.1})
	s1 = append(s1, Item{"b", 2.2})
	s1 = append(s1, Item{"c", 3.3})

	s2 := s1 //shallow copy, both s1 and s2 point to same array

	for i, v := range s2 {
		if v.name == "b" {
			s2[i] = setPrice(v, 9.9)
		}
	}

	fmt.Println(s1) //[{a 1.1} {b 9.9} {c 3.3}]
	fmt.Println(s2) //[{a 1.1} {b 9.9} {c 3.3}]

}

func setPrice(item Item, price float32) Item {
	newItem := item
	newItem.price = price
	return newItem
}
