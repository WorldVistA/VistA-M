IBDEI354 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,52717,0)
 ;;=J0585^^239^2637^2^^^^1
 ;;^UTILITY(U,$J,358.3,52717,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52717,1,2,0)
 ;;=2^J0585
 ;;^UTILITY(U,$J,358.3,52717,1,3,0)
 ;;=3^Botulinum Toxin A,per unit
 ;;^UTILITY(U,$J,358.3,52718,0)
 ;;=J0587^^239^2637^3^^^^1
 ;;^UTILITY(U,$J,358.3,52718,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52718,1,2,0)
 ;;=2^J0587
 ;;^UTILITY(U,$J,358.3,52718,1,3,0)
 ;;=3^Botulinum Toxin B,100 units
 ;;^UTILITY(U,$J,358.3,52719,0)
 ;;=J0586^^239^2637^1^^^^1
 ;;^UTILITY(U,$J,358.3,52719,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,52719,1,2,0)
 ;;=2^J0586
 ;;^UTILITY(U,$J,358.3,52719,1,3,0)
 ;;=3^Botulinum Toxin A,5 units
 ;;^UTILITY(U,$J,358.3,52720,0)
 ;;=Z87.81^^240^2638^2
 ;;^UTILITY(U,$J,358.3,52720,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52720,1,3,0)
 ;;=3^Personal history of (healed) traumatic fracture
 ;;^UTILITY(U,$J,358.3,52720,1,4,0)
 ;;=4^Z87.81
 ;;^UTILITY(U,$J,358.3,52720,2)
 ;;=^5063513
 ;;^UTILITY(U,$J,358.3,52721,0)
 ;;=Z87.828^^240^2638^3
 ;;^UTILITY(U,$J,358.3,52721,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52721,1,3,0)
 ;;=3^Personal history of oth (healed) physical injury and trauma
 ;;^UTILITY(U,$J,358.3,52721,1,4,0)
 ;;=4^Z87.828
 ;;^UTILITY(U,$J,358.3,52721,2)
 ;;=^5063516
 ;;^UTILITY(U,$J,358.3,52722,0)
 ;;=S06.9X9S^^240^2638^1
 ;;^UTILITY(U,$J,358.3,52722,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52722,1,3,0)
 ;;=3^Intracranial injury w LOC of unsp duration unspec, sequela
 ;;^UTILITY(U,$J,358.3,52722,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,52722,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,52723,0)
 ;;=F43.21^^240^2639^3
 ;;^UTILITY(U,$J,358.3,52723,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52723,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,52723,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,52723,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,52724,0)
 ;;=G47.00^^240^2639^7
 ;;^UTILITY(U,$J,358.3,52724,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52724,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,52724,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,52724,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,52725,0)
 ;;=F43.10^^240^2639^10
 ;;^UTILITY(U,$J,358.3,52725,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52725,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,52725,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,52725,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,52726,0)
 ;;=F43.12^^240^2639^9
 ;;^UTILITY(U,$J,358.3,52726,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52726,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,52726,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,52726,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,52727,0)
 ;;=F43.11^^240^2639^8
 ;;^UTILITY(U,$J,358.3,52727,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52727,1,3,0)
 ;;=3^Post-traumatic stress disorder, acute
 ;;^UTILITY(U,$J,358.3,52727,1,4,0)
 ;;=4^F43.11
 ;;^UTILITY(U,$J,358.3,52727,2)
 ;;=^5003571
 ;;^UTILITY(U,$J,358.3,52728,0)
 ;;=F43.22^^240^2639^2
 ;;^UTILITY(U,$J,358.3,52728,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52728,1,3,0)
 ;;=3^Adjustment disorder with anxiety
 ;;^UTILITY(U,$J,358.3,52728,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,52728,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,52729,0)
 ;;=F43.23^^240^2639^5
 ;;^UTILITY(U,$J,358.3,52729,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,52729,1,3,0)
 ;;=3^Adjustment disorder with mixed anxiety and depressed mood
 ;;^UTILITY(U,$J,358.3,52729,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,52729,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,52730,0)
 ;;=F43.24^^240^2639^4
