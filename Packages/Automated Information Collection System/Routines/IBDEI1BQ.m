IBDEI1BQ ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21401,2)
 ;;=^5015556
 ;;^UTILITY(U,$J,358.3,21402,0)
 ;;=N06.1^^70^917^14
 ;;^UTILITY(U,$J,358.3,21402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21402,1,3,0)
 ;;=3^Isolated Proteinuria w/ Focal/Segmental Glomerular Lesions
 ;;^UTILITY(U,$J,358.3,21402,1,4,0)
 ;;=4^N06.1
 ;;^UTILITY(U,$J,358.3,21402,2)
 ;;=^5015550
 ;;^UTILITY(U,$J,358.3,21403,0)
 ;;=N06.0^^70^917^15
 ;;^UTILITY(U,$J,358.3,21403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21403,1,3,0)
 ;;=3^Isolated Proteinuria w/ Minor Glomerular Abnormality
 ;;^UTILITY(U,$J,358.3,21403,1,4,0)
 ;;=4^N06.0
 ;;^UTILITY(U,$J,358.3,21403,2)
 ;;=^5015549
 ;;^UTILITY(U,$J,358.3,21404,0)
 ;;=N06.8^^70^917^16
 ;;^UTILITY(U,$J,358.3,21404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21404,1,3,0)
 ;;=3^Isolated Proteinuria w/ Morphologic Lesion
 ;;^UTILITY(U,$J,358.3,21404,1,4,0)
 ;;=4^N06.8
 ;;^UTILITY(U,$J,358.3,21404,2)
 ;;=^5015557
 ;;^UTILITY(U,$J,358.3,21405,0)
 ;;=N14.3^^70^917^25
 ;;^UTILITY(U,$J,358.3,21405,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21405,1,3,0)
 ;;=3^Nephropathy Induced by Heavy Metals
 ;;^UTILITY(U,$J,358.3,21405,1,4,0)
 ;;=4^N14.3
 ;;^UTILITY(U,$J,358.3,21405,2)
 ;;=^5015593
 ;;^UTILITY(U,$J,358.3,21406,0)
 ;;=N14.1^^70^917^24
 ;;^UTILITY(U,$J,358.3,21406,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21406,1,3,0)
 ;;=3^Nephropathy Induced by Drug/Meds/Biol Subst
 ;;^UTILITY(U,$J,358.3,21406,1,4,0)
 ;;=4^N14.1
 ;;^UTILITY(U,$J,358.3,21406,2)
 ;;=^5015591
 ;;^UTILITY(U,$J,358.3,21407,0)
 ;;=N29.^^70^917^17
 ;;^UTILITY(U,$J,358.3,21407,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21407,1,3,0)
 ;;=3^Kidney and Ureter Disorders in Diseases Classd Elsewhr
 ;;^UTILITY(U,$J,358.3,21407,1,4,0)
 ;;=4^N29.
 ;;^UTILITY(U,$J,358.3,21407,2)
 ;;=^5015631
 ;;^UTILITY(U,$J,358.3,21408,0)
 ;;=N15.8^^70^917^26
 ;;^UTILITY(U,$J,358.3,21408,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21408,1,3,0)
 ;;=3^Renal Tubulo-Interstitial Diseases
 ;;^UTILITY(U,$J,358.3,21408,1,4,0)
 ;;=4^N15.8
 ;;^UTILITY(U,$J,358.3,21408,2)
 ;;=^5015595
 ;;^UTILITY(U,$J,358.3,21409,0)
 ;;=N14.4^^70^917^27
 ;;^UTILITY(U,$J,358.3,21409,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21409,1,3,0)
 ;;=3^Toxic Nephropathy NEC
 ;;^UTILITY(U,$J,358.3,21409,1,4,0)
 ;;=4^N14.4
 ;;^UTILITY(U,$J,358.3,21409,2)
 ;;=^5015594
 ;;^UTILITY(U,$J,358.3,21410,0)
 ;;=N05.6^^70^917^19
 ;;^UTILITY(U,$J,358.3,21410,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21410,1,3,0)
 ;;=3^Nephritic Syndrome w/ Dense Deposit Disease,Unspec
 ;;^UTILITY(U,$J,358.3,21410,1,4,0)
 ;;=4^N05.6
 ;;^UTILITY(U,$J,358.3,21410,2)
 ;;=^5015547
 ;;^UTILITY(U,$J,358.3,21411,0)
 ;;=N05.7^^70^917^20
 ;;^UTILITY(U,$J,358.3,21411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21411,1,3,0)
 ;;=3^Nephritic Syndrome w/ Diffuse Crescentic Glomerulonephritis,Unspec
 ;;^UTILITY(U,$J,358.3,21411,1,4,0)
 ;;=4^N05.7
 ;;^UTILITY(U,$J,358.3,21411,2)
 ;;=^5015548
 ;;^UTILITY(U,$J,358.3,21412,0)
 ;;=N05.1^^70^917^21
 ;;^UTILITY(U,$J,358.3,21412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21412,1,3,0)
 ;;=3^Nephritic Syndrome w/ Focal/Segmental Glomerular Lesions,Unspec
 ;;^UTILITY(U,$J,358.3,21412,1,4,0)
 ;;=4^N05.1
 ;;^UTILITY(U,$J,358.3,21412,2)
 ;;=^5015542
 ;;^UTILITY(U,$J,358.3,21413,0)
 ;;=N05.0^^70^917^22
 ;;^UTILITY(U,$J,358.3,21413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21413,1,3,0)
 ;;=3^Nephritic Syndrome w/ Minor Glomerular Abnormality,Unspec
