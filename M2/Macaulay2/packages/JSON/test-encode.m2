-- numbers
assert Equation(toJSON 1, "1")
assert Equation(toJSON 3.14159, "3.14159")
assert Equation(toJSON pi, "3.141592653589793")
assert Equation(toJSON(1/2), ".5")

-- strings
assert Equation(toJSON "Hello, world!", "\"Hello, world!\"")
assert Equation(toJSON "¡pʃɹoʍ 'oʃʃǝH", "\"¡pʃɹoʍ 'oʃʃǝH\"")

-- true/false/null
assert Equation(toJSON true, "true")
assert Equation(toJSON false, "false")
assert Equation(toJSON null, "null")
assert Equation(toJSON nil, "null")

-- arrays
assert Equation(toJSON {1, 2, 3}, "[1, 2, 3]")
assert Equation(toJSON [1, 2, 3], "[1, 2, 3]")
assert Equation(toJSON <|1, 2, 3|>, "[1, 2, 3]")
assert Equation(toJSON({1, 2, 3}, ValueSeparator => " , "), "[1 , 2 , 3]")
assert Equation(toJSON({1, 2, 3, {4, 5}}, Indent => 0), ///[
1,
2,
3,
[
4,
5
]
]///)
assert Equation(toJSON({1, 2, 3, {4, 5}}, Indent => 2), ///[
  1,
  2,
  3,
  [
    4,
    5
  ]
]///)
assert Equation(toJSON({1, 2, 3, {4, 5}}, Indent => "  "), ///[
  1,
  2,
  3,
  [
    4,
    5
  ]
]///)

assert Equation(toJSON({}, Indent => 2), "[]")
assert Equation(toJSON({{}}, Indent => 2), ///[
  []
]///)

-- objects
assert Equation(toJSON(hashTable{"a" => 1, "b" => 2, "c" => 3}, Sort => true),
    "{\"a\": 1, \"b\": 2, \"c\": 3}")
assert Equation(toJSON(hashTable{"a" => 1, "b" => 2, "c" => 3}, Sort => true,
	ValueSeparator => " , "), "{\"a\": 1 , \"b\": 2 , \"c\": 3}")
assert Equation(toJSON(hashTable{"a" => 1, "b" => 2, "c" => 3}, Sort => true,
	NameSeparator => " : "), "{\"a\" : 1, \"b\" : 2, \"c\" : 3}")

-- Dispatch => Thing
assert Equation(toJSON(1, 2), "[1, 2]")

-- converting other types to strings
assert Equation(toJSON foo, "\"foo\"")
assert Equation(toJSON ZZ, "\"ZZ\"")
assert Equation(toJSON Core, "\"Core\"")

-- hypertext
assert Equation(toJSON HREF("foo.html", "foo"),
    ///"<a href=\"foo.html\">foo</a>"///)

-- control characters
x = ascii(0..31) | "\\\""
assert Equation(fromJSON toJSON x, x)
