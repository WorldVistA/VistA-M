IBDEI1BC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,20993,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake D/O;Unspec Type
 ;;^UTILITY(U,$J,358.3,20993,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,20993,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,20994,0)
 ;;=F51.3^^95^1042^22
 ;;^UTILITY(U,$J,358.3,20994,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20994,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleepwalking Type
 ;;^UTILITY(U,$J,358.3,20994,1,4,0)
 ;;=4^F51.3
 ;;^UTILITY(U,$J,358.3,20994,2)
 ;;=^5003613
 ;;^UTILITY(U,$J,358.3,20995,0)
 ;;=F51.4^^95^1042^23
 ;;^UTILITY(U,$J,358.3,20995,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20995,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal D/O;Sleep Terror Type
 ;;^UTILITY(U,$J,358.3,20995,1,4,0)
 ;;=4^F51.4
 ;;^UTILITY(U,$J,358.3,20995,2)
 ;;=^5003614
 ;;^UTILITY(U,$J,358.3,20996,0)
 ;;=F51.5^^95^1042^21
 ;;^UTILITY(U,$J,358.3,20996,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20996,1,3,0)
 ;;=3^Nightmare Disorder
 ;;^UTILITY(U,$J,358.3,20996,1,4,0)
 ;;=4^F51.5
 ;;^UTILITY(U,$J,358.3,20996,2)
 ;;=^5003615
 ;;^UTILITY(U,$J,358.3,20997,0)
 ;;=G47.52^^95^1042^25
 ;;^UTILITY(U,$J,358.3,20997,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20997,1,3,0)
 ;;=3^Rapid Eye Movement Sleep Behavior Disorder
 ;;^UTILITY(U,$J,358.3,20997,1,4,0)
 ;;=4^G47.52
 ;;^UTILITY(U,$J,358.3,20997,2)
 ;;=^332778
 ;;^UTILITY(U,$J,358.3,20998,0)
 ;;=G25.81^^95^1042^26
 ;;^UTILITY(U,$J,358.3,20998,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20998,1,3,0)
 ;;=3^Restless Legs Syndrome
 ;;^UTILITY(U,$J,358.3,20998,1,4,0)
 ;;=4^G25.81
 ;;^UTILITY(U,$J,358.3,20998,2)
 ;;=^5003801
 ;;^UTILITY(U,$J,358.3,20999,0)
 ;;=G47.19^^95^1042^13
 ;;^UTILITY(U,$J,358.3,20999,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,20999,1,3,0)
 ;;=3^Hypersomnolence Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,20999,1,4,0)
 ;;=4^G47.19
 ;;^UTILITY(U,$J,358.3,20999,2)
 ;;=^5003973
 ;;^UTILITY(U,$J,358.3,21000,0)
 ;;=G47.8^^95^1042^30
 ;;^UTILITY(U,$J,358.3,21000,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21000,1,3,0)
 ;;=3^Sleep-Wake Disorder,Other Specified
 ;;^UTILITY(U,$J,358.3,21000,1,4,0)
 ;;=4^G47.8
 ;;^UTILITY(U,$J,358.3,21000,2)
 ;;=^5003989
 ;;^UTILITY(U,$J,358.3,21001,0)
 ;;=G47.411^^95^1042^19
 ;;^UTILITY(U,$J,358.3,21001,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21001,1,3,0)
 ;;=3^Narcolepsy w/ Cataplexy w/o Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,21001,1,4,0)
 ;;=4^G47.411
 ;;^UTILITY(U,$J,358.3,21001,2)
 ;;=^5003981
 ;;^UTILITY(U,$J,358.3,21002,0)
 ;;=G47.37^^95^1042^3
 ;;^UTILITY(U,$J,358.3,21002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21002,1,3,0)
 ;;=3^Central Sleep Apnea,Comorbid w/ Opioid Use
 ;;^UTILITY(U,$J,358.3,21002,1,4,0)
 ;;=4^G47.37
 ;;^UTILITY(U,$J,358.3,21002,2)
 ;;=^332767
 ;;^UTILITY(U,$J,358.3,21003,0)
 ;;=F51.11^^95^1042^12
 ;;^UTILITY(U,$J,358.3,21003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21003,1,3,0)
 ;;=3^Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,21003,1,4,0)
 ;;=4^F51.11
 ;;^UTILITY(U,$J,358.3,21003,2)
 ;;=^5003609
 ;;^UTILITY(U,$J,358.3,21004,0)
 ;;=F51.01^^95^1042^15
 ;;^UTILITY(U,$J,358.3,21004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21004,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,21004,1,4,0)
 ;;=4^F51.01
 ;;^UTILITY(U,$J,358.3,21004,2)
 ;;=^5003603
 ;;^UTILITY(U,$J,358.3,21005,0)
 ;;=G47.36^^95^1042^27
 ;;^UTILITY(U,$J,358.3,21005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21005,1,3,0)
 ;;=3^Sleep-Related Hypoventilation,Comorbid Sleep-Related Hypoventilation
