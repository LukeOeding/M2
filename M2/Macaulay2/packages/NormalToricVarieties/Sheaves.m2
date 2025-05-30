------------------------------------------------------------------------------
-- Total Coordinate Rings and Coherent Sheaves 
------------------------------------------------------------------------------
ring NormalToricVariety := PolynomialRing => (
    cacheValue symbol ring) (
    X -> (
    	if isDegenerate X then 
      	    error "-- not yet implemented for degenerate varieties";
    	if not isFreeModule classGroup X then 
	    printerr "Warning: computations over Cox rings with torsion grading groups are experimental";
    	-- constructing ring
    	K := X.cache.CoefficientRing;	  
    	x := X.cache.Variable;	  
    	n := #rays X;
	S := K (monoid [x_0..x_(n-1), Degrees => fromWDivToCl X]);
    	S.variety = X;
    	S 
	)
    );

normalToricVariety Ring := NormalToricVariety => opts -> S -> (
    if S.?variety and instance(S.variety, NormalToricVariety) then S.variety
    else error "no normal toric variety associated with ring")

ideal NormalToricVariety := Ideal => (
    cacheValue symbol ideal) (
    X -> (
    	S := ring X;
    	ideal apply (max X, L -> product (numgens S, 
		i -> if member (i,L) then 1_S else S_i) 
	    )
	)
    );
monomialIdeal NormalToricVariety := MonomialIdeal => X ->
    monomialIdeal ideal X

------------------------------------------------------------------------------
-- sheaves
------------------------------------------------------------------------------
sheaf (NormalToricVariety, Module) := CoherentSheaf => (X,M) -> (
    if M.cache#?(sheaf, X) then return M.cache#(sheaf, X);
    M.cache#(sheaf, X) = (
	if ring M =!= ring X then
	   error "-- expected the module and the variety to have the same ring";
	if not isHomogeneous M then
	   error "-- expected a homogeneous module";
	-- constructing coherent sheaf
	new CoherentSheaf from {
	    symbol module  => M,
	    symbol variety => X,
	    symbol cache   => new CacheTable
	    }
	));
sheaf (NormalToricVariety, Ring) := SheafOfRings => (X,R) -> (
    if ring X =!= R then 
	error "-- expected the ring of the variety";
    -- TODO: simplify when https://github.com/Macaulay2/M2/issues/3351 is fixed
    X.sheaf = X.sheaf ?? new SheafOfRings from {
      	symbol variety => X, 
      	symbol ring    => R
	}
    );
sheaf NormalToricVariety := SheafOfRings => X -> sheaf_X ring X

installMethod(symbol _, OO, NormalToricVariety, SheafOfRings => (OO,X) -> sheaf(X, ring X))

-- Add a new strategy as a hook
addHook((minimalPresentation, CoherentSheaf), Strategy => symbol NormalToricVarieties, (opts, F) ->
    if instance(X := variety F, NormalToricVariety) then (
    	M := module F;
    	S := ring M;
    	B := ideal X;
    	N := saturate(image map(M,S^0,0), B);
    	if N != 0 then M = M/N;
    	C := freeResolution M;
    	-- is there a better bound?
	a := max(1, max apply(length C + 1, i -> i + max flatten degrees C_i));
	return sheaf(X, minimalPresentation Hom(B^[a], M)) )
    )

cotangentSheaf NormalToricVariety := CoherentSheaf => opts -> (
    (cacheValue (symbol cotangentSheaf => opts)) (
	X -> (
      	    if isDegenerate X then 
		error "-- expected a non-degenerate toric variety";
      	    S := ring X;
      	    d := dim X;
      	    n := numgens S;
      	    nu := map (S^n, S^d, (matrix rays X) ** S);
      	    eta := map (directSum apply(n, i -> S^1 / ideal(S_i)), S^n, id_(S^n));
      	    om := sheaf (X, kernel (eta * nu));
	    if opts.MinimalGenerators
	    then minimalPresentation om else om
	    )
	)
    );

cotangentSheaf(ZZ,NormalToricVariety) := CoherentSheaf => opts -> (i,X) -> 
  exteriorPower (i, cotangentSheaf (X,opts)) 

cotangentSheaf(List, NormalToricVariety) := CoherentSheaf => opts -> (a, X) -> (
    assert(#a == #(Xs := components X));
    if X#?(cotangentSheaf, a)
    then X#(cotangentSheaf, a)
    else X#(cotangentSheaf, a) = tensor apply(#a, i -> pullback(X^[i], cotangentSheaf(a#i, Xs#i))))


-- THIS FUNCTION IS NOT EXPORTED.  Given a normal toric variety, this function
-- creates a HashTable describing the cohomology of all twists of the
-- structure sheaf.  For more information, see Proposition~3.2 in
-- Maclagan-Smith "Multigraded regularity"
setupHHOO = X -> (
    X.cache.emsBound = new MutableHashTable;
    -- create a fine graded version of the total coordinate ring
    S := ring X;
    n := numgens S;
    fineDeg := entries id_(ZZ^n);
    h := toList (n:1);
    R := QQ (monoid [gens S, Degrees => fineDeg, Heft => h]);
    RfromS := map (R, S, gens R);
    B := RfromS ideal X;
    -- use simplicial cohomology find the support sets 
    quasiCech := Hom (freeResolution(R^1/B), R^1);
    supSets := delete ({}, subsets (toList (0..n-1)));
    d := dim X;
    sigma := new MutableHashTable;
    sigma#0 = {{{},1}};
    for i from 1 to d do (
    	sHH := prune HH^(i+1)(quasiCech);
    	sigma#i = for s in supSets list (
      	    m := product (s, j ->  R_j);
      	    b := rank source basis (-degree m, sHH);
      	    if b > 0 then {s,b} else continue
	    )
	);
    -- create rings
    degS := degrees S; 
    X.cache.rawHHOO = new HashTable from apply(d+1, 
	i -> {i, apply(sigma#i, s -> (
	  	    v := - degree product(n, 
			j -> if member(j,s#0) then S_j else 1_S
			);
	  	    degT := apply(n, 
	    		j -> if member(j,s#0) then -degS#j else degS#j
			);
	  	    T := (ZZ/2)(monoid [gens S, Degrees => degT]);
	  	    {v,T,s#0,s#1}
		    )
		)
	    }
	)
    );

-- Defines the Frobenius power of an ideal
Ideal ^ Array := (I,p) -> ideal apply (I_*, i -> i^(p#0))

-- THIS FUNCTION IS NOT EXPORTED.  This function creates a HastTable which
-- stores the data for determining the appropriate Frobenius power needed to
-- compute the cohomology of a general coherent sheaf; see Proposition 4.1 in
-- Eisenbud-Mustata-Stillman.
emsbound = (i, X, deg) -> (
    if not X.cache.emsBound#?{i,deg} then (
    	if i < 0 or i > dim X then X.cache.emsBound#{i,deg} = 1
    	else X.cache.emsBound#{i,deg} = max ( {1} | 
	    apply (X.cache.rawHHOO#i, 
		t -> # t#2 + max apply(first entries basis(deg-t#0,t#1),
	  	    m -> max (first exponents m)_(t#2)
		    )
		)
	    )
	);
    X.cache.emsBound#{i,deg}
    );

cohomology (ZZ, NormalToricVariety, CoherentSheaf) := Module => opts -> (i,X,F) -> (
    if variety F =!= X then
    	error "-- expected a coherent sheaf on the toric variety";
    S := ring X;
    kk := coefficientRing S;
    if not isField kk then error "-- expected a toric variety over a field";
    if i < 0 or i > dim X then kk^0
    else (
    	if not X.cache.?rawHHOO then setupHHOO X;
    	M := module F;
	if M == 0 then kk^0 else
    	if isFreeModule M then kk^(
      	    sum apply (degrees M, deg -> sum apply(X.cache.rawHHOO#i,
	  	    t -> rank source basis (-deg-t#0,(t#1)^(t#3))
		    )
		)
	    )
    	else (
      	    B := ideal X;
      	    C := freeResolution M;
      	    deg := toList (degreeLength S : 0);
      	    bettiNum := flatten apply (1+length C, 
		j -> apply (unique degrees C_j, alpha -> {j,alpha}));
      	    b1 := max apply (bettiNum, 
		beta -> emsbound(i+beta#0-1,X,deg-beta#1)
		);
      	    b2 := max apply(bettiNum, 
		beta -> emsbound(i+beta#0,X,deg-beta#1)
		);	       
      	    b := max(b1,b2);
      	    if i > 0 then 
		kk^(rank source basis (deg, Ext^(i+1)(S^1/B^[b],M)))
      	    else (
		h1 := rank source basis (deg, Ext^(i+1)(S^1/B^[b],M));
		h0 := rank source basis (deg, Ext^i(S^1/B^[b1],M));
		kk^(rank source basis (deg,M) + h1 - h0)
		)
	    )
	)
    );

cohomology (ZZ, NormalToricVariety, SheafOfRings) := Module => opts -> 
    (i, X ,O) -> HH^i (X, O^1)

-- Add a new strategy as a hook
addHook((euler, CoherentSheaf), Strategy => symbol NormalToricVarieties, F ->
    if instance(X := variety F, NormalToricVariety) then
	return sum (1 + dim X, i -> (-1)^i * (rank HH^i(X,F)) )
    )
