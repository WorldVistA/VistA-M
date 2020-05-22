IBDEI2SV ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,44660,1,3,0)
 ;;=3^Subseq Psych Collab Care Mgmt,1st 60 min
 ;;^UTILITY(U,$J,358.3,44661,0)
 ;;=99494^^166^2222^3^^^^1
 ;;^UTILITY(U,$J,358.3,44661,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,44661,1,2,0)
 ;;=2^99494
 ;;^UTILITY(U,$J,358.3,44661,1,3,0)
 ;;=3^Init/Subseq Psych Collab Care Mgmt,Ea Addl 30 min
 ;;^UTILITY(U,$J,358.3,44662,0)
 ;;=97129^^166^2223^1^^^^1
 ;;^UTILITY(U,$J,358.3,44662,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,44662,1,2,0)
 ;;=2^97129
 ;;^UTILITY(U,$J,358.3,44662,1,3,0)
 ;;=3^Therapeutic Intrvn,Cog Func,1st 15 min
 ;;^UTILITY(U,$J,358.3,44663,0)
 ;;=97130^^166^2223^2^^^^1
 ;;^UTILITY(U,$J,358.3,44663,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,44663,1,2,0)
 ;;=2^97130
 ;;^UTILITY(U,$J,358.3,44663,1,3,0)
 ;;=3^Therapeutic Intrvn,Cog Func,Ea Addl 15 min
 ;;^UTILITY(U,$J,358.3,44664,0)
 ;;=Z87.81^^167^2224^2
 ;;^UTILITY(U,$J,358.3,44664,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44664,1,3,0)
 ;;=3^Personal history of (healed) traumatic fracture
 ;;^UTILITY(U,$J,358.3,44664,1,4,0)
 ;;=4^Z87.81
 ;;^UTILITY(U,$J,358.3,44664,2)
 ;;=^5063513
 ;;^UTILITY(U,$J,358.3,44665,0)
 ;;=Z87.828^^167^2224^3
 ;;^UTILITY(U,$J,358.3,44665,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44665,1,3,0)
 ;;=3^Personal history of oth (healed) physical injury and trauma
 ;;^UTILITY(U,$J,358.3,44665,1,4,0)
 ;;=4^Z87.828
 ;;^UTILITY(U,$J,358.3,44665,2)
 ;;=^5063516
 ;;^UTILITY(U,$J,358.3,44666,0)
 ;;=S06.9X9S^^167^2224^1
 ;;^UTILITY(U,$J,358.3,44666,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44666,1,3,0)
 ;;=3^Intracranial injury w LOC of unsp duration unspec, sequela
 ;;^UTILITY(U,$J,358.3,44666,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,44666,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,44667,0)
 ;;=F43.21^^167^2225^3
 ;;^UTILITY(U,$J,358.3,44667,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44667,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,44667,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,44667,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,44668,0)
 ;;=G47.00^^167^2225^8
 ;;^UTILITY(U,$J,358.3,44668,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44668,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,44668,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,44668,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,44669,0)
 ;;=F43.10^^167^2225^11
 ;;^UTILITY(U,$J,358.3,44669,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44669,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,44669,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,44669,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,44670,0)
 ;;=F43.12^^167^2225^10
 ;;^UTILITY(U,$J,358.3,44670,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44670,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,44670,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,44670,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,44671,0)
 ;;=F43.11^^167^2225^9
 ;;^UTILITY(U,$J,358.3,44671,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44671,1,3,0)
 ;;=3^Post-traumatic stress disorder, acute
 ;;^UTILITY(U,$J,358.3,44671,1,4,0)
 ;;=4^F43.11
 ;;^UTILITY(U,$J,358.3,44671,2)
 ;;=^5003571
 ;;^UTILITY(U,$J,358.3,44672,0)
 ;;=F43.22^^167^2225^2
 ;;^UTILITY(U,$J,358.3,44672,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,44672,1,3,0)
 ;;=3^Adjustment disorder with anxiety
 ;;^UTILITY(U,$J,358.3,44672,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,44672,2)
 ;;=^331949
