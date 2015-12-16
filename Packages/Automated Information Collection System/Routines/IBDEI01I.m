IBDEI01I ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,151,1,4,0)
 ;;=4^T45.1X5S
 ;;^UTILITY(U,$J,358.3,151,2)
 ;;=^5051028
 ;;^UTILITY(U,$J,358.3,152,0)
 ;;=T36.8X5A^^1^10^7
 ;;^UTILITY(U,$J,358.3,152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,152,1,3,0)
 ;;=3^Adverse effect of other systemic antibiotics, init encntr
 ;;^UTILITY(U,$J,358.3,152,1,4,0)
 ;;=4^T36.8X5A
 ;;^UTILITY(U,$J,358.3,152,2)
 ;;=^5049412
 ;;^UTILITY(U,$J,358.3,153,0)
 ;;=T36.8X5D^^1^10^8
 ;;^UTILITY(U,$J,358.3,153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,153,1,3,0)
 ;;=3^Adverse effect of other systemic antibiotics, subs encntr
 ;;^UTILITY(U,$J,358.3,153,1,4,0)
 ;;=4^T36.8X5D
 ;;^UTILITY(U,$J,358.3,153,2)
 ;;=^5049413
 ;;^UTILITY(U,$J,358.3,154,0)
 ;;=T36.8X5S^^1^10^9
 ;;^UTILITY(U,$J,358.3,154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,154,1,3,0)
 ;;=3^Adverse effect of other systemic antibiotics, sequela
 ;;^UTILITY(U,$J,358.3,154,1,4,0)
 ;;=4^T36.8X5S
 ;;^UTILITY(U,$J,358.3,154,2)
 ;;=^5049414
 ;;^UTILITY(U,$J,358.3,155,0)
 ;;=T49.6X5A^^1^10^10
 ;;^UTILITY(U,$J,358.3,155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,155,1,3,0)
 ;;=3^Adverse effect of otorhino drugs and preparations, init
 ;;^UTILITY(U,$J,358.3,155,1,4,0)
 ;;=4^T49.6X5A
 ;;^UTILITY(U,$J,358.3,155,2)
 ;;=^5051926
 ;;^UTILITY(U,$J,358.3,156,0)
 ;;=T49.6X5D^^1^10^11
 ;;^UTILITY(U,$J,358.3,156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,156,1,3,0)
 ;;=3^Adverse effect of otorhino drugs and preparations, subs
 ;;^UTILITY(U,$J,358.3,156,1,4,0)
 ;;=4^T49.6X5D
 ;;^UTILITY(U,$J,358.3,156,2)
 ;;=^5051927
 ;;^UTILITY(U,$J,358.3,157,0)
 ;;=T49.6X5S^^1^10^12
 ;;^UTILITY(U,$J,358.3,157,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,157,1,3,0)
 ;;=3^Adverse effect of otorhino drugs and preparations, sequela
 ;;^UTILITY(U,$J,358.3,157,1,4,0)
 ;;=4^T49.6X5S
 ;;^UTILITY(U,$J,358.3,157,2)
 ;;=^5051928
 ;;^UTILITY(U,$J,358.3,158,0)
 ;;=T36.95XA^^1^10^13
 ;;^UTILITY(U,$J,358.3,158,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,158,1,3,0)
 ;;=3^Adverse effect of unsp systemic antibiotic, init encntr
 ;;^UTILITY(U,$J,358.3,158,1,4,0)
 ;;=4^T36.95XA
 ;;^UTILITY(U,$J,358.3,158,2)
 ;;=^5049430
 ;;^UTILITY(U,$J,358.3,159,0)
 ;;=T36.95XD^^1^10^14
 ;;^UTILITY(U,$J,358.3,159,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,159,1,3,0)
 ;;=3^Adverse effect of unsp systemic antibiotic, subs encntr
 ;;^UTILITY(U,$J,358.3,159,1,4,0)
 ;;=4^T36.95XD
 ;;^UTILITY(U,$J,358.3,159,2)
 ;;=^5049431
 ;;^UTILITY(U,$J,358.3,160,0)
 ;;=T36.95XS^^1^10^15
 ;;^UTILITY(U,$J,358.3,160,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,160,1,3,0)
 ;;=3^Adverse effect of unspecified systemic antibiotic, sequela
 ;;^UTILITY(U,$J,358.3,160,1,4,0)
 ;;=4^T36.95XS
 ;;^UTILITY(U,$J,358.3,160,2)
 ;;=^5049432
 ;;^UTILITY(U,$J,358.3,161,0)
 ;;=S04.60XA^^1^10^16
 ;;^UTILITY(U,$J,358.3,161,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,161,1,3,0)
 ;;=3^Injury of acoustic nerve, unspecified side, init encntr
 ;;^UTILITY(U,$J,358.3,161,1,4,0)
 ;;=4^S04.60XA
 ;;^UTILITY(U,$J,358.3,161,2)
 ;;=^5020537
 ;;^UTILITY(U,$J,358.3,162,0)
 ;;=S04.9XXA^^1^10^17
 ;;^UTILITY(U,$J,358.3,162,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,162,1,3,0)
 ;;=3^Injury of unspecified cranial nerve, initial encounter
 ;;^UTILITY(U,$J,358.3,162,1,4,0)
 ;;=4^S04.9XXA
 ;;^UTILITY(U,$J,358.3,162,2)
 ;;=^5020573
 ;;^UTILITY(U,$J,358.3,163,0)
 ;;=R49.8^^1^10^92
 ;;^UTILITY(U,$J,358.3,163,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,163,1,3,0)
 ;;=3^Voice and Resonance Disorders NEC
 ;;^UTILITY(U,$J,358.3,163,1,4,0)
 ;;=4^R49.8
 ;;^UTILITY(U,$J,358.3,163,2)
 ;;=^5019505
 ;;^UTILITY(U,$J,358.3,164,0)
 ;;=T36.5X1A^^1^10^19
