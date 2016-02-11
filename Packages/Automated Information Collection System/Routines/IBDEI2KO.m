IBDEI2KO ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,43143,1,3,0)
 ;;=3^Intcran inj w LOC w death d/t oth cause bf consc, init
 ;;^UTILITY(U,$J,358.3,43143,1,4,0)
 ;;=4^S06.898A
 ;;^UTILITY(U,$J,358.3,43143,2)
 ;;=^5021200
 ;;^UTILITY(U,$J,358.3,43144,0)
 ;;=S06.899A^^195^2167^38
 ;;^UTILITY(U,$J,358.3,43144,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43144,1,3,0)
 ;;=3^Intcran inj w LOC of unsp duration, init
 ;;^UTILITY(U,$J,358.3,43144,1,4,0)
 ;;=4^S06.899A
 ;;^UTILITY(U,$J,358.3,43144,2)
 ;;=^5021203
 ;;^UTILITY(U,$J,358.3,43145,0)
 ;;=S06.890D^^195^2167^42
 ;;^UTILITY(U,$J,358.3,43145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43145,1,3,0)
 ;;=3^Intcran inj w/o LOC, subs encntr
 ;;^UTILITY(U,$J,358.3,43145,1,4,0)
 ;;=4^S06.890D
 ;;^UTILITY(U,$J,358.3,43145,2)
 ;;=^5021177
 ;;^UTILITY(U,$J,358.3,43146,0)
 ;;=F32.9^^195^2168^3
 ;;^UTILITY(U,$J,358.3,43146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43146,1,3,0)
 ;;=3^Major depressive disorder, single episode, unspecified
 ;;^UTILITY(U,$J,358.3,43146,1,4,0)
 ;;=4^F32.9
 ;;^UTILITY(U,$J,358.3,43146,2)
 ;;=^5003528
 ;;^UTILITY(U,$J,358.3,43147,0)
 ;;=F43.21^^195^2168^1
 ;;^UTILITY(U,$J,358.3,43147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43147,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,43147,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,43147,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,43148,0)
 ;;=G47.00^^195^2168^2
 ;;^UTILITY(U,$J,358.3,43148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43148,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,43148,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,43148,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,43149,0)
 ;;=F43.12^^195^2168^5
 ;;^UTILITY(U,$J,358.3,43149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43149,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,43149,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,43149,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,43150,0)
 ;;=F43.11^^195^2168^4
 ;;^UTILITY(U,$J,358.3,43150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43150,1,3,0)
 ;;=3^Post-traumatic stress disorder, acute
 ;;^UTILITY(U,$J,358.3,43150,1,4,0)
 ;;=4^F43.11
 ;;^UTILITY(U,$J,358.3,43150,2)
 ;;=^5003571
 ;;^UTILITY(U,$J,358.3,43151,0)
 ;;=G25.0^^195^2169^8
 ;;^UTILITY(U,$J,358.3,43151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43151,1,3,0)
 ;;=3^Essential tremor
 ;;^UTILITY(U,$J,358.3,43151,1,4,0)
 ;;=4^G25.0
 ;;^UTILITY(U,$J,358.3,43151,2)
 ;;=^5003791
 ;;^UTILITY(U,$J,358.3,43152,0)
 ;;=G30.9^^195^2169^3
 ;;^UTILITY(U,$J,358.3,43152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43152,1,3,0)
 ;;=3^Alzheimer's disease, unspecified
 ;;^UTILITY(U,$J,358.3,43152,1,4,0)
 ;;=4^G30.9
 ;;^UTILITY(U,$J,358.3,43152,2)
 ;;=^5003808
 ;;^UTILITY(U,$J,358.3,43153,0)
 ;;=F03.90^^195^2169^7
 ;;^UTILITY(U,$J,358.3,43153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43153,1,3,0)
 ;;=3^Dementia without behavioral disturbance,Unspec
 ;;^UTILITY(U,$J,358.3,43153,1,4,0)
 ;;=4^F03.90
 ;;^UTILITY(U,$J,358.3,43153,2)
 ;;=^5003050
 ;;^UTILITY(U,$J,358.3,43154,0)
 ;;=M79.1^^195^2169^10
 ;;^UTILITY(U,$J,358.3,43154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43154,1,3,0)
 ;;=3^Myalgia
 ;;^UTILITY(U,$J,358.3,43154,1,4,0)
 ;;=4^M79.1
 ;;^UTILITY(U,$J,358.3,43154,2)
 ;;=^5013321
 ;;^UTILITY(U,$J,358.3,43155,0)
 ;;=G35.^^195^2169^9
 ;;^UTILITY(U,$J,358.3,43155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,43155,1,3,0)
 ;;=3^Multiple sclerosis
 ;;^UTILITY(U,$J,358.3,43155,1,4,0)
 ;;=4^G35.
 ;;^UTILITY(U,$J,358.3,43155,2)
 ;;=^79761
 ;;^UTILITY(U,$J,358.3,43156,0)
 ;;=H81.13^^195^2169^4
 ;;^UTILITY(U,$J,358.3,43156,1,0)
 ;;=^358.31IA^4^2
