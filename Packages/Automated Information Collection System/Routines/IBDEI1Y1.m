IBDEI1Y1 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,32538,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,32538,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,32539,0)
 ;;=G47.22^^143^1542^2
 ;;^UTILITY(U,$J,358.3,32539,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32539,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,32539,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,32539,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,32540,0)
 ;;=G47.23^^143^1542^4
 ;;^UTILITY(U,$J,358.3,32540,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32540,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,32540,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,32540,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,32541,0)
 ;;=G47.24^^143^1542^5
 ;;^UTILITY(U,$J,358.3,32541,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32541,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,32541,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,32541,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,32542,0)
 ;;=G47.26^^143^1542^6
 ;;^UTILITY(U,$J,358.3,32542,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32542,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,32542,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,32542,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,32543,0)
 ;;=G47.20^^143^1542^7
 ;;^UTILITY(U,$J,358.3,32543,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32543,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,32543,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,32543,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,32544,0)
 ;;=F51.3^^143^1542^14
 ;;^UTILITY(U,$J,358.3,32544,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32544,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,32544,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,32544,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,32545,0)
 ;;=F51.4^^143^1542^15
 ;;^UTILITY(U,$J,358.3,32545,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32545,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,32545,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,32545,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,32546,0)
 ;;=F51.5^^143^1542^13
 ;;^UTILITY(U,$J,358.3,32546,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32546,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,32546,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,32546,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,32547,0)
 ;;=G47.52^^143^1542^17
 ;;^UTILITY(U,$J,358.3,32547,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32547,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,32547,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,32547,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,32548,0)
 ;;=G25.81^^143^1542^18
 ;;^UTILITY(U,$J,358.3,32548,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32548,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,32548,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,32548,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,32549,0)
 ;;=G47.19^^143^1542^8
 ;;^UTILITY(U,$J,358.3,32549,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32549,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,32549,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,32549,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,32550,0)
 ;;=G47.8^^143^1542^19
 ;;^UTILITY(U,$J,358.3,32550,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,32550,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,32550,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,32550,2)
 ;;=^5003989
