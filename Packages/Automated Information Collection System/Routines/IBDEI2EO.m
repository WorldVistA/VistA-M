IBDEI2EO ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38392,1,4,0)
 ;;=4^S06.899A
 ;;^UTILITY(U,$J,358.3,38392,2)
 ;;=^5021203
 ;;^UTILITY(U,$J,358.3,38393,0)
 ;;=S06.890D^^149^1948^30
 ;;^UTILITY(U,$J,358.3,38393,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38393,1,3,0)
 ;;=3^Intcran inj w/o LOC, subs encntr
 ;;^UTILITY(U,$J,358.3,38393,1,4,0)
 ;;=4^S06.890D
 ;;^UTILITY(U,$J,358.3,38393,2)
 ;;=^5021177
 ;;^UTILITY(U,$J,358.3,38394,0)
 ;;=S06.0X9A^^149^1948^4
 ;;^UTILITY(U,$J,358.3,38394,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38394,1,3,0)
 ;;=3^Concussion w LOC of unspec duration, init
 ;;^UTILITY(U,$J,358.3,38394,1,4,0)
 ;;=4^S06.0X9A
 ;;^UTILITY(U,$J,358.3,38394,2)
 ;;=^5020693
 ;;^UTILITY(U,$J,358.3,38395,0)
 ;;=S06.0X9D^^149^1948^6
 ;;^UTILITY(U,$J,358.3,38395,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38395,1,3,0)
 ;;=3^Concussion w LOC of unspec duration, subs
 ;;^UTILITY(U,$J,358.3,38395,1,4,0)
 ;;=4^S06.0X9D
 ;;^UTILITY(U,$J,358.3,38395,2)
 ;;=^5020694
 ;;^UTILITY(U,$J,358.3,38396,0)
 ;;=S06.0X9S^^149^1948^5
 ;;^UTILITY(U,$J,358.3,38396,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38396,1,3,0)
 ;;=3^Concussion w LOC of unspec duration, sequela
 ;;^UTILITY(U,$J,358.3,38396,1,4,0)
 ;;=4^S06.0X9S
 ;;^UTILITY(U,$J,358.3,38396,2)
 ;;=^5020695
 ;;^UTILITY(U,$J,358.3,38397,0)
 ;;=F32.9^^149^1949^3
 ;;^UTILITY(U,$J,358.3,38397,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38397,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,38397,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,38397,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,38398,0)
 ;;=F43.21^^149^1949^1
 ;;^UTILITY(U,$J,358.3,38398,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38398,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,38398,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,38398,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,38399,0)
 ;;=G47.00^^149^1949^2
 ;;^UTILITY(U,$J,358.3,38399,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38399,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,38399,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,38399,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,38400,0)
 ;;=F43.12^^149^1949^5
 ;;^UTILITY(U,$J,358.3,38400,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38400,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,38400,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,38400,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,38401,0)
 ;;=F43.11^^149^1949^4
 ;;^UTILITY(U,$J,358.3,38401,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38401,1,3,0)
 ;;=3^Post-traumatic stress disorder, acute
 ;;^UTILITY(U,$J,358.3,38401,1,4,0)
 ;;=4^F43.11
 ;;^UTILITY(U,$J,358.3,38401,2)
 ;;=^5003571
 ;;^UTILITY(U,$J,358.3,38402,0)
 ;;=G25.0^^149^1950^8
 ;;^UTILITY(U,$J,358.3,38402,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38402,1,3,0)
 ;;=3^Essential tremor
 ;;^UTILITY(U,$J,358.3,38402,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,38402,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,38403,0)
 ;;=G30.9^^149^1950^3
 ;;^UTILITY(U,$J,358.3,38403,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38403,1,3,0)
 ;;=3^Alzheimer's disease, unspecified
 ;;^UTILITY(U,$J,358.3,38403,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,38403,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,38404,0)
 ;;=F03.90^^149^1950^7
 ;;^UTILITY(U,$J,358.3,38404,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38404,1,3,0)
 ;;=3^Dementia without behavioral disturbance,Unspec
