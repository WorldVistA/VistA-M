IBDEI25I ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,36493,1,4,0)
 ;;=4^N06.0
 ;;^UTILITY(U,$J,358.3,36493,2)
 ;;=^5015549
 ;;^UTILITY(U,$J,358.3,36494,0)
 ;;=N06.8^^137^1764^15
 ;;^UTILITY(U,$J,358.3,36494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36494,1,3,0)
 ;;=3^Isolated Proteinuria w/ Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,36494,1,4,0)
 ;;=4^N06.8
 ;;^UTILITY(U,$J,358.3,36494,2)
 ;;=^5015557
 ;;^UTILITY(U,$J,358.3,36495,0)
 ;;=N14.3^^137^1764^24
 ;;^UTILITY(U,$J,358.3,36495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36495,1,3,0)
 ;;=3^Nephropathy Induced by Heavy Metals
 ;;^UTILITY(U,$J,358.3,36495,1,4,0)
 ;;=4^N14.3
 ;;^UTILITY(U,$J,358.3,36495,2)
 ;;=^5015593
 ;;^UTILITY(U,$J,358.3,36496,0)
 ;;=N14.1^^137^1764^23
 ;;^UTILITY(U,$J,358.3,36496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36496,1,3,0)
 ;;=3^Nephropathy Induced by Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,36496,1,4,0)
 ;;=4^N14.1
 ;;^UTILITY(U,$J,358.3,36496,2)
 ;;=^5015591
 ;;^UTILITY(U,$J,358.3,36497,0)
 ;;=N29.^^137^1764^16
 ;;^UTILITY(U,$J,358.3,36497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36497,1,3,0)
 ;;=3^Kidney and Ureter Disorders in Diseases Classd Elsewhr
 ;;^UTILITY(U,$J,358.3,36497,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,36497,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,36498,0)
 ;;=N15.8^^137^1764^25
 ;;^UTILITY(U,$J,358.3,36498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36498,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Diseases
 ;;^UTILITY(U,$J,358.3,36498,1,4,0)
 ;;=4^N15.8
 ;;^UTILITY(U,$J,358.3,36498,2)
 ;;=^5015595
 ;;^UTILITY(U,$J,358.3,36499,0)
 ;;=N14.4^^137^1764^26
 ;;^UTILITY(U,$J,358.3,36499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36499,1,3,0)
 ;;=3^Toxic Nephropathy NEC
 ;;^UTILITY(U,$J,358.3,36499,1,4,0)
 ;;=4^N14.4
 ;;^UTILITY(U,$J,358.3,36499,2)
 ;;=^5015594
 ;;^UTILITY(U,$J,358.3,36500,0)
 ;;=N05.6^^137^1764^18
 ;;^UTILITY(U,$J,358.3,36500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36500,1,3,0)
 ;;=3^Nephritic Syndrome w/ Dense Deposit Disease,Unspec
 ;;^UTILITY(U,$J,358.3,36500,1,4,0)
 ;;=4^N05.6
 ;;^UTILITY(U,$J,358.3,36500,2)
 ;;=^5015547
 ;;^UTILITY(U,$J,358.3,36501,0)
 ;;=N05.7^^137^1764^19
 ;;^UTILITY(U,$J,358.3,36501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36501,1,3,0)
 ;;=3^Nephritic Syndrome w/ Diffuse Crescentic Glomerulonephritis,Unspec
 ;;^UTILITY(U,$J,358.3,36501,1,4,0)
 ;;=4^N05.7
 ;;^UTILITY(U,$J,358.3,36501,2)
 ;;=^5015548
 ;;^UTILITY(U,$J,358.3,36502,0)
 ;;=N05.1^^137^1764^20
 ;;^UTILITY(U,$J,358.3,36502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36502,1,3,0)
 ;;=3^Nephritic Syndrome w/ Focal/Segmental Glomerular Lesions,Unspec
 ;;^UTILITY(U,$J,358.3,36502,1,4,0)
 ;;=4^N05.1
 ;;^UTILITY(U,$J,358.3,36502,2)
 ;;=^5015542
 ;;^UTILITY(U,$J,358.3,36503,0)
 ;;=N05.0^^137^1764^21
 ;;^UTILITY(U,$J,358.3,36503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36503,1,3,0)
 ;;=3^Nephritic Syndrome w/ Minor Glomerular Abnormality,Unspec
 ;;^UTILITY(U,$J,358.3,36503,1,4,0)
 ;;=4^N05.0
 ;;^UTILITY(U,$J,358.3,36503,2)
 ;;=^5015541
 ;;^UTILITY(U,$J,358.3,36504,0)
 ;;=N05.8^^137^1764^22
 ;;^UTILITY(U,$J,358.3,36504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36504,1,3,0)
 ;;=3^Nephritic Syndrome w/ Morphologic Changes,Unspec
 ;;^UTILITY(U,$J,358.3,36504,1,4,0)
 ;;=4^N05.8
 ;;^UTILITY(U,$J,358.3,36504,2)
 ;;=^5134085
 ;;^UTILITY(U,$J,358.3,36505,0)
 ;;=R59.9^^137^1765^4
 ;;^UTILITY(U,$J,358.3,36505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,36505,1,3,0)
 ;;=3^Enlarged Lymph Nodes,Unspec
 ;;^UTILITY(U,$J,358.3,36505,1,4,0)
 ;;=4^R59.9
 ;;^UTILITY(U,$J,358.3,36505,2)
 ;;=^5019531
 ;;^UTILITY(U,$J,358.3,36506,0)
 ;;=R59.1^^137^1765^2
