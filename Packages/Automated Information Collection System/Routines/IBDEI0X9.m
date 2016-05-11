IBDEI0X9 ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,15604,2)
 ;;=^5003625
 ;;^UTILITY(U,$J,358.3,15605,0)
 ;;=G47.09^^58^683^14
 ;;^UTILITY(U,$J,358.3,15605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15605,1,3,0)
 ;;=3^Insomnia,Other
 ;;^UTILITY(U,$J,358.3,15605,1,4,0)
 ;;=4^G47.09
 ;;^UTILITY(U,$J,358.3,15605,2)
 ;;=^5003970
 ;;^UTILITY(U,$J,358.3,15606,0)
 ;;=G47.00^^58^683^15
 ;;^UTILITY(U,$J,358.3,15606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15606,1,3,0)
 ;;=3^Insomnia,Unspec
 ;;^UTILITY(U,$J,358.3,15606,1,4,0)
 ;;=4^G47.00
 ;;^UTILITY(U,$J,358.3,15606,2)
 ;;=^332924
 ;;^UTILITY(U,$J,358.3,15607,0)
 ;;=G47.10^^58^683^12
 ;;^UTILITY(U,$J,358.3,15607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15607,1,3,0)
 ;;=3^Hypersomnolence Disorder/Unspec Hypersomnolence Disorder
 ;;^UTILITY(U,$J,358.3,15607,1,4,0)
 ;;=4^G47.10
 ;;^UTILITY(U,$J,358.3,15607,2)
 ;;=^332926
 ;;^UTILITY(U,$J,358.3,15608,0)
 ;;=G47.419^^58^683^17
 ;;^UTILITY(U,$J,358.3,15608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15608,1,3,0)
 ;;=3^Narcolepsy w/o Cataplexy w/ Hypocretin Deficiency
 ;;^UTILITY(U,$J,358.3,15608,1,4,0)
 ;;=4^G47.419
 ;;^UTILITY(U,$J,358.3,15608,2)
 ;;=^5003982
 ;;^UTILITY(U,$J,358.3,15609,0)
 ;;=G47.33^^58^683^21
 ;;^UTILITY(U,$J,358.3,15609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15609,1,3,0)
 ;;=3^Obstructive Sleep Apnea Hypopnea
 ;;^UTILITY(U,$J,358.3,15609,1,4,0)
 ;;=4^G47.33
 ;;^UTILITY(U,$J,358.3,15609,2)
 ;;=^332763
 ;;^UTILITY(U,$J,358.3,15610,0)
 ;;=G47.31^^58^683^1
 ;;^UTILITY(U,$J,358.3,15610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15610,1,3,0)
 ;;=3^Central Sleep Apnea
 ;;^UTILITY(U,$J,358.3,15610,1,4,0)
 ;;=4^G47.31
 ;;^UTILITY(U,$J,358.3,15610,2)
 ;;=^332761
 ;;^UTILITY(U,$J,358.3,15611,0)
 ;;=G47.21^^58^683^5
 ;;^UTILITY(U,$J,358.3,15611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15611,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Delayed Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,15611,1,4,0)
 ;;=4^G47.21
 ;;^UTILITY(U,$J,358.3,15611,2)
 ;;=^332769
 ;;^UTILITY(U,$J,358.3,15612,0)
 ;;=G47.22^^58^683^4
 ;;^UTILITY(U,$J,358.3,15612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15612,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Advanced Sleep Phase Type
 ;;^UTILITY(U,$J,358.3,15612,1,4,0)
 ;;=4^G47.22
 ;;^UTILITY(U,$J,358.3,15612,2)
 ;;=^332770
 ;;^UTILITY(U,$J,358.3,15613,0)
 ;;=G47.23^^58^683^6
 ;;^UTILITY(U,$J,358.3,15613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15613,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Irregular Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,15613,1,4,0)
 ;;=4^G47.23
 ;;^UTILITY(U,$J,358.3,15613,2)
 ;;=^5003975
 ;;^UTILITY(U,$J,358.3,15614,0)
 ;;=G47.24^^58^683^7
 ;;^UTILITY(U,$J,358.3,15614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15614,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Non-24 Hr Sleep Wake Type
 ;;^UTILITY(U,$J,358.3,15614,1,4,0)
 ;;=4^G47.24
 ;;^UTILITY(U,$J,358.3,15614,2)
 ;;=^5003976
 ;;^UTILITY(U,$J,358.3,15615,0)
 ;;=G47.26^^58^683^8
 ;;^UTILITY(U,$J,358.3,15615,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15615,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Shift Work Type
 ;;^UTILITY(U,$J,358.3,15615,1,4,0)
 ;;=4^G47.26
 ;;^UTILITY(U,$J,358.3,15615,2)
 ;;=^332774
 ;;^UTILITY(U,$J,358.3,15616,0)
 ;;=G47.20^^58^683^9
 ;;^UTILITY(U,$J,358.3,15616,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,15616,1,3,0)
 ;;=3^Circadian Rhythm Sleep-Wake Disorder;Unspec Type
 ;;^UTILITY(U,$J,358.3,15616,1,4,0)
 ;;=4^G47.20
 ;;^UTILITY(U,$J,358.3,15616,2)
 ;;=^5003974
 ;;^UTILITY(U,$J,358.3,15617,0)
 ;;=F51.3^^58^683^19
 ;;^UTILITY(U,$J,358.3,15617,1,0)
 ;;=^358.31IA^4^2
