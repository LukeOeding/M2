document {
     Key => inducedMap,
     Headline => "compute an induced map",
     Subnodes => {
	 TO (inducedMap, Module, Module),
	 TO (inducedMap, Module, Module, Matrix),
	 TO [inducedMap, Degree],
	 TO [inducedMap, Verify],
	 TO inducesWellDefinedMap,
     }
     }
document {
     Key => [inducedMap,Degree],
     Headline => "specify the degree of a map",
     TT "Degree => n", " -- an option to ", TO "inducedMap", " that provides the
     degree of the map produced."
     }
document {
     Key => [inducedMap,Verify],
     Headline => "verify that a map is well-defined",
     TT "Verify => true", " -- an option for ", TO "inducedMap", " which
     requests verification that the induced map produced is well defined."
     }
document {
     Key => {inducesWellDefinedMap,(inducesWellDefinedMap, Module, Module, Matrix),
	  (inducesWellDefinedMap, Module, Nothing, Matrix),(inducesWellDefinedMap, Nothing, Module, Matrix),
	  (inducesWellDefinedMap, Nothing, Nothing, Matrix)},
     Headline => "whether a map is well defined",
     TT "inducesWellDefinedMap(M,N,f)", " -- tells whether the matrix ", TT "f", " would
     induce a well defined map from ", TT "N", " to ", TT "M", ".",
     SeeAlso => "inducedMap"
     }

document {
     Key => {(inducedMap, Module, Module),(inducedMap, ChainComplex, ChainComplex)},
     Headline => "compute the map induced by the identity",
     Usage => "inducedMap(M,N)",
     Inputs => { "M", "N" },
     Outputs => {
	  {"the homomorphism ", TT "M <-- N", " induced by the identity."}
	  },
     "The modules ", TT "M", " and ", TT "N", " must both be ", TO "subquotient modules", " of
     the same ambient free module ", TT "F", ".
     If ", TT "M = M1/M2", " and ", TT "N = N1/N2", ", where ", TT "M1", ",
     ", TT "M2", ", ", TT "N1", ", ", TT "N2", " are all submodules of ", TT "F", ", then
     return the map induced by ", TT "F --> F", ". If the optional argument ", TT "Verify",
     " is given, check that the result defines a well defined homomorphism.",
     PARA{},
     "In this example, we make the inclusion map between two submodules of ", TT "R^3",
     ".  M is defined by two elements and N is generated by one element in M",
     EXAMPLE {
	  "R = ZZ/32003[x,y,z];",
          "P = R^3;",
	  "M = image(x*P_{1}+y*P_{2} | z*P_{0})",
	  "N = image(x^4*P_{1} + x^3*y*P_{2} + x*y*z*P_{0})",
	  "h = inducedMap(M,N)",
	  "source h == N",
	  "target h == M",
	  "ambient M == ambient N"
	  },
     SeeAlso => {inducesWellDefinedMap, subquotient}
     }
document {
     Key => {(inducedMap, Module, Module, Matrix),(inducedMap, Module, Nothing, Matrix),(inducedMap, Nothing, Module, Matrix),(inducedMap, Nothing, Nothing, Matrix)},
     Headline => "compute the induced map",
     Usage => "inducedMap(M,N,f)",
     Inputs => { "M", "N", "f" => {"a homomorphism ", TT "P <-- Q"}
	  },
     Outputs => {
	  {"the homomorphism ", TT "M <-- N", " induced by ", TT "f", "."}
	  },
     "The modules ", TT "M", " and ", TT "N", " must both be ", TO "subquotient modules", " where
     M and P have the same ambient module, and N and Q have the same ambient module.
     If the optional argument ", TT "Verify",
     " is given, check that the result defines a well defined homomorphism.",
     PARA{},
     "In this example, the module K2 is mapped via g into K1, and we construct the
     induced map from K2 to K1.",
     EXAMPLE {
	  "R = ZZ/32003[x,y,z]",
	  "g1 = matrix{{x,y,z}}",
	  "g2 = matrix{{x^2,y^2,z^2}}",
	  "K1 = ker g1",
	  "K2 = ker g2",
	  "f = map(ambient K1, ambient K2, {{x,0,0},{0,y,0},{0,0,z}})",
	  "h = inducedMap(K1,K2,f)"
	  },
     "If we omit the first argument, then it is understood to be the target of f, and
     if we omit the second argument, it is understood to be the source of f.",
     EXAMPLE {
	  "h1 = inducedMap(target f,K2,f)",
	  "h2 = inducedMap(,K2,f)",
	  "h1 == h2"
	  },
     "In this example, we cannot omit the second argument, since in that case the resulting
     object is not a homomorphism.",
     SeeAlso => {inducesWellDefinedMap, subquotient}
     }
