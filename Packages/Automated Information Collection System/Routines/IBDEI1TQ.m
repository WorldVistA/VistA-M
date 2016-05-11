IBDEI1TQ ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30985,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,30985,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,30985,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,30986,0)
 ;;=G47.23^^123^1554^6
 ;;^UTILITY(U,$J,358.3,30986,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30986,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,30986,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,30986,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,30987,0)
 ;;=G47.24^^123^1554^7
 ;;^UTILITY(U,$J,358.3,30987,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30987,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,30987,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,30987,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,30988,0)
 ;;=G47.26^^123^1554^8
 ;;^UTILITY(U,$J,358.3,30988,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30988,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,30988,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,30988,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,30989,0)
 ;;=G47.20^^123^1554^9
 ;;^UTILITY(U,$J,358.3,30989,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30989,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,30989,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,30989,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,30990,0)
 ;;=F51.3^^123^1554^19
 ;;^UTILITY(U,$J,358.3,30990,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30990,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,30990,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,30990,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,30991,0)
 ;;=F51.4^^123^1554^20
 ;;^UTILITY(U,$J,358.3,30991,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30991,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,30991,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,30991,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,30992,0)
 ;;=F51.5^^123^1554^18
 ;;^UTILITY(U,$J,358.3,30992,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30992,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,30992,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,30992,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,30993,0)
 ;;=G47.52^^123^1554^22
 ;;^UTILITY(U,$J,358.3,30993,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30993,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,30993,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,30993,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,30994,0)
 ;;=G25.81^^123^1554^23
 ;;^UTILITY(U,$J,358.3,30994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30994,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,30994,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,30994,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,30995,0)
 ;;=G47.19^^123^1554^11
 ;;^UTILITY(U,$J,358.3,30995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30995,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,30995,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,30995,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,30996,0)
 ;;=G47.8^^123^1554^27
 ;;^UTILITY(U,$J,358.3,30996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30996,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,30996,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,30996,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,30997,0)
 ;;=G47.411^^123^1554^16
 ;;^UTILITY(U,$J,358.3,30997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30997,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
