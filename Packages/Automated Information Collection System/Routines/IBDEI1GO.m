IBDEI1GO ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24823,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,24824,0)
 ;;=F52.9^^93^1114^8
 ;;^UTILITY(U,$J,358.3,24824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24824,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,24824,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,24824,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,24825,0)
 ;;=G47.09^^93^1115^14
 ;;^UTILITY(U,$J,358.3,24825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24825,1,3,0)
 ;;=3^Insomnia,Other
 ;;^UTILITY(U,$J,358.3,24825,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,24825,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,24826,0)
 ;;=G47.00^^93^1115^15
 ;;^UTILITY(U,$J,358.3,24826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24826,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,24826,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,24826,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,24827,0)
 ;;=G47.10^^93^1115^12
 ;;^UTILITY(U,$J,358.3,24827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24827,1,3,0)
 ;;=3^Hypersomnolence Disorder/Unspec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,24827,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,24827,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,24828,0)
 ;;=G47.419^^93^1115^17
 ;;^UTILITY(U,$J,358.3,24828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24828,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy w/ Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,24828,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,24828,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,24829,0)
 ;;=G47.33^^93^1115^21
 ;;^UTILITY(U,$J,358.3,24829,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24829,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,24829,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,24829,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,24830,0)
 ;;=G47.31^^93^1115^1
 ;;^UTILITY(U,$J,358.3,24830,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24830,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,24830,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,24830,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,24831,0)
 ;;=G47.21^^93^1115^5
 ;;^UTILITY(U,$J,358.3,24831,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24831,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,24831,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,24831,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,24832,0)
 ;;=G47.22^^93^1115^4
 ;;^UTILITY(U,$J,358.3,24832,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24832,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,24832,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,24832,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,24833,0)
 ;;=G47.23^^93^1115^6
 ;;^UTILITY(U,$J,358.3,24833,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24833,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,24833,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,24833,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,24834,0)
 ;;=G47.24^^93^1115^7
 ;;^UTILITY(U,$J,358.3,24834,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24834,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,24834,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,24834,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,24835,0)
 ;;=G47.26^^93^1115^8
 ;;^UTILITY(U,$J,358.3,24835,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24835,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,24835,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,24835,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,24836,0)
 ;;=G47.20^^93^1115^9
 ;;^UTILITY(U,$J,358.3,24836,1,0)
 ;;=^358.31IA^4^2
