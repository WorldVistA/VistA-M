IBDEI04B ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5198,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5199,0)
 ;;=17272^^23^327^3^^^^1
 ;;^UTILITY(U,$J,358.3,5199,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5199,1,2,0)
 ;;=2^17272
 ;;^UTILITY(U,$J,358.3,5199,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5200,0)
 ;;=17273^^23^327^4^^^^1
 ;;^UTILITY(U,$J,358.3,5200,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5200,1,2,0)
 ;;=2^17273
 ;;^UTILITY(U,$J,358.3,5200,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5201,0)
 ;;=17274^^23^327^5^^^^1
 ;;^UTILITY(U,$J,358.3,5201,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5201,1,2,0)
 ;;=2^17274
 ;;^UTILITY(U,$J,358.3,5201,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5202,0)
 ;;=17276^^23^327^6^^^^1
 ;;^UTILITY(U,$J,358.3,5202,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5202,1,2,0)
 ;;=2^17276
 ;;^UTILITY(U,$J,358.3,5202,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5203,0)
 ;;=17280^^23^328^1^^^^1
 ;;^UTILITY(U,$J,358.3,5203,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5203,1,2,0)
 ;;=2^17280
 ;;^UTILITY(U,$J,358.3,5203,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5204,0)
 ;;=17281^^23^328^2^^^^1
 ;;^UTILITY(U,$J,358.3,5204,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5204,1,2,0)
 ;;=2^17281
 ;;^UTILITY(U,$J,358.3,5204,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5205,0)
 ;;=17282^^23^328^3^^^^1
 ;;^UTILITY(U,$J,358.3,5205,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5205,1,2,0)
 ;;=2^17282
 ;;^UTILITY(U,$J,358.3,5205,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5206,0)
 ;;=17283^^23^328^4^^^^1
 ;;^UTILITY(U,$J,358.3,5206,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5206,1,2,0)
 ;;=2^17283
 ;;^UTILITY(U,$J,358.3,5206,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5207,0)
 ;;=17284^^23^328^5^^^^1
 ;;^UTILITY(U,$J,358.3,5207,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5207,1,2,0)
 ;;=2^17284
 ;;^UTILITY(U,$J,358.3,5207,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5208,0)
 ;;=17286^^23^328^6^^^^1
 ;;^UTILITY(U,$J,358.3,5208,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5208,1,2,0)
 ;;=2^17286
 ;;^UTILITY(U,$J,358.3,5208,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,5209,0)
 ;;=11420^^23^329^1^^^^1
 ;;^UTILITY(U,$J,358.3,5209,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5209,1,2,0)
 ;;=2^11420
 ;;^UTILITY(U,$J,358.3,5209,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5210,0)
 ;;=11421^^23^329^2^^^^1
 ;;^UTILITY(U,$J,358.3,5210,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5210,1,2,0)
 ;;=2^11421
 ;;^UTILITY(U,$J,358.3,5210,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5211,0)
 ;;=11422^^23^329^3^^^^1
 ;;^UTILITY(U,$J,358.3,5211,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5211,1,2,0)
 ;;=2^11422
 ;;^UTILITY(U,$J,358.3,5211,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5212,0)
 ;;=11423^^23^329^4^^^^1
 ;;^UTILITY(U,$J,358.3,5212,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5212,1,2,0)
 ;;=2^11423
 ;;^UTILITY(U,$J,358.3,5212,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5213,0)
 ;;=11424^^23^329^5^^^^1
 ;;^UTILITY(U,$J,358.3,5213,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5213,1,2,0)
 ;;=2^11424
 ;;^UTILITY(U,$J,358.3,5213,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5214,0)
 ;;=11426^^23^329^6^^^^1
 ;;^UTILITY(U,$J,358.3,5214,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5214,1,2,0)
 ;;=2^11426
 ;;^UTILITY(U,$J,358.3,5214,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5215,0)
 ;;=11440^^23^330^1^^^^1
 ;;^UTILITY(U,$J,358.3,5215,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5215,1,2,0)
 ;;=2^11440
 ;;^UTILITY(U,$J,358.3,5215,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5216,0)
 ;;=11441^^23^330^2^^^^1
 ;;^UTILITY(U,$J,358.3,5216,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5216,1,2,0)
 ;;=2^11441
 ;;^UTILITY(U,$J,358.3,5216,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5217,0)
 ;;=11442^^23^330^3^^^^1
 ;;^UTILITY(U,$J,358.3,5217,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5217,1,2,0)
 ;;=2^11442
 ;;^UTILITY(U,$J,358.3,5217,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5218,0)
 ;;=11443^^23^330^4^^^^1
 ;;^UTILITY(U,$J,358.3,5218,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5218,1,2,0)
 ;;=2^11443
 ;;^UTILITY(U,$J,358.3,5218,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5219,0)
 ;;=11444^^23^330^5^^^^1
 ;;^UTILITY(U,$J,358.3,5219,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5219,1,2,0)
 ;;=2^11444
 ;;^UTILITY(U,$J,358.3,5219,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5220,0)
 ;;=11446^^23^330^6^^^^1
 ;;^UTILITY(U,$J,358.3,5220,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5220,1,2,0)
 ;;=2^11446
 ;;^UTILITY(U,$J,358.3,5220,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,5221,0)
 ;;=11620^^23^331^1^^^^1
 ;;^UTILITY(U,$J,358.3,5221,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5221,1,2,0)
 ;;=2^11620
 ;;^UTILITY(U,$J,358.3,5221,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5222,0)
 ;;=11621^^23^331^2^^^^1
 ;;^UTILITY(U,$J,358.3,5222,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5222,1,2,0)
 ;;=2^11621
 ;;^UTILITY(U,$J,358.3,5222,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5223,0)
 ;;=11622^^23^331^3^^^^1
 ;;^UTILITY(U,$J,358.3,5223,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5223,1,2,0)
 ;;=2^11622
 ;;^UTILITY(U,$J,358.3,5223,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5224,0)
 ;;=11623^^23^331^4^^^^1
 ;;^UTILITY(U,$J,358.3,5224,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5224,1,2,0)
 ;;=2^11623
 ;;^UTILITY(U,$J,358.3,5224,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5225,0)
 ;;=11624^^23^331^5^^^^1
 ;;^UTILITY(U,$J,358.3,5225,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5225,1,2,0)
 ;;=2^11624
 ;;^UTILITY(U,$J,358.3,5225,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5226,0)
 ;;=11626^^23^331^6^^^^1
 ;;^UTILITY(U,$J,358.3,5226,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5226,1,2,0)
 ;;=2^11626
 ;;^UTILITY(U,$J,358.3,5226,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5227,0)
 ;;=11640^^23^332^1^^^^1
 ;;^UTILITY(U,$J,358.3,5227,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5227,1,2,0)
 ;;=2^11640
 ;;^UTILITY(U,$J,358.3,5227,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5228,0)
 ;;=11641^^23^332^2^^^^1
 ;;^UTILITY(U,$J,358.3,5228,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5228,1,2,0)
 ;;=2^11641
 ;;^UTILITY(U,$J,358.3,5228,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5229,0)
 ;;=11642^^23^332^3^^^^1
 ;;^UTILITY(U,$J,358.3,5229,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5229,1,2,0)
 ;;=2^11642
 ;;^UTILITY(U,$J,358.3,5229,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5230,0)
 ;;=11643^^23^332^4^^^^1
 ;;^UTILITY(U,$J,358.3,5230,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5230,1,2,0)
 ;;=2^11643
 ;;^UTILITY(U,$J,358.3,5230,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5231,0)
 ;;=11644^^23^332^5^^^^1
 ;;^UTILITY(U,$J,358.3,5231,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5231,1,2,0)
 ;;=2^11644
 ;;^UTILITY(U,$J,358.3,5231,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5232,0)
 ;;=11646^^23^332^6^^^^1
 ;;^UTILITY(U,$J,358.3,5232,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5232,1,2,0)
 ;;=2^11646
 ;;^UTILITY(U,$J,358.3,5232,1,3,0)
 ;;=3^Exc Mal lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,5233,0)
 ;;=11305^^23^333^1^^^^1
 ;;^UTILITY(U,$J,358.3,5233,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5233,1,2,0)
 ;;=2^11305
 ;;^UTILITY(U,$J,358.3,5233,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 0.5cm or less
 ;;^UTILITY(U,$J,358.3,5234,0)
 ;;=11306^^23^333^2^^^^1
 ;;^UTILITY(U,$J,358.3,5234,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5234,1,2,0)
 ;;=2^11306
 ;;^UTILITY(U,$J,358.3,5234,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5235,0)
 ;;=11307^^23^333^3^^^^1
 ;;^UTILITY(U,$J,358.3,5235,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5235,1,2,0)
 ;;=2^11307
 ;;^UTILITY(U,$J,358.3,5235,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5236,0)
 ;;=11308^^23^333^4^^^^1
 ;;^UTILITY(U,$J,358.3,5236,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5236,1,2,0)
 ;;=2^11308
 ;;^UTILITY(U,$J,358.3,5236,1,3,0)
 ;;=3^Shaving Epiderm Scalp/Nk/Trunk > 2.0cm
 ;;^UTILITY(U,$J,358.3,5237,0)
 ;;=11310^^23^334^1^^^^1
 ;;^UTILITY(U,$J,358.3,5237,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5237,1,2,0)
 ;;=2^11310
 ;;^UTILITY(U,$J,358.3,5237,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous:0.5cm or less
 ;;^UTILITY(U,$J,358.3,5238,0)
 ;;=11311^^23^334^2^^^^1
 ;;^UTILITY(U,$J,358.3,5238,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5238,1,2,0)
 ;;=2^11311
 ;;^UTILITY(U,$J,358.3,5238,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous: 0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5239,0)
 ;;=11312^^23^334^3^^^^1
 ;;^UTILITY(U,$J,358.3,5239,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5239,1,2,0)
 ;;=2^11312
 ;;^UTILITY(U,$J,358.3,5239,1,3,0)
 ;;=3^Shaving Epiderm Face/Mucous: 1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5240,0)
 ;;=11313^^23^334^4^^^^1
