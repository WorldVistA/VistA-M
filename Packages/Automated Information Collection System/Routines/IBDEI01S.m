IBDEI01S ; ; 20-MAY-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;OCT 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,315,1,5,0)
 ;;=5^Other Drug Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,315,2)
 ;;=^268260
 ;;^UTILITY(U,$J,358.3,316,0)
 ;;=V65.2^^3^36^33
 ;;^UTILITY(U,$J,358.3,316,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,316,1,2,0)
 ;;=2^V65.2
 ;;^UTILITY(U,$J,358.3,316,1,5,0)
 ;;=5^Malingering
 ;;^UTILITY(U,$J,358.3,316,2)
 ;;=^92393
 ;;^UTILITY(U,$J,358.3,317,0)
 ;;=V65.49^^3^36^38
 ;;^UTILITY(U,$J,358.3,317,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,317,1,2,0)
 ;;=2^V65.49
 ;;^UTILITY(U,$J,358.3,317,1,5,0)
 ;;=5^Other Specified Counseling
 ;;^UTILITY(U,$J,358.3,317,2)
 ;;=^303471
 ;;^UTILITY(U,$J,358.3,318,0)
 ;;=V61.10^^3^36^43
 ;;^UTILITY(U,$J,358.3,318,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,318,1,2,0)
 ;;=2^V61.10
 ;;^UTILITY(U,$J,358.3,318,1,5,0)
 ;;=5^Partner Relational Problem
 ;;^UTILITY(U,$J,358.3,318,2)
 ;;=^74110
 ;;^UTILITY(U,$J,358.3,319,0)
 ;;=V61.20^^3^36^41
 ;;^UTILITY(U,$J,358.3,319,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,319,1,2,0)
 ;;=2^V61.20
 ;;^UTILITY(U,$J,358.3,319,1,5,0)
 ;;=5^Parent-Child Problem NOS
 ;;^UTILITY(U,$J,358.3,319,2)
 ;;=^304300
 ;;^UTILITY(U,$J,358.3,320,0)
 ;;=V61.12^^3^36^2
 ;;^UTILITY(U,$J,358.3,320,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,320,1,2,0)
 ;;=2^V61.12
 ;;^UTILITY(U,$J,358.3,320,1,5,0)
 ;;=5^Domestic Violence/Perpet
 ;;^UTILITY(U,$J,358.3,320,2)
 ;;=^304356
 ;;^UTILITY(U,$J,358.3,321,0)
 ;;=V61.11^^3^36^3
 ;;^UTILITY(U,$J,358.3,321,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,321,1,2,0)
 ;;=2^V61.11
 ;;^UTILITY(U,$J,358.3,321,1,5,0)
 ;;=5^Domestic Violence/Victim
 ;;^UTILITY(U,$J,358.3,321,2)
 ;;=^304357
 ;;^UTILITY(U,$J,358.3,322,0)
 ;;=V62.0^^3^36^51
 ;;^UTILITY(U,$J,358.3,322,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,322,1,2,0)
 ;;=2^V62.0
 ;;^UTILITY(U,$J,358.3,322,1,5,0)
 ;;=5^Unemployment
 ;;^UTILITY(U,$J,358.3,322,2)
 ;;=^123545
 ;;^UTILITY(U,$J,358.3,323,0)
 ;;=V69.2^^3^36^15
 ;;^UTILITY(U,$J,358.3,323,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,323,1,2,0)
 ;;=2^V69.2
 ;;^UTILITY(U,$J,358.3,323,1,5,0)
 ;;=5^Hi-Risk Sexual Behavior
 ;;^UTILITY(U,$J,358.3,323,2)
 ;;=^303474
 ;;^UTILITY(U,$J,358.3,324,0)
 ;;=V62.82^^3^36^1
 ;;^UTILITY(U,$J,358.3,324,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,324,1,2,0)
 ;;=2^V62.82
 ;;^UTILITY(U,$J,358.3,324,1,5,0)
 ;;=5^Bereavement/Uncomplicat
 ;;^UTILITY(U,$J,358.3,324,2)
 ;;=^123500
 ;;^UTILITY(U,$J,358.3,325,0)
 ;;=V70.1^^3^36^46
 ;;^UTILITY(U,$J,358.3,325,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,325,1,2,0)
 ;;=2^V70.1
 ;;^UTILITY(U,$J,358.3,325,1,5,0)
 ;;=5^Psych Exam, Mandated
 ;;^UTILITY(U,$J,358.3,325,2)
 ;;=^295591
 ;;^UTILITY(U,$J,358.3,326,0)
 ;;=V60.2^^3^36^4
 ;;^UTILITY(U,$J,358.3,326,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,326,1,2,0)
 ;;=2^V60.2
 ;;^UTILITY(U,$J,358.3,326,1,5,0)
 ;;=5^Economic Problem
 ;;^UTILITY(U,$J,358.3,326,2)
 ;;=^62174
 ;;^UTILITY(U,$J,358.3,327,0)
 ;;=V62.89^^3^36^47
 ;;^UTILITY(U,$J,358.3,327,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,327,1,2,0)
 ;;=2^V62.89
 ;;^UTILITY(U,$J,358.3,327,1,5,0)
 ;;=5^Psychological Stress
 ;;^UTILITY(U,$J,358.3,327,2)
 ;;=^87822
 ;;^UTILITY(U,$J,358.3,328,0)
 ;;=V62.9^^3^36^48
 ;;^UTILITY(U,$J,358.3,328,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,328,1,2,0)
 ;;=2^V62.9
 ;;^UTILITY(U,$J,358.3,328,1,5,0)
 ;;=5^Psychosocial Circum
 ;;^UTILITY(U,$J,358.3,328,2)
 ;;=^295551
 ;;^UTILITY(U,$J,358.3,329,0)
 ;;=V60.0^^3^36^31
 ;;^UTILITY(U,$J,358.3,329,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,329,1,2,0)
 ;;=2^V60.0
 ;;^UTILITY(U,$J,358.3,329,1,5,0)
 ;;=5^Lack Of Housing
 ;;^UTILITY(U,$J,358.3,329,2)
 ;;=^295539
