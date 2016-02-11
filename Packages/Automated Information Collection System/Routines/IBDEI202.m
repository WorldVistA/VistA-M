IBDEI202 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33488,0)
 ;;=G47.22^^148^1656^2
 ;;^UTILITY(U,$J,358.3,33488,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33488,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,33488,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,33488,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,33489,0)
 ;;=G47.23^^148^1656^4
 ;;^UTILITY(U,$J,358.3,33489,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33489,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,33489,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,33489,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,33490,0)
 ;;=G47.24^^148^1656^5
 ;;^UTILITY(U,$J,358.3,33490,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33490,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,33490,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,33490,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,33491,0)
 ;;=G47.26^^148^1656^6
 ;;^UTILITY(U,$J,358.3,33491,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33491,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,33491,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,33491,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,33492,0)
 ;;=G47.20^^148^1656^7
 ;;^UTILITY(U,$J,358.3,33492,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33492,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,33492,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,33492,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,33493,0)
 ;;=F51.3^^148^1656^14
 ;;^UTILITY(U,$J,358.3,33493,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33493,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,33493,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,33493,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,33494,0)
 ;;=F51.4^^148^1656^15
 ;;^UTILITY(U,$J,358.3,33494,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33494,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,33494,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,33494,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,33495,0)
 ;;=F51.5^^148^1656^13
 ;;^UTILITY(U,$J,358.3,33495,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33495,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,33495,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,33495,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,33496,0)
 ;;=G47.52^^148^1656^17
 ;;^UTILITY(U,$J,358.3,33496,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33496,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,33496,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,33496,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,33497,0)
 ;;=G25.81^^148^1656^18
 ;;^UTILITY(U,$J,358.3,33497,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33497,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,33497,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,33497,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,33498,0)
 ;;=G47.19^^148^1656^8
 ;;^UTILITY(U,$J,358.3,33498,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33498,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,33498,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,33498,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,33499,0)
 ;;=G47.8^^148^1656^19
 ;;^UTILITY(U,$J,358.3,33499,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33499,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,33499,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,33499,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,33500,0)
 ;;=F10.10^^148^1657^1
 ;;^UTILITY(U,$J,358.3,33500,1,0)
 ;;=^358.31IA^4^2
