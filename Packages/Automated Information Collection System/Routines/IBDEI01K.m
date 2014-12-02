IBDEI01K ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,249,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,249,1,2,0)
 ;;=2^305.71
 ;;^UTILITY(U,$J,358.3,249,1,5,0)
 ;;=5^Amphetamine Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,249,2)
 ;;=^268251
 ;;^UTILITY(U,$J,358.3,250,0)
 ;;=305.72^^2^18^18
 ;;^UTILITY(U,$J,358.3,250,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,250,1,2,0)
 ;;=2^305.72
 ;;^UTILITY(U,$J,358.3,250,1,5,0)
 ;;=5^Amphetamine Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,250,2)
 ;;=^268252
 ;;^UTILITY(U,$J,358.3,251,0)
 ;;=305.91^^2^18^77
 ;;^UTILITY(U,$J,358.3,251,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,251,1,2,0)
 ;;=2^305.91
 ;;^UTILITY(U,$J,358.3,251,1,5,0)
 ;;=5^Other Drug Abuse, Continuous
 ;;^UTILITY(U,$J,358.3,251,2)
 ;;=^268259
 ;;^UTILITY(U,$J,358.3,252,0)
 ;;=305.92^^2^18^78
 ;;^UTILITY(U,$J,358.3,252,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,252,1,2,0)
 ;;=2^305.92
 ;;^UTILITY(U,$J,358.3,252,1,5,0)
 ;;=5^Other Drug Abuse, Episodic
 ;;^UTILITY(U,$J,358.3,252,2)
 ;;=^268260
 ;;^UTILITY(U,$J,358.3,253,0)
 ;;=V65.2^^2^19^23
 ;;^UTILITY(U,$J,358.3,253,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,253,1,2,0)
 ;;=2^V65.2
 ;;^UTILITY(U,$J,358.3,253,1,5,0)
 ;;=5^Malingering
 ;;^UTILITY(U,$J,358.3,253,2)
 ;;=^92393
 ;;^UTILITY(U,$J,358.3,254,0)
 ;;=V65.49^^2^19^28
 ;;^UTILITY(U,$J,358.3,254,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,254,1,2,0)
 ;;=2^V65.49
 ;;^UTILITY(U,$J,358.3,254,1,5,0)
 ;;=5^Other Specified Counseling
 ;;^UTILITY(U,$J,358.3,254,2)
 ;;=^303471
 ;;^UTILITY(U,$J,358.3,255,0)
 ;;=V61.10^^2^19^33
 ;;^UTILITY(U,$J,358.3,255,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,255,1,2,0)
 ;;=2^V61.10
 ;;^UTILITY(U,$J,358.3,255,1,5,0)
 ;;=5^Partner Relational Problem
 ;;^UTILITY(U,$J,358.3,255,2)
 ;;=^74110
 ;;^UTILITY(U,$J,358.3,256,0)
 ;;=V61.20^^2^19^31
 ;;^UTILITY(U,$J,358.3,256,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,256,1,2,0)
 ;;=2^V61.20
 ;;^UTILITY(U,$J,358.3,256,1,5,0)
 ;;=5^Parent-Child Problem NOS
 ;;^UTILITY(U,$J,358.3,256,2)
 ;;=^304300
 ;;^UTILITY(U,$J,358.3,257,0)
 ;;=V61.12^^2^19^2
 ;;^UTILITY(U,$J,358.3,257,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,257,1,2,0)
 ;;=2^V61.12
 ;;^UTILITY(U,$J,358.3,257,1,5,0)
 ;;=5^Domestic Violence/Perpet
 ;;^UTILITY(U,$J,358.3,257,2)
 ;;=^304356
 ;;^UTILITY(U,$J,358.3,258,0)
 ;;=V61.11^^2^19^3
 ;;^UTILITY(U,$J,358.3,258,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,258,1,2,0)
 ;;=2^V61.11
 ;;^UTILITY(U,$J,358.3,258,1,5,0)
 ;;=5^Domestic Violence/Victim
 ;;^UTILITY(U,$J,358.3,258,2)
 ;;=^304357
 ;;^UTILITY(U,$J,358.3,259,0)
 ;;=V62.0^^2^19^40
 ;;^UTILITY(U,$J,358.3,259,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,259,1,2,0)
 ;;=2^V62.0
 ;;^UTILITY(U,$J,358.3,259,1,5,0)
 ;;=5^Unemployment
 ;;^UTILITY(U,$J,358.3,259,2)
 ;;=^123545
 ;;^UTILITY(U,$J,358.3,260,0)
 ;;=V69.2^^2^19^15
 ;;^UTILITY(U,$J,358.3,260,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,260,1,2,0)
 ;;=2^V69.2
 ;;^UTILITY(U,$J,358.3,260,1,5,0)
 ;;=5^Hi-Risk Sexual Behavior
 ;;^UTILITY(U,$J,358.3,260,2)
 ;;=^303474
 ;;^UTILITY(U,$J,358.3,261,0)
 ;;=V62.82^^2^19^1
 ;;^UTILITY(U,$J,358.3,261,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,261,1,2,0)
 ;;=2^V62.82
 ;;^UTILITY(U,$J,358.3,261,1,5,0)
 ;;=5^Bereavement/Uncomplicat
 ;;^UTILITY(U,$J,358.3,261,2)
 ;;=^123500
 ;;^UTILITY(U,$J,358.3,262,0)
 ;;=V70.1^^2^19^36
 ;;^UTILITY(U,$J,358.3,262,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,262,1,2,0)
 ;;=2^V70.1
 ;;^UTILITY(U,$J,358.3,262,1,5,0)
 ;;=5^Psych Exam, Mandated
 ;;^UTILITY(U,$J,358.3,262,2)
 ;;=^295591
 ;;^UTILITY(U,$J,358.3,263,0)
 ;;=V60.2^^2^19^4
 ;;^UTILITY(U,$J,358.3,263,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,263,1,2,0)
 ;;=2^V60.2
