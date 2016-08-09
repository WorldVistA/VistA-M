IBDEI05Q ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5492,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5493,0)
 ;;=17274^^33^367^5^^^^1
 ;;^UTILITY(U,$J,358.3,5493,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5493,1,2,0)
 ;;=2^17274
 ;;^UTILITY(U,$J,358.3,5493,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5494,0)
 ;;=17276^^33^367^6^^^^1
 ;;^UTILITY(U,$J,358.3,5494,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5494,1,2,0)
 ;;=2^17276
 ;;^UTILITY(U,$J,358.3,5494,1,3,0)
 ;;=3^Dest Mal Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5495,0)
 ;;=17280^^33^368^1^^^^1
 ;;^UTILITY(U,$J,358.3,5495,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5495,1,2,0)
 ;;=2^17280
 ;;^UTILITY(U,$J,358.3,5495,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5496,0)
 ;;=17281^^33^368^2^^^^1
 ;;^UTILITY(U,$J,358.3,5496,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5496,1,2,0)
 ;;=2^17281
 ;;^UTILITY(U,$J,358.3,5496,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5497,0)
 ;;=17282^^33^368^3^^^^1
 ;;^UTILITY(U,$J,358.3,5497,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5497,1,2,0)
 ;;=2^17282
 ;;^UTILITY(U,$J,358.3,5497,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5498,0)
 ;;=17283^^33^368^4^^^^1
 ;;^UTILITY(U,$J,358.3,5498,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5498,1,2,0)
 ;;=2^17283
 ;;^UTILITY(U,$J,358.3,5498,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5499,0)
 ;;=17284^^33^368^5^^^^1
 ;;^UTILITY(U,$J,358.3,5499,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5499,1,2,0)
 ;;=2^17284
 ;;^UTILITY(U,$J,358.3,5499,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5500,0)
 ;;=17286^^33^368^6^^^^1
 ;;^UTILITY(U,$J,358.3,5500,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5500,1,2,0)
 ;;=2^17286
 ;;^UTILITY(U,$J,358.3,5500,1,3,0)
 ;;=3^Dest Mal Lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,5501,0)
 ;;=11420^^33^369^1^^^^1
 ;;^UTILITY(U,$J,358.3,5501,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5501,1,2,0)
 ;;=2^11420
 ;;^UTILITY(U,$J,358.3,5501,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5502,0)
 ;;=11421^^33^369^2^^^^1
 ;;^UTILITY(U,$J,358.3,5502,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5502,1,2,0)
 ;;=2^11421
 ;;^UTILITY(U,$J,358.3,5502,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5503,0)
 ;;=11422^^33^369^3^^^^1
 ;;^UTILITY(U,$J,358.3,5503,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5503,1,2,0)
 ;;=2^11422
 ;;^UTILITY(U,$J,358.3,5503,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5504,0)
 ;;=11423^^33^369^4^^^^1
 ;;^UTILITY(U,$J,358.3,5504,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5504,1,2,0)
 ;;=2^11423
 ;;^UTILITY(U,$J,358.3,5504,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5505,0)
 ;;=11424^^33^369^5^^^^1
 ;;^UTILITY(U,$J,358.3,5505,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5505,1,2,0)
 ;;=2^11424
 ;;^UTILITY(U,$J,358.3,5505,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5506,0)
 ;;=11426^^33^369^6^^^^1
 ;;^UTILITY(U,$J,358.3,5506,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5506,1,2,0)
 ;;=2^11426
 ;;^UTILITY(U,$J,358.3,5506,1,3,0)
 ;;=3^Exc Ben Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5507,0)
 ;;=11440^^33^370^1^^^^1
 ;;^UTILITY(U,$J,358.3,5507,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5507,1,2,0)
 ;;=2^11440
 ;;^UTILITY(U,$J,358.3,5507,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5508,0)
 ;;=11441^^33^370^2^^^^1
 ;;^UTILITY(U,$J,358.3,5508,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5508,1,2,0)
 ;;=2^11441
 ;;^UTILITY(U,$J,358.3,5508,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5509,0)
 ;;=11442^^33^370^3^^^^1
 ;;^UTILITY(U,$J,358.3,5509,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5509,1,2,0)
 ;;=2^11442
 ;;^UTILITY(U,$J,358.3,5509,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5510,0)
 ;;=11443^^33^370^4^^^^1
 ;;^UTILITY(U,$J,358.3,5510,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5510,1,2,0)
 ;;=2^11443
 ;;^UTILITY(U,$J,358.3,5510,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5511,0)
 ;;=11444^^33^370^5^^^^1
 ;;^UTILITY(U,$J,358.3,5511,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5511,1,2,0)
 ;;=2^11444
 ;;^UTILITY(U,$J,358.3,5511,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5512,0)
 ;;=11446^^33^370^6^^^^1
 ;;^UTILITY(U,$J,358.3,5512,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5512,1,2,0)
 ;;=2^11446
 ;;^UTILITY(U,$J,358.3,5512,1,3,0)
 ;;=3^Exc Ben Lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,5513,0)
 ;;=11620^^33^371^1^^^^1
 ;;^UTILITY(U,$J,358.3,5513,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5513,1,2,0)
 ;;=2^11620
 ;;^UTILITY(U,$J,358.3,5513,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5514,0)
 ;;=11621^^33^371^2^^^^1
 ;;^UTILITY(U,$J,358.3,5514,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5514,1,2,0)
 ;;=2^11621
 ;;^UTILITY(U,$J,358.3,5514,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5515,0)
 ;;=11622^^33^371^3^^^^1
 ;;^UTILITY(U,$J,358.3,5515,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5515,1,2,0)
 ;;=2^11622
 ;;^UTILITY(U,$J,358.3,5515,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5516,0)
 ;;=11623^^33^371^4^^^^1
 ;;^UTILITY(U,$J,358.3,5516,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5516,1,2,0)
 ;;=2^11623
 ;;^UTILITY(U,$J,358.3,5516,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5517,0)
 ;;=11624^^33^371^5^^^^1
 ;;^UTILITY(U,$J,358.3,5517,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5517,1,2,0)
 ;;=2^11624
 ;;^UTILITY(U,$J,358.3,5517,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5518,0)
 ;;=11626^^33^371^6^^^^1
 ;;^UTILITY(U,$J,358.3,5518,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5518,1,2,0)
 ;;=2^11626
 ;;^UTILITY(U,$J,358.3,5518,1,3,0)
 ;;=3^Exc Mal Lesion Sclp/NK/Ft/Hd/Gen > 4.0cm
 ;;^UTILITY(U,$J,358.3,5519,0)
 ;;=11640^^33^372^1^^^^1
 ;;^UTILITY(U,$J,358.3,5519,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5519,1,2,0)
 ;;=2^11640
 ;;^UTILITY(U,$J,358.3,5519,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,0.5cm or <
 ;;^UTILITY(U,$J,358.3,5520,0)
 ;;=11641^^33^372^2^^^^1
 ;;^UTILITY(U,$J,358.3,5520,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5520,1,2,0)
 ;;=2^11641
 ;;^UTILITY(U,$J,358.3,5520,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,0.6-1.0cm
 ;;^UTILITY(U,$J,358.3,5521,0)
 ;;=11642^^33^372^3^^^^1
 ;;^UTILITY(U,$J,358.3,5521,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5521,1,2,0)
 ;;=2^11642
 ;;^UTILITY(U,$J,358.3,5521,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,1.1-2.0cm
 ;;^UTILITY(U,$J,358.3,5522,0)
 ;;=11643^^33^372^4^^^^1
 ;;^UTILITY(U,$J,358.3,5522,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5522,1,2,0)
 ;;=2^11643
 ;;^UTILITY(U,$J,358.3,5522,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,2.1-3.0cm
 ;;^UTILITY(U,$J,358.3,5523,0)
 ;;=11644^^33^372^5^^^^1
 ;;^UTILITY(U,$J,358.3,5523,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5523,1,2,0)
 ;;=2^11644
 ;;^UTILITY(U,$J,358.3,5523,1,3,0)
 ;;=3^Exc Mal Lesion Face/Mucous,3.1-4.0cm
 ;;^UTILITY(U,$J,358.3,5524,0)
 ;;=11646^^33^372^6^^^^1
 ;;^UTILITY(U,$J,358.3,5524,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5524,1,2,0)
 ;;=2^11646
 ;;^UTILITY(U,$J,358.3,5524,1,3,0)
 ;;=3^Exc Mal lesion Face/Mucous > 4.0cm
 ;;^UTILITY(U,$J,358.3,5525,0)
 ;;=11305^^33^373^1^^^^1
 ;;^UTILITY(U,$J,358.3,5525,1,0)
 ;;=^358.31IA^3^2
