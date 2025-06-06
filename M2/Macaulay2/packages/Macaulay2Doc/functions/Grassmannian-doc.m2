-- -*- coding: utf-8 -*-
document {
    Key => {
	 Grassmannian,
	(Grassmannian, ZZ, ZZ), 
	  (Grassmannian, ZZ, ZZ, PolynomialRing),
	  [Grassmannian, CoefficientRing],
	  [Grassmannian, Variable]},
     Headline => "compute the ideal of the Grassmannian of linear subspaces of a vector space",
     Usage => "Grassmannian(k,r)\nGrassmannian(k,r,R)",
     Inputs => { 
	  "k", 
	  "r",
	  CoefficientRing => Ring => "the coefficient ring for the polynomial ring to be made",
	  Variable => Symbol => { "the base symbol for the indexed variables to be used.  The subscripts are the elements of ", TT "subsets(n+1,k+1)",
	       ", converted to sequences and, if ", TT "k", " is 0, converted to integers." }
	  },
     Outputs => {{ "the ideal of the Grassmannian variety of all projective ", TT "k", "-planes in ", BOLD "P", SUP "r"}},
     "If a polynomial ring ", TT "R", " is given as the third argument, then the resulting ideal is moved to that ring.",
     EXAMPLE lines ///
	 Grassmannian(1,3)
	 J = Grassmannian(2,5, CoefficientRing => ZZ/31, Variable => T) -* no-capture-flag *-
     ///,
     "The variables of the ring are based on the symbol provided, but assignments
     are not made until the ring or the ideal is assigned to a global variable or is submitted to ", TO "use", ", as follows.",
     EXAMPLE {
	  "T_(0,2,3)",
	  "use ring J",
	  "T_(0,2,3)"
	  },
     "In many ways, more natural than returning an ideal would be to return the corresponding quotient ring or
     variety, but creating a quotient ring involves computing a Gröbner basis, which
     might impose a heavy computational burden that the user would prefer to avoid.",
     SeeAlso => {"Schubert","pfaffians"}
     }

document { 
    Key => {
	 Schubert,
	(Schubert,ZZ,ZZ,VisibleList), 
	  [Schubert,CoefficientRing],
	  [Schubert,Variable]},
     Headline => "compute the Plücker ideal of a Schubert variety",
     Usage => "Schubert(k,n,sigma)",
     Inputs => { 
	  "k", 
	  "n", 
	  "sigma" => {"a subset of ", TT "0..n", " of size ", TT "k+1", " that indexes the Schubert variety"},
	  CoefficientRing => Ring => "the coefficient ring for the polynomial ring to be made",
	  Variable => Symbol => { "the base symbol for the indexed variables to be used.  The subscripts are the elements of ", TT "subsets(n+1,k+1)",
	       ", converted to sequences and, if ", TT "k", " is 0, converted to integers." }
	  },
     Outputs => {Ideal => "the ideal of the Schubert variety indexed by sigma" },
     TEX ///Given natural numbers $k \le{} n$, this routine finds the
     ideal of the Schubert variety indexed by sigma in the Grassmannian of projective 
     $k$-planes in $P^n$.///,
     PARA {
     	  TEX ///For example, the ideal of the Schubert variety indexed by $\{1,2,4\}$ in the
	  Grassmannian of projective planes in $P^4$ is displayed in the following example.///
     	  },
     EXAMPLE lines ///
	  I = Schubert(2,4,{1,2,4},CoefficientRing => QQ)
	  R = ring I;
	  C = res I
	  betti C
     ///,
     SeeAlso => {"Grassmannian","pfaffians"}
     }

document {
    Key => {
	Fano,
       (Fano, ZZ, Ideal),
       (Fano, ZZ, Ideal, Ring)},
    Headline => "compute the ideal of a Fano scheme in the Grassmannian",
    SYNOPSIS (
	Heading => "Fano scheme",
	Usage => "Fano(k,I)",
	Inputs => {
	    "k" => {"a positive integer less than ", TT "r"},
	    "I" => {"an ideal representing a variety in projective ", TT "r", "-space"},
	},
	Outputs => {"the ideal of a Fano scheme in the Grassmannian"},
	"Given an ideal ", TT "I", " representing a projective variety ", TT "X", "
	in ", TT "P^r", ", a positive integer k<r, and optionally a
	ring ", TT "GR", " with (exactly) ", TT "r+1", " choose ", TT "k+1", " variables,
	representing the ambient space of the Grassmannian of
	k-planes in ", TT "P^r", ", this routine returns the ideal in
	", TT "GR", " of the Fano scheme that parametrizes the k-planes
	lying on ", TT "X", ".  If the optional third argument is not
	present, the routine fabricates its own ring,
	and returns an ideal in it."
    ),
    SYNOPSIS (
	Usage => "Fano(k,I,GR)",
	Inputs => {
	    "k" => {"a positive integer less than ", TT "r"},
	    "I" => {"an ideal representing a variety in projective ", TT "r", "-space"},
	    "GR" => {}
	},
	Outputs => {"the ideal of a Fano scheme in the Grassmannian"},
	"Given an ideal ", TT "I", " representing a projective variety ", TT "X", "
	in ", TT "P^r", ", a positive integer k<r, and optionally a
	ring ", TT "GR", " with (exactly) ", TT "r+1", " choose ", TT "k+1", " variables,
	representing the ambient space of the Grassmannian of
	k-planes in ", TT "P^r", ", this routine returns the ideal in
	", TT "GR", " of the Fano scheme that parametrizes the k-planes
	lying on ", TT "X", ".  If the optional third argument is not
	present, the routine fabricates its own ring,
	and returns an ideal in it."
    ),
    SeeAlso => {
	Grassmannian,
	"Tutorial: Fano varieties"
    }
}
