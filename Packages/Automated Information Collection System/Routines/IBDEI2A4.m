IBDEI2A4 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,38276,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38276,1,3,0)
 ;;=3^Sexual Dysfunction,Unspec
 ;;^UTILITY(U,$J,358.3,38276,1,4,0)
 ;;=4^F52.9
 ;;^UTILITY(U,$J,358.3,38276,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,38277,0)
 ;;=G47.09^^177^1939^11
 ;;^UTILITY(U,$J,358.3,38277,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38277,1,3,0)
 ;;=3^Insomnia Disorder NEC
 ;;^UTILITY(U,$J,358.3,38277,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,38277,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,38278,0)
 ;;=G47.00^^177^1939^10
 ;;^UTILITY(U,$J,358.3,38278,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38278,1,3,0)
 ;;=3^Insomnia Disorder
 ;;^UTILITY(U,$J,358.3,38278,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,38278,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,38279,0)
 ;;=G47.10^^177^1939^9
 ;;^UTILITY(U,$J,358.3,38279,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38279,1,3,0)
 ;;=3^Hypersomnolence Disorder/Unspec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,38279,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,38279,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,38280,0)
 ;;=G47.419^^177^1939^12
 ;;^UTILITY(U,$J,358.3,38280,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38280,1,3,0)
 ;;=3^Narcolepsy
 ;;^UTILITY(U,$J,358.3,38280,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,38280,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,38281,0)
 ;;=G47.33^^177^1939^16
 ;;^UTILITY(U,$J,358.3,38281,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38281,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,38281,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,38281,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,38282,0)
 ;;=G47.31^^177^1939^1
 ;;^UTILITY(U,$J,358.3,38282,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38282,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,38282,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,38282,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,38283,0)
 ;;=G47.21^^177^1939^3
 ;;^UTILITY(U,$J,358.3,38283,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38283,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,38283,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,38283,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,38284,0)
 ;;=G47.22^^177^1939^2
 ;;^UTILITY(U,$J,358.3,38284,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38284,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,38284,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,38284,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,38285,0)
 ;;=G47.23^^177^1939^4
 ;;^UTILITY(U,$J,358.3,38285,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38285,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,38285,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,38285,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,38286,0)
 ;;=G47.24^^177^1939^5
 ;;^UTILITY(U,$J,358.3,38286,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38286,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,38286,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,38286,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,38287,0)
 ;;=G47.26^^177^1939^6
 ;;^UTILITY(U,$J,358.3,38287,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38287,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,38287,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,38287,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,38288,0)
 ;;=G47.20^^177^1939^7
 ;;^UTILITY(U,$J,358.3,38288,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,38288,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,38288,1,4,0)
 ;;=4^G47.20
