IBDEI02F ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,367,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,367,1,3,0)
 ;;=3^Sexual Dysfuntion NEC
 ;;^UTILITY(U,$J,358.3,367,1,4,0)
 ;;=4^F52.8
 ;;^UTILITY(U,$J,358.3,367,2)
 ;;=^5003624
 ;;^UTILITY(U,$J,358.3,368,0)
 ;;=F52.9^^3^47^8
 ;;^UTILITY(U,$J,358.3,368,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,368,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,368,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,368,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,369,0)
 ;;=G47.09^^3^48^11
 ;;^UTILITY(U,$J,358.3,369,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,369,1,3,0)
 ;;=3^Insomnia Disorder NEC
 ;;^UTILITY(U,$J,358.3,369,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,369,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,370,0)
 ;;=G47.00^^3^48^10
 ;;^UTILITY(U,$J,358.3,370,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,370,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,370,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,370,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,371,0)
 ;;=G47.10^^3^48^9
 ;;^UTILITY(U,$J,358.3,371,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,371,1,3,0)
 ;;=3^Hypersomnolence Disorder/Unspec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,371,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,371,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,372,0)
 ;;=G47.419^^3^48^12
 ;;^UTILITY(U,$J,358.3,372,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,372,1,3,0)
 ;;=3^Narcolepsy
 ;;^UTILITY(U,$J,358.3,372,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,372,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,373,0)
 ;;=G47.33^^3^48^16
 ;;^UTILITY(U,$J,358.3,373,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,373,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,373,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,373,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,374,0)
 ;;=G47.31^^3^48^1
 ;;^UTILITY(U,$J,358.3,374,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,374,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,374,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,374,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,375,0)
 ;;=G47.21^^3^48^3
 ;;^UTILITY(U,$J,358.3,375,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,375,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,375,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,375,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,376,0)
 ;;=G47.22^^3^48^2
 ;;^UTILITY(U,$J,358.3,376,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,376,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,376,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,376,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,377,0)
 ;;=G47.23^^3^48^4
 ;;^UTILITY(U,$J,358.3,377,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,377,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,377,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,377,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,378,0)
 ;;=G47.24^^3^48^5
 ;;^UTILITY(U,$J,358.3,378,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,378,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,378,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,378,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,379,0)
 ;;=G47.26^^3^48^6
 ;;^UTILITY(U,$J,358.3,379,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,379,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,379,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,379,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,380,0)
 ;;=G47.20^^3^48^7
 ;;^UTILITY(U,$J,358.3,380,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,380,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
