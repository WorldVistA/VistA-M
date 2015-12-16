IBDEI1T2 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,31828,1,4,0)
 ;;=4^S06.892A
 ;;^UTILITY(U,$J,358.3,31828,2)
 ;;=^5021182
 ;;^UTILITY(U,$J,358.3,31829,0)
 ;;=S06.894A^^181^1968^37
 ;;^UTILITY(U,$J,358.3,31829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31829,1,3,0)
 ;;=3^Intcran inj w LOC of 6 hours to 24 hours, init
 ;;^UTILITY(U,$J,358.3,31829,1,4,0)
 ;;=4^S06.894A
 ;;^UTILITY(U,$J,358.3,31829,2)
 ;;=^5021188
 ;;^UTILITY(U,$J,358.3,31830,0)
 ;;=S06.895A^^181^1968^33
 ;;^UTILITY(U,$J,358.3,31830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31830,1,3,0)
 ;;=3^Intcran inj w LOC >24 hr w ret consc lev, init
 ;;^UTILITY(U,$J,358.3,31830,1,4,0)
 ;;=4^S06.895A
 ;;^UTILITY(U,$J,358.3,31830,2)
 ;;=^5021191
 ;;^UTILITY(U,$J,358.3,31831,0)
 ;;=S06.896A^^181^1968^34
 ;;^UTILITY(U,$J,358.3,31831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31831,1,3,0)
 ;;=3^Intcran inj w LOC >24 hr w/o ret consc w surv, init
 ;;^UTILITY(U,$J,358.3,31831,1,4,0)
 ;;=4^S06.896A
 ;;^UTILITY(U,$J,358.3,31831,2)
 ;;=^5021194
 ;;^UTILITY(U,$J,358.3,31832,0)
 ;;=S06.897A^^181^1968^40
 ;;^UTILITY(U,$J,358.3,31832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31832,1,3,0)
 ;;=3^Intcran inj w LOC w death due to brain injury bf consc, init
 ;;^UTILITY(U,$J,358.3,31832,1,4,0)
 ;;=4^S06.897A
 ;;^UTILITY(U,$J,358.3,31832,2)
 ;;=^5021197
 ;;^UTILITY(U,$J,358.3,31833,0)
 ;;=S06.898A^^181^1968^39
 ;;^UTILITY(U,$J,358.3,31833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31833,1,3,0)
 ;;=3^Intcran inj w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,31833,1,4,0)
 ;;=4^S06.898A
 ;;^UTILITY(U,$J,358.3,31833,2)
 ;;=^5021200
 ;;^UTILITY(U,$J,358.3,31834,0)
 ;;=S06.899A^^181^1968^38
 ;;^UTILITY(U,$J,358.3,31834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31834,1,3,0)
 ;;=3^Intcran inj w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,31834,1,4,0)
 ;;=4^S06.899A
 ;;^UTILITY(U,$J,358.3,31834,2)
 ;;=^5021203
 ;;^UTILITY(U,$J,358.3,31835,0)
 ;;=S06.890D^^181^1968^42
 ;;^UTILITY(U,$J,358.3,31835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31835,1,3,0)
 ;;=3^Intcran inj w/o LOC, subs encntr
 ;;^UTILITY(U,$J,358.3,31835,1,4,0)
 ;;=4^S06.890D
 ;;^UTILITY(U,$J,358.3,31835,2)
 ;;=^5021177
 ;;^UTILITY(U,$J,358.3,31836,0)
 ;;=F32.9^^181^1969^3
 ;;^UTILITY(U,$J,358.3,31836,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31836,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,31836,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,31836,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,31837,0)
 ;;=F43.21^^181^1969^1
 ;;^UTILITY(U,$J,358.3,31837,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31837,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,31837,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,31837,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,31838,0)
 ;;=G47.00^^181^1969^2
 ;;^UTILITY(U,$J,358.3,31838,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31838,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,31838,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,31838,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,31839,0)
 ;;=F43.10^^181^1969^5
 ;;^UTILITY(U,$J,358.3,31839,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31839,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,31839,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,31839,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,31840,0)
 ;;=F43.12^^181^1969^4
 ;;^UTILITY(U,$J,358.3,31840,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,31840,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,31840,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,31840,2)
 ;;=^5003572
