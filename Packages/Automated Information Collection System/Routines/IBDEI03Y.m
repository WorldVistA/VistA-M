IBDEI03Y ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,1417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1417,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, accidental, init
 ;;^UTILITY(U,$J,358.3,1417,1,4,0)
 ;;=4^T36.91XA
 ;;^UTILITY(U,$J,358.3,1417,2)
 ;;=^5049418
 ;;^UTILITY(U,$J,358.3,1418,0)
 ;;=T36.91XD^^8^135^66
 ;;^UTILITY(U,$J,358.3,1418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1418,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, accidental, subs
 ;;^UTILITY(U,$J,358.3,1418,1,4,0)
 ;;=4^T36.91XD
 ;;^UTILITY(U,$J,358.3,1418,2)
 ;;=^5049419
 ;;^UTILITY(U,$J,358.3,1419,0)
 ;;=T36.91XS^^8^135^67
 ;;^UTILITY(U,$J,358.3,1419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1419,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, accidental, sequela
 ;;^UTILITY(U,$J,358.3,1419,1,4,0)
 ;;=4^T36.91XS
 ;;^UTILITY(U,$J,358.3,1419,2)
 ;;=^5049420
 ;;^UTILITY(U,$J,358.3,1420,0)
 ;;=T36.93XA^^8^135^68
 ;;^UTILITY(U,$J,358.3,1420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1420,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, assault, init encntr
 ;;^UTILITY(U,$J,358.3,1420,1,4,0)
 ;;=4^T36.93XA
 ;;^UTILITY(U,$J,358.3,1420,2)
 ;;=^5049424
 ;;^UTILITY(U,$J,358.3,1421,0)
 ;;=T36.93XD^^8^135^69
 ;;^UTILITY(U,$J,358.3,1421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1421,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, assault, subs encntr
 ;;^UTILITY(U,$J,358.3,1421,1,4,0)
 ;;=4^T36.93XD
 ;;^UTILITY(U,$J,358.3,1421,2)
 ;;=^5049425
 ;;^UTILITY(U,$J,358.3,1422,0)
 ;;=T36.93XS^^8^135^70
 ;;^UTILITY(U,$J,358.3,1422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1422,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, assault, sequela
 ;;^UTILITY(U,$J,358.3,1422,1,4,0)
 ;;=4^T36.93XS
 ;;^UTILITY(U,$J,358.3,1422,2)
 ;;=^5049426
 ;;^UTILITY(U,$J,358.3,1423,0)
 ;;=T36.92XA^^8^135^71
 ;;^UTILITY(U,$J,358.3,1423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1423,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, self-harm, init
 ;;^UTILITY(U,$J,358.3,1423,1,4,0)
 ;;=4^T36.92XA
 ;;^UTILITY(U,$J,358.3,1423,2)
 ;;=^5049421
 ;;^UTILITY(U,$J,358.3,1424,0)
 ;;=T36.92XD^^8^135^72
 ;;^UTILITY(U,$J,358.3,1424,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1424,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, self-harm, subs
 ;;^UTILITY(U,$J,358.3,1424,1,4,0)
 ;;=4^T36.92XD
 ;;^UTILITY(U,$J,358.3,1424,2)
 ;;=^5049422
 ;;^UTILITY(U,$J,358.3,1425,0)
 ;;=T36.92XS^^8^135^73
 ;;^UTILITY(U,$J,358.3,1425,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1425,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, self-harm, sequela
 ;;^UTILITY(U,$J,358.3,1425,1,4,0)
 ;;=4^T36.92XS
 ;;^UTILITY(U,$J,358.3,1425,2)
 ;;=^5049423
 ;;^UTILITY(U,$J,358.3,1426,0)
 ;;=T36.94XA^^8^135^74
 ;;^UTILITY(U,$J,358.3,1426,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1426,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, undetermined, init
 ;;^UTILITY(U,$J,358.3,1426,1,4,0)
 ;;=4^T36.94XA
 ;;^UTILITY(U,$J,358.3,1426,2)
 ;;=^5049427
 ;;^UTILITY(U,$J,358.3,1427,0)
 ;;=T36.94XD^^8^135^75
 ;;^UTILITY(U,$J,358.3,1427,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1427,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, undetermined, subs
 ;;^UTILITY(U,$J,358.3,1427,1,4,0)
 ;;=4^T36.94XD
 ;;^UTILITY(U,$J,358.3,1427,2)
 ;;=^5049428
 ;;^UTILITY(U,$J,358.3,1428,0)
 ;;=T36.94XS^^8^135^76
 ;;^UTILITY(U,$J,358.3,1428,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,1428,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, undetermined, sequela
 ;;^UTILITY(U,$J,358.3,1428,1,4,0)
 ;;=4^T36.94XS
 ;;^UTILITY(U,$J,358.3,1428,2)
 ;;=^5049429
 ;;^UTILITY(U,$J,358.3,1429,0)
 ;;=T36.5X6A^^8^135^77
