IBDEI1FC ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,24212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24212,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,24212,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,24212,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,24213,0)
 ;;=G47.31^^90^1060^1
 ;;^UTILITY(U,$J,358.3,24213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24213,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,24213,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,24213,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,24214,0)
 ;;=G47.21^^90^1060^5
 ;;^UTILITY(U,$J,358.3,24214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24214,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,24214,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,24214,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,24215,0)
 ;;=G47.22^^90^1060^4
 ;;^UTILITY(U,$J,358.3,24215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24215,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,24215,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,24215,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,24216,0)
 ;;=G47.23^^90^1060^6
 ;;^UTILITY(U,$J,358.3,24216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24216,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,24216,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,24216,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,24217,0)
 ;;=G47.24^^90^1060^7
 ;;^UTILITY(U,$J,358.3,24217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24217,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,24217,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,24217,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,24218,0)
 ;;=G47.26^^90^1060^8
 ;;^UTILITY(U,$J,358.3,24218,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24218,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,24218,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,24218,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,24219,0)
 ;;=G47.20^^90^1060^9
 ;;^UTILITY(U,$J,358.3,24219,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24219,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,24219,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,24219,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,24220,0)
 ;;=F51.3^^90^1060^19
 ;;^UTILITY(U,$J,358.3,24220,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24220,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,24220,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,24220,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,24221,0)
 ;;=F51.4^^90^1060^20
 ;;^UTILITY(U,$J,358.3,24221,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24221,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,24221,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,24221,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,24222,0)
 ;;=F51.5^^90^1060^18
 ;;^UTILITY(U,$J,358.3,24222,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24222,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,24222,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,24222,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,24223,0)
 ;;=G47.52^^90^1060^22
 ;;^UTILITY(U,$J,358.3,24223,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24223,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,24223,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,24223,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,24224,0)
 ;;=G25.81^^90^1060^23
 ;;^UTILITY(U,$J,358.3,24224,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,24224,1,3,0)
 ;;=3^Restless Legs Syndrome
