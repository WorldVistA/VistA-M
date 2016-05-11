IBDEI01X ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,410,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,410,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,411,0)
 ;;=G47.22^^3^48^4
 ;;^UTILITY(U,$J,358.3,411,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,411,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,411,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,411,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,412,0)
 ;;=G47.23^^3^48^6
 ;;^UTILITY(U,$J,358.3,412,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,412,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,412,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,412,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,413,0)
 ;;=G47.24^^3^48^7
 ;;^UTILITY(U,$J,358.3,413,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,413,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,413,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,413,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,414,0)
 ;;=G47.26^^3^48^8
 ;;^UTILITY(U,$J,358.3,414,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,414,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,414,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,414,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,415,0)
 ;;=G47.20^^3^48^9
 ;;^UTILITY(U,$J,358.3,415,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,415,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,415,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,415,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,416,0)
 ;;=F51.3^^3^48^19
 ;;^UTILITY(U,$J,358.3,416,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,416,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,416,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,416,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,417,0)
 ;;=F51.4^^3^48^20
 ;;^UTILITY(U,$J,358.3,417,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,417,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,417,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,417,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,418,0)
 ;;=F51.5^^3^48^18
 ;;^UTILITY(U,$J,358.3,418,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,418,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,418,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,418,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,419,0)
 ;;=G47.52^^3^48^22
 ;;^UTILITY(U,$J,358.3,419,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,419,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,419,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,419,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,420,0)
 ;;=G25.81^^3^48^23
 ;;^UTILITY(U,$J,358.3,420,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,420,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,420,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,420,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,421,0)
 ;;=G47.19^^3^48^11
 ;;^UTILITY(U,$J,358.3,421,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,421,1,3,0)
 ;;=3^Hypersomnolence Disorder NEC
 ;;^UTILITY(U,$J,358.3,421,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,421,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,422,0)
 ;;=G47.8^^3^48^27
 ;;^UTILITY(U,$J,358.3,422,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,422,1,3,0)
 ;;=3^Sleep-Wake Disorder NEC
 ;;^UTILITY(U,$J,358.3,422,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,422,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,423,0)
 ;;=G47.411^^3^48^16
 ;;^UTILITY(U,$J,358.3,423,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,423,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
