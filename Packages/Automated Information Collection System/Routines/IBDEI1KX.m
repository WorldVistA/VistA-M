IBDEI1KX ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,26788,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26788,1,3,0)
 ;;=3^Insomnia,Other
 ;;^UTILITY(U,$J,358.3,26788,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,26788,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,26789,0)
 ;;=G47.00^^100^1290^15
 ;;^UTILITY(U,$J,358.3,26789,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26789,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,26789,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,26789,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,26790,0)
 ;;=G47.10^^100^1290^12
 ;;^UTILITY(U,$J,358.3,26790,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26790,1,3,0)
 ;;=3^Hypersomnolence Disorder/Unspec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,26790,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,26790,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,26791,0)
 ;;=G47.419^^100^1290^17
 ;;^UTILITY(U,$J,358.3,26791,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26791,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy w/ Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,26791,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,26791,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,26792,0)
 ;;=G47.33^^100^1290^21
 ;;^UTILITY(U,$J,358.3,26792,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26792,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,26792,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,26792,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,26793,0)
 ;;=G47.31^^100^1290^1
 ;;^UTILITY(U,$J,358.3,26793,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26793,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,26793,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,26793,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,26794,0)
 ;;=G47.21^^100^1290^5
 ;;^UTILITY(U,$J,358.3,26794,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26794,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,26794,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,26794,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,26795,0)
 ;;=G47.22^^100^1290^4
 ;;^UTILITY(U,$J,358.3,26795,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26795,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,26795,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,26795,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,26796,0)
 ;;=G47.23^^100^1290^6
 ;;^UTILITY(U,$J,358.3,26796,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26796,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,26796,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,26796,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,26797,0)
 ;;=G47.24^^100^1290^7
 ;;^UTILITY(U,$J,358.3,26797,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26797,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,26797,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,26797,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,26798,0)
 ;;=G47.26^^100^1290^8
 ;;^UTILITY(U,$J,358.3,26798,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26798,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,26798,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,26798,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,26799,0)
 ;;=G47.20^^100^1290^9
 ;;^UTILITY(U,$J,358.3,26799,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26799,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,26799,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,26799,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,26800,0)
 ;;=F51.3^^100^1290^19
 ;;^UTILITY(U,$J,358.3,26800,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,26800,1,3,0)
 ;;=3^Non-Rapid Eye Movement Sleep Arousal Disorder;Sleepwalking Type
