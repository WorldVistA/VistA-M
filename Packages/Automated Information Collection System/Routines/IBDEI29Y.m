IBDEI29Y ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38584,1,3,0)
 ;;=3^Intracranial injury w LOC of unsp duration unspec, sequela
 ;;^UTILITY(U,$J,358.3,38584,1,4,0)
 ;;=4^S06.9X9S
 ;;^UTILITY(U,$J,358.3,38584,2)
 ;;=^5021235
 ;;^UTILITY(U,$J,358.3,38585,0)
 ;;=F43.21^^148^1886^3
 ;;^UTILITY(U,$J,358.3,38585,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38585,1,3,0)
 ;;=3^Adjustment disorder with depressed mood
 ;;^UTILITY(U,$J,358.3,38585,1,4,0)
 ;;=4^F43.21
 ;;^UTILITY(U,$J,358.3,38585,2)
 ;;=^331948
 ;;^UTILITY(U,$J,358.3,38586,0)
 ;;=G47.00^^148^1886^7
 ;;^UTILITY(U,$J,358.3,38586,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38586,1,3,0)
 ;;=3^Insomnia, unspecified
 ;;^UTILITY(U,$J,358.3,38586,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,38586,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,38587,0)
 ;;=F43.10^^148^1886^10
 ;;^UTILITY(U,$J,358.3,38587,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38587,1,3,0)
 ;;=3^Post-traumatic stress disorder, unspecified
 ;;^UTILITY(U,$J,358.3,38587,1,4,0)
 ;;=4^F43.10
 ;;^UTILITY(U,$J,358.3,38587,2)
 ;;=^5003570
 ;;^UTILITY(U,$J,358.3,38588,0)
 ;;=F43.12^^148^1886^9
 ;;^UTILITY(U,$J,358.3,38588,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38588,1,3,0)
 ;;=3^Post-traumatic stress disorder, chronic
 ;;^UTILITY(U,$J,358.3,38588,1,4,0)
 ;;=4^F43.12
 ;;^UTILITY(U,$J,358.3,38588,2)
 ;;=^5003572
 ;;^UTILITY(U,$J,358.3,38589,0)
 ;;=F43.11^^148^1886^8
 ;;^UTILITY(U,$J,358.3,38589,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38589,1,3,0)
 ;;=3^Post-traumatic stress disorder, acute
 ;;^UTILITY(U,$J,358.3,38589,1,4,0)
 ;;=4^F43.11
 ;;^UTILITY(U,$J,358.3,38589,2)
 ;;=^5003571
 ;;^UTILITY(U,$J,358.3,38590,0)
 ;;=F43.22^^148^1886^2
 ;;^UTILITY(U,$J,358.3,38590,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38590,1,3,0)
 ;;=3^Adjustment disorder with anxiety
 ;;^UTILITY(U,$J,358.3,38590,1,4,0)
 ;;=4^F43.22
 ;;^UTILITY(U,$J,358.3,38590,2)
 ;;=^331949
 ;;^UTILITY(U,$J,358.3,38591,0)
 ;;=F43.23^^148^1886^5
 ;;^UTILITY(U,$J,358.3,38591,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38591,1,3,0)
 ;;=3^Adjustment disorder with mixed anxiety and depressed mood
 ;;^UTILITY(U,$J,358.3,38591,1,4,0)
 ;;=4^F43.23
 ;;^UTILITY(U,$J,358.3,38591,2)
 ;;=^331950
 ;;^UTILITY(U,$J,358.3,38592,0)
 ;;=F43.24^^148^1886^4
 ;;^UTILITY(U,$J,358.3,38592,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38592,1,3,0)
 ;;=3^Adjustment disorder with disturbance of conduct
 ;;^UTILITY(U,$J,358.3,38592,1,4,0)
 ;;=4^F43.24
 ;;^UTILITY(U,$J,358.3,38592,2)
 ;;=^331951
 ;;^UTILITY(U,$J,358.3,38593,0)
 ;;=F43.25^^148^1886^1
 ;;^UTILITY(U,$J,358.3,38593,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38593,1,3,0)
 ;;=3^Adjustment disorder w mixed disturb of emotions and conduct
 ;;^UTILITY(U,$J,358.3,38593,1,4,0)
 ;;=4^F43.25
 ;;^UTILITY(U,$J,358.3,38593,2)
 ;;=^331952
 ;;^UTILITY(U,$J,358.3,38594,0)
 ;;=F43.29^^148^1886^6
 ;;^UTILITY(U,$J,358.3,38594,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38594,1,3,0)
 ;;=3^Adjustment disorder with other symptoms
 ;;^UTILITY(U,$J,358.3,38594,1,4,0)
 ;;=4^F43.29
 ;;^UTILITY(U,$J,358.3,38594,2)
 ;;=^5003574
 ;;^UTILITY(U,$J,358.3,38595,0)
 ;;=M79.7^^148^1887^2
 ;;^UTILITY(U,$J,358.3,38595,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38595,1,3,0)
 ;;=3^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,38595,1,4,0)
 ;;=4^M79.7
 ;;^UTILITY(U,$J,358.3,38595,2)
 ;;=^46261
 ;;^UTILITY(U,$J,358.3,38596,0)
 ;;=R20.2^^148^1887^3
 ;;^UTILITY(U,$J,358.3,38596,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38596,1,3,0)
 ;;=3^Paresthesia of skin
 ;;^UTILITY(U,$J,358.3,38596,1,4,0)
 ;;=4^R20.2
 ;;^UTILITY(U,$J,358.3,38596,2)
 ;;=^5019280
 ;;^UTILITY(U,$J,358.3,38597,0)
 ;;=R42.^^148^1887^1
