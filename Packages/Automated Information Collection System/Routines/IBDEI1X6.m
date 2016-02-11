IBDEI1X6 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32145,0)
 ;;=G47.22^^141^1499^2
 ;;^UTILITY(U,$J,358.3,32145,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32145,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,32145,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,32145,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,32146,0)
 ;;=G47.23^^141^1499^4
 ;;^UTILITY(U,$J,358.3,32146,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32146,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,32146,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,32146,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,32147,0)
 ;;=G47.24^^141^1499^5
 ;;^UTILITY(U,$J,358.3,32147,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32147,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,32147,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,32147,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,32148,0)
 ;;=G47.26^^141^1499^6
 ;;^UTILITY(U,$J,358.3,32148,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32148,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,32148,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,32148,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,32149,0)
 ;;=G47.20^^141^1499^7
 ;;^UTILITY(U,$J,358.3,32149,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32149,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,32149,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,32149,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,32150,0)
 ;;=F51.3^^141^1499^14
 ;;^UTILITY(U,$J,358.3,32150,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32150,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,32150,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,32150,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,32151,0)
 ;;=F51.4^^141^1499^15
 ;;^UTILITY(U,$J,358.3,32151,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32151,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,32151,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,32151,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,32152,0)
 ;;=F51.5^^141^1499^13
 ;;^UTILITY(U,$J,358.3,32152,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32152,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,32152,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,32152,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,32153,0)
 ;;=G47.52^^141^1499^17
 ;;^UTILITY(U,$J,358.3,32153,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32153,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,32153,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,32153,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,32154,0)
 ;;=G25.81^^141^1499^18
 ;;^UTILITY(U,$J,358.3,32154,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32154,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,32154,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,32154,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,32155,0)
 ;;=G47.19^^141^1499^8
 ;;^UTILITY(U,$J,358.3,32155,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32155,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,32155,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,32155,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,32156,0)
 ;;=G47.8^^141^1499^19
 ;;^UTILITY(U,$J,358.3,32156,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32156,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,32156,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,32156,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,32157,0)
 ;;=F10.10^^141^1500^1
 ;;^UTILITY(U,$J,358.3,32157,1,0)
 ;;=^358.31IA^4^2
