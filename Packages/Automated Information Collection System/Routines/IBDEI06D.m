IBDEI06D ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6209,2)
 ;;=^5015589
 ;;^UTILITY(U,$J,358.3,6210,0)
 ;;=N13.1^^39^445^11
 ;;^UTILITY(U,$J,358.3,6210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6210,1,3,0)
 ;;=3^Hydronephrosis w/ Ureteral Stricture NEC
 ;;^UTILITY(U,$J,358.3,6210,1,4,0)
 ;;=4^N13.1
 ;;^UTILITY(U,$J,358.3,6210,2)
 ;;=^5015576
 ;;^UTILITY(U,$J,358.3,6211,0)
 ;;=N13.2^^39^445^10
 ;;^UTILITY(U,$J,358.3,6211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6211,1,3,0)
 ;;=3^Hydronephrosis w/ Renal and Ureteral Calculous Obstruction
 ;;^UTILITY(U,$J,358.3,6211,1,4,0)
 ;;=4^N13.2
 ;;^UTILITY(U,$J,358.3,6211,2)
 ;;=^5015577
 ;;^UTILITY(U,$J,358.3,6212,0)
 ;;=N13.30^^39^445^13
 ;;^UTILITY(U,$J,358.3,6212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6212,1,3,0)
 ;;=3^Hydronephrosis,Unspec
 ;;^UTILITY(U,$J,358.3,6212,1,4,0)
 ;;=4^N13.30
 ;;^UTILITY(U,$J,358.3,6212,2)
 ;;=^5015578
 ;;^UTILITY(U,$J,358.3,6213,0)
 ;;=N13.39^^39^445^12
 ;;^UTILITY(U,$J,358.3,6213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6213,1,3,0)
 ;;=3^Hydronephrosis,Other
 ;;^UTILITY(U,$J,358.3,6213,1,4,0)
 ;;=4^N13.39
 ;;^UTILITY(U,$J,358.3,6213,2)
 ;;=^5015579
 ;;^UTILITY(U,$J,358.3,6214,0)
 ;;=R33.9^^39^445^16
 ;;^UTILITY(U,$J,358.3,6214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6214,1,3,0)
 ;;=3^Urinary Retention,Unspec
 ;;^UTILITY(U,$J,358.3,6214,1,4,0)
 ;;=4^R33.9
 ;;^UTILITY(U,$J,358.3,6214,2)
 ;;=^5019332
 ;;^UTILITY(U,$J,358.3,6215,0)
 ;;=I75.81^^39^445^8
 ;;^UTILITY(U,$J,358.3,6215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6215,1,3,0)
 ;;=3^Atheroembolism of Kidney
 ;;^UTILITY(U,$J,358.3,6215,1,4,0)
 ;;=4^I75.81
 ;;^UTILITY(U,$J,358.3,6215,2)
 ;;=^328516
 ;;^UTILITY(U,$J,358.3,6216,0)
 ;;=R34.^^39^445^7
 ;;^UTILITY(U,$J,358.3,6216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6216,1,3,0)
 ;;=3^Anuria and Oliguria
 ;;^UTILITY(U,$J,358.3,6216,1,4,0)
 ;;=4^R34.
 ;;^UTILITY(U,$J,358.3,6216,2)
 ;;=^5019333
 ;;^UTILITY(U,$J,358.3,6217,0)
 ;;=K76.7^^39^445^9
 ;;^UTILITY(U,$J,358.3,6217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6217,1,3,0)
 ;;=3^Hepatorenal Syndrome
 ;;^UTILITY(U,$J,358.3,6217,1,4,0)
 ;;=4^K76.7
 ;;^UTILITY(U,$J,358.3,6217,2)
 ;;=^56497
 ;;^UTILITY(U,$J,358.3,6218,0)
 ;;=N00.0^^39^446^8
 ;;^UTILITY(U,$J,358.3,6218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6218,1,3,0)
 ;;=3^Acute nephritic syndrome w/ minor glomerular abnormality
 ;;^UTILITY(U,$J,358.3,6218,1,4,0)
 ;;=4^N00.0
 ;;^UTILITY(U,$J,358.3,6218,2)
 ;;=^5015491
 ;;^UTILITY(U,$J,358.3,6219,0)
 ;;=N00.1^^39^446^7
 ;;^UTILITY(U,$J,358.3,6219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6219,1,3,0)
 ;;=3^Acute nephritic syndrome w/ focal and segmental glomerular lesions
 ;;^UTILITY(U,$J,358.3,6219,1,4,0)
 ;;=4^N00.1
 ;;^UTILITY(U,$J,358.3,6219,2)
 ;;=^5015492
 ;;^UTILITY(U,$J,358.3,6220,0)
 ;;=N00.2^^39^446^4
 ;;^UTILITY(U,$J,358.3,6220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6220,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,6220,1,4,0)
 ;;=4^N00.2
 ;;^UTILITY(U,$J,358.3,6220,2)
 ;;=^5015493
 ;;^UTILITY(U,$J,358.3,6221,0)
 ;;=N00.3^^39^446^5
 ;;^UTILITY(U,$J,358.3,6221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6221,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,6221,1,4,0)
 ;;=4^N00.3
 ;;^UTILITY(U,$J,358.3,6221,2)
 ;;=^5015494
 ;;^UTILITY(U,$J,358.3,6222,0)
 ;;=N00.4^^39^446^3
 ;;^UTILITY(U,$J,358.3,6222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6222,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,6222,1,4,0)
 ;;=4^N00.4
 ;;^UTILITY(U,$J,358.3,6222,2)
 ;;=^5015495
 ;;^UTILITY(U,$J,358.3,6223,0)
 ;;=N00.5^^39^446^6
 ;;^UTILITY(U,$J,358.3,6223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6223,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,6223,1,4,0)
 ;;=4^N00.5
 ;;^UTILITY(U,$J,358.3,6223,2)
 ;;=^5015496
 ;;^UTILITY(U,$J,358.3,6224,0)
 ;;=N00.6^^39^446^1
 ;;^UTILITY(U,$J,358.3,6224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6224,1,3,0)
 ;;=3^Acute nephritic syndrome w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,6224,1,4,0)
 ;;=4^N00.6
 ;;^UTILITY(U,$J,358.3,6224,2)
 ;;=^5015497
 ;;^UTILITY(U,$J,358.3,6225,0)
 ;;=N00.7^^39^446^2
 ;;^UTILITY(U,$J,358.3,6225,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6225,1,3,0)
 ;;=3^Acute nephritic syndrome w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,6225,1,4,0)
 ;;=4^N00.7
 ;;^UTILITY(U,$J,358.3,6225,2)
 ;;=^5015498
 ;;^UTILITY(U,$J,358.3,6226,0)
 ;;=N00.8^^39^446^9
 ;;^UTILITY(U,$J,358.3,6226,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6226,1,3,0)
 ;;=3^Acute nephritic syndrome w/ other morphologic changes
 ;;^UTILITY(U,$J,358.3,6226,1,4,0)
 ;;=4^N00.8
 ;;^UTILITY(U,$J,358.3,6226,2)
 ;;=^5015499
 ;;^UTILITY(U,$J,358.3,6227,0)
 ;;=N00.9^^39^446^10
 ;;^UTILITY(U,$J,358.3,6227,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6227,1,3,0)
 ;;=3^Acute nephritic syndrome w/ unsp morphologic changes
 ;;^UTILITY(U,$J,358.3,6227,1,4,0)
 ;;=4^N00.9
 ;;^UTILITY(U,$J,358.3,6227,2)
 ;;=^5015500
 ;;^UTILITY(U,$J,358.3,6228,0)
 ;;=N01.0^^39^446^70
 ;;^UTILITY(U,$J,358.3,6228,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6228,1,3,0)
 ;;=3^Rapidly progr neph synd w/ minor glomerular abnlt
 ;;^UTILITY(U,$J,358.3,6228,1,4,0)
 ;;=4^N01.0
 ;;^UTILITY(U,$J,358.3,6228,2)
 ;;=^5015501
 ;;^UTILITY(U,$J,358.3,6229,0)
 ;;=N01.1^^39^446^69
 ;;^UTILITY(U,$J,358.3,6229,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6229,1,3,0)
 ;;=3^Rapidly progr neph synd w/ focal & seg glomerular lesions
 ;;^UTILITY(U,$J,358.3,6229,1,4,0)
 ;;=4^N01.1
 ;;^UTILITY(U,$J,358.3,6229,2)
 ;;=^5015502
 ;;^UTILITY(U,$J,358.3,6230,0)
 ;;=N01.2^^39^446^67
 ;;^UTILITY(U,$J,358.3,6230,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6230,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffuse membranous glomrlneph
 ;;^UTILITY(U,$J,358.3,6230,1,4,0)
 ;;=4^N01.2
 ;;^UTILITY(U,$J,358.3,6230,2)
 ;;=^5015503
 ;;^UTILITY(U,$J,358.3,6231,0)
 ;;=N01.3^^39^446^65
 ;;^UTILITY(U,$J,358.3,6231,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6231,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffus mesangial prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,6231,1,4,0)
 ;;=4^N01.3
 ;;^UTILITY(U,$J,358.3,6231,2)
 ;;=^5015504
 ;;^UTILITY(U,$J,358.3,6232,0)
 ;;=N01.4^^39^446^64
 ;;^UTILITY(U,$J,358.3,6232,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6232,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffus endocaplry prolif glomrlneph
 ;;^UTILITY(U,$J,358.3,6232,1,4,0)
 ;;=4^N01.4
 ;;^UTILITY(U,$J,358.3,6232,2)
 ;;=^5015505
 ;;^UTILITY(U,$J,358.3,6233,0)
 ;;=N01.5^^39^446^68
 ;;^UTILITY(U,$J,358.3,6233,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6233,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffuse mesangiocap glomrlneph
 ;;^UTILITY(U,$J,358.3,6233,1,4,0)
 ;;=4^N01.5
 ;;^UTILITY(U,$J,358.3,6233,2)
 ;;=^5015506
 ;;^UTILITY(U,$J,358.3,6234,0)
 ;;=N01.6^^39^446^63
 ;;^UTILITY(U,$J,358.3,6234,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6234,1,3,0)
 ;;=3^Rapidly progr neph synd w/ dense deposit disease
 ;;^UTILITY(U,$J,358.3,6234,1,4,0)
 ;;=4^N01.6
 ;;^UTILITY(U,$J,358.3,6234,2)
 ;;=^5015507
 ;;^UTILITY(U,$J,358.3,6235,0)
 ;;=N01.7^^39^446^66
 ;;^UTILITY(U,$J,358.3,6235,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6235,1,3,0)
 ;;=3^Rapidly progr neph synd w/ diffuse crescentic glomrlneph
 ;;^UTILITY(U,$J,358.3,6235,1,4,0)
 ;;=4^N01.7
 ;;^UTILITY(U,$J,358.3,6235,2)
 ;;=^5015508
 ;;^UTILITY(U,$J,358.3,6236,0)
 ;;=N01.8^^39^446^71
 ;;^UTILITY(U,$J,358.3,6236,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6236,1,3,0)
 ;;=3^Rapidly progr neph synd w/ oth morphologic changes
 ;;^UTILITY(U,$J,358.3,6236,1,4,0)
 ;;=4^N01.8
 ;;^UTILITY(U,$J,358.3,6236,2)
 ;;=^5015509
 ;;^UTILITY(U,$J,358.3,6237,0)
 ;;=N01.9^^39^446^72
