IBDEI07Q ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3312,1,4,0)
 ;;=4^Z87.01
 ;;^UTILITY(U,$J,358.3,3312,2)
 ;;=^5063480
 ;;^UTILITY(U,$J,358.3,3313,0)
 ;;=Z86.11^^18^217^29
 ;;^UTILITY(U,$J,358.3,3313,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3313,1,3,0)
 ;;=3^Personal Hx of Tuberculosis
 ;;^UTILITY(U,$J,358.3,3313,1,4,0)
 ;;=4^Z86.11
 ;;^UTILITY(U,$J,358.3,3313,2)
 ;;=^5063461
 ;;^UTILITY(U,$J,358.3,3314,0)
 ;;=Z86.13^^18^217^28
 ;;^UTILITY(U,$J,358.3,3314,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3314,1,3,0)
 ;;=3^Personal Hx of Malaria
 ;;^UTILITY(U,$J,358.3,3314,1,4,0)
 ;;=4^Z86.13
 ;;^UTILITY(U,$J,358.3,3314,2)
 ;;=^5063463
 ;;^UTILITY(U,$J,358.3,3315,0)
 ;;=Z86.14^^18^217^27
 ;;^UTILITY(U,$J,358.3,3315,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3315,1,3,0)
 ;;=3^Personal Hx of MRSA
 ;;^UTILITY(U,$J,358.3,3315,1,4,0)
 ;;=4^Z86.14
 ;;^UTILITY(U,$J,358.3,3315,2)
 ;;=^5063464
 ;;^UTILITY(U,$J,358.3,3316,0)
 ;;=B94.9^^18^217^30
 ;;^UTILITY(U,$J,358.3,3316,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3316,1,3,0)
 ;;=3^Sequelae of Infectious/Parasitic Disease,Unspec
 ;;^UTILITY(U,$J,358.3,3316,1,4,0)
 ;;=4^B94.9
 ;;^UTILITY(U,$J,358.3,3316,2)
 ;;=^5000834
 ;;^UTILITY(U,$J,358.3,3317,0)
 ;;=B91.^^18^217^31
 ;;^UTILITY(U,$J,358.3,3317,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3317,1,3,0)
 ;;=3^Sequelae of Poliomyelitis
 ;;^UTILITY(U,$J,358.3,3317,1,4,0)
 ;;=4^B91.
 ;;^UTILITY(U,$J,358.3,3317,2)
 ;;=^5000828
 ;;^UTILITY(U,$J,358.3,3318,0)
 ;;=B90.9^^18^217^32
 ;;^UTILITY(U,$J,358.3,3318,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3318,1,3,0)
 ;;=3^Sequelae of Tuberculosis,Respiratory & Unspec
 ;;^UTILITY(U,$J,358.3,3318,1,4,0)
 ;;=4^B90.9
 ;;^UTILITY(U,$J,358.3,3318,2)
 ;;=^5000827
 ;;^UTILITY(U,$J,358.3,3319,0)
 ;;=Z90.5^^18^218^1
 ;;^UTILITY(U,$J,358.3,3319,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3319,1,3,0)
 ;;=3^Acquired Absence of Kidney
 ;;^UTILITY(U,$J,358.3,3319,1,4,0)
 ;;=4^Z90.5
 ;;^UTILITY(U,$J,358.3,3319,2)
 ;;=^5063590
 ;;^UTILITY(U,$J,358.3,3320,0)
 ;;=N20.2^^18^218^2
 ;;^UTILITY(U,$J,358.3,3320,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3320,1,3,0)
 ;;=3^Calculus of Kidney w/ Calculus of Ureter
 ;;^UTILITY(U,$J,358.3,3320,1,4,0)
 ;;=4^N20.2
 ;;^UTILITY(U,$J,358.3,3320,2)
 ;;=^5015609
 ;;^UTILITY(U,$J,358.3,3321,0)
 ;;=N21.9^^18^218^3
 ;;^UTILITY(U,$J,358.3,3321,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3321,1,3,0)
 ;;=3^Calculus of Lower Urinary Tract,Unspec
 ;;^UTILITY(U,$J,358.3,3321,1,4,0)
 ;;=4^N21.9
 ;;^UTILITY(U,$J,358.3,3321,2)
 ;;=^5015613
 ;;^UTILITY(U,$J,358.3,3322,0)
 ;;=N20.9^^18^218^4
 ;;^UTILITY(U,$J,358.3,3322,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3322,1,3,0)
 ;;=3^Calculus,Urinary,Unspec
 ;;^UTILITY(U,$J,358.3,3322,1,4,0)
 ;;=4^N20.9
 ;;^UTILITY(U,$J,358.3,3322,2)
 ;;=^5015610
 ;;^UTILITY(U,$J,358.3,3323,0)
 ;;=N28.9^^18^218^6
 ;;^UTILITY(U,$J,358.3,3323,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3323,1,3,0)
 ;;=3^Kidney & Ureter Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,3323,1,4,0)
 ;;=4^N28.9
 ;;^UTILITY(U,$J,358.3,3323,2)
 ;;=^5015630
 ;;^UTILITY(U,$J,358.3,3324,0)
 ;;=I12.9^^18^218^7
 ;;^UTILITY(U,$J,358.3,3324,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3324,1,3,0)
 ;;=3^Kidney Disease,Chr,Hypertensive w/ Stage 1-4 or UNSPEC
 ;;^UTILITY(U,$J,358.3,3324,1,4,0)
 ;;=4^I12.9
 ;;^UTILITY(U,$J,358.3,3324,2)
 ;;=^5007066
 ;;^UTILITY(U,$J,358.3,3325,0)
 ;;=N18.1^^18^218^8
 ;;^UTILITY(U,$J,358.3,3325,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,3325,1,3,0)
 ;;=3^Kidney Disease,Chr,Stage 1
 ;;^UTILITY(U,$J,358.3,3325,1,4,0)
 ;;=4^N18.1
 ;;^UTILITY(U,$J,358.3,3325,2)
 ;;=^5015602
