IBDEI0O1 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10815,1,3,0)
 ;;=3^Insomnia,Other Specified
 ;;^UTILITY(U,$J,358.3,10815,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,10815,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,10816,0)
 ;;=G47.00^^42^490^17
 ;;^UTILITY(U,$J,358.3,10816,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10816,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,10816,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,10816,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,10817,0)
 ;;=G47.10^^42^490^14
 ;;^UTILITY(U,$J,358.3,10817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10817,1,3,0)
 ;;=3^Hypersomnolence Disorder,Unspec
 ;;^UTILITY(U,$J,358.3,10817,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,10817,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,10818,0)
 ;;=G47.419^^42^490^20
 ;;^UTILITY(U,$J,358.3,10818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10818,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy w/ Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,10818,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,10818,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,10819,0)
 ;;=G47.33^^42^490^24
 ;;^UTILITY(U,$J,358.3,10819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10819,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,10819,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,10819,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,10820,0)
 ;;=G47.31^^42^490^4
 ;;^UTILITY(U,$J,358.3,10820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10820,1,3,0)
 ;;=3^Central Sleep Apnea,Idiopathic
 ;;^UTILITY(U,$J,358.3,10820,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,10820,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,10821,0)
 ;;=G47.21^^42^490^7
 ;;^UTILITY(U,$J,358.3,10821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10821,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,10821,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,10821,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,10822,0)
 ;;=G47.22^^42^490^6
 ;;^UTILITY(U,$J,358.3,10822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10822,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,10822,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,10822,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,10823,0)
 ;;=G47.23^^42^490^8
 ;;^UTILITY(U,$J,358.3,10823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10823,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,10823,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,10823,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,10824,0)
 ;;=G47.24^^42^490^9
 ;;^UTILITY(U,$J,358.3,10824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10824,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,10824,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,10824,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,10825,0)
 ;;=G47.26^^42^490^10
 ;;^UTILITY(U,$J,358.3,10825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10825,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Shift Work Type
 ;;^UTILITY(U,$J,358.3,10825,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,10825,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,10826,0)
 ;;=G47.20^^42^490^11
 ;;^UTILITY(U,$J,358.3,10826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10826,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Unspec Type
 ;;^UTILITY(U,$J,358.3,10826,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,10826,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,10827,0)
 ;;=F51.3^^42^490^22
 ;;^UTILITY(U,$J,358.3,10827,1,0)
 ;;=^358.31IA^4^2
