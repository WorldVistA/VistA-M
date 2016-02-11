IBDEI2RS ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,46499,2)
 ;;=^5015567
 ;;^UTILITY(U,$J,358.3,46500,0)
 ;;=N41.9^^206^2301^10
 ;;^UTILITY(U,$J,358.3,46500,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46500,1,3,0)
 ;;=3^Inflammatory Prostate Disease,Unspec
 ;;^UTILITY(U,$J,358.3,46500,1,4,0)
 ;;=4^N41.9
 ;;^UTILITY(U,$J,358.3,46500,2)
 ;;=^5015694
 ;;^UTILITY(U,$J,358.3,46501,0)
 ;;=N06.6^^206^2301^11
 ;;^UTILITY(U,$J,358.3,46501,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46501,1,3,0)
 ;;=3^Isolated Proteinuria w/ Dense Deposit Disease
 ;;^UTILITY(U,$J,358.3,46501,1,4,0)
 ;;=4^N06.6
 ;;^UTILITY(U,$J,358.3,46501,2)
 ;;=^5015555
 ;;^UTILITY(U,$J,358.3,46502,0)
 ;;=N06.7^^206^2301^12
 ;;^UTILITY(U,$J,358.3,46502,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46502,1,3,0)
 ;;=3^Isolated Proteinuria w/ Diffuse Crescentic Glomerulonephritis
 ;;^UTILITY(U,$J,358.3,46502,1,4,0)
 ;;=4^N06.7
 ;;^UTILITY(U,$J,358.3,46502,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,46503,0)
 ;;=N06.1^^206^2301^13
 ;;^UTILITY(U,$J,358.3,46503,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46503,1,3,0)
 ;;=3^Isolated Proteinuria w/ Focal/Segmental Glomerular Lesions
 ;;^UTILITY(U,$J,358.3,46503,1,4,0)
 ;;=4^N06.1
 ;;^UTILITY(U,$J,358.3,46503,2)
 ;;=^5015550
 ;;^UTILITY(U,$J,358.3,46504,0)
 ;;=N06.0^^206^2301^14
 ;;^UTILITY(U,$J,358.3,46504,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46504,1,3,0)
 ;;=3^Isolated Proteinuria w/ Minor Glomerular Abnormality
 ;;^UTILITY(U,$J,358.3,46504,1,4,0)
 ;;=4^N06.0
 ;;^UTILITY(U,$J,358.3,46504,2)
 ;;=^5015549
 ;;^UTILITY(U,$J,358.3,46505,0)
 ;;=N06.8^^206^2301^15
 ;;^UTILITY(U,$J,358.3,46505,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46505,1,3,0)
 ;;=3^Isolated Proteinuria w/ Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,46505,1,4,0)
 ;;=4^N06.8
 ;;^UTILITY(U,$J,358.3,46505,2)
 ;;=^5015557
 ;;^UTILITY(U,$J,358.3,46506,0)
 ;;=N14.3^^206^2301^24
 ;;^UTILITY(U,$J,358.3,46506,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46506,1,3,0)
 ;;=3^Nephropathy Induced by Heavy Metals
 ;;^UTILITY(U,$J,358.3,46506,1,4,0)
 ;;=4^N14.3
 ;;^UTILITY(U,$J,358.3,46506,2)
 ;;=^5015593
 ;;^UTILITY(U,$J,358.3,46507,0)
 ;;=N14.1^^206^2301^23
 ;;^UTILITY(U,$J,358.3,46507,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46507,1,3,0)
 ;;=3^Nephropathy Induced by Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,46507,1,4,0)
 ;;=4^N14.1
 ;;^UTILITY(U,$J,358.3,46507,2)
 ;;=^5015591
 ;;^UTILITY(U,$J,358.3,46508,0)
 ;;=N29.^^206^2301^16
 ;;^UTILITY(U,$J,358.3,46508,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46508,1,3,0)
 ;;=3^Kidney and Ureter Disorders in Diseases Classd Elsewhr
 ;;^UTILITY(U,$J,358.3,46508,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,46508,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,46509,0)
 ;;=N15.8^^206^2301^25
 ;;^UTILITY(U,$J,358.3,46509,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46509,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Diseases
 ;;^UTILITY(U,$J,358.3,46509,1,4,0)
 ;;=4^N15.8
 ;;^UTILITY(U,$J,358.3,46509,2)
 ;;=^5015595
 ;;^UTILITY(U,$J,358.3,46510,0)
 ;;=N14.4^^206^2301^26
 ;;^UTILITY(U,$J,358.3,46510,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46510,1,3,0)
 ;;=3^Toxic Nephropathy NEC
 ;;^UTILITY(U,$J,358.3,46510,1,4,0)
 ;;=4^N14.4
 ;;^UTILITY(U,$J,358.3,46510,2)
 ;;=^5015594
 ;;^UTILITY(U,$J,358.3,46511,0)
 ;;=N05.6^^206^2301^18
 ;;^UTILITY(U,$J,358.3,46511,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,46511,1,3,0)
 ;;=3^Nephritic Syndrome w/ Dense Deposit Disease,Unspec
 ;;^UTILITY(U,$J,358.3,46511,1,4,0)
 ;;=4^N05.6
 ;;^UTILITY(U,$J,358.3,46511,2)
 ;;=^5015547
 ;;^UTILITY(U,$J,358.3,46512,0)
 ;;=N05.7^^206^2301^19
 ;;^UTILITY(U,$J,358.3,46512,1,0)
 ;;=^358.31IA^4^2
