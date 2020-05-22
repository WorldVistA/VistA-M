IBDEI0RC ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,12206,1,4,0)
 ;;=4^S01.412A
 ;;^UTILITY(U,$J,358.3,12206,2)
 ;;=^5020156
 ;;^UTILITY(U,$J,358.3,12207,0)
 ;;=S01.312A^^80^774^10
 ;;^UTILITY(U,$J,358.3,12207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12207,1,3,0)
 ;;=3^Laceration w/o FB of Left Ear,Init Encntr
 ;;^UTILITY(U,$J,358.3,12207,1,4,0)
 ;;=4^S01.312A
 ;;^UTILITY(U,$J,358.3,12207,2)
 ;;=^5020117
 ;;^UTILITY(U,$J,358.3,12208,0)
 ;;=S51.012A^^80^774^11
 ;;^UTILITY(U,$J,358.3,12208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12208,1,3,0)
 ;;=3^Laceration w/o FB of Left Elbow,Init Encntr
 ;;^UTILITY(U,$J,358.3,12208,1,4,0)
 ;;=4^S51.012A
 ;;^UTILITY(U,$J,358.3,12208,2)
 ;;=^5028629
 ;;^UTILITY(U,$J,358.3,12209,0)
 ;;=S91.212A^^80^774^13
 ;;^UTILITY(U,$J,358.3,12209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12209,1,3,0)
 ;;=3^Laceration w/o FB of Left Great Toe w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12209,1,4,0)
 ;;=4^S91.212A
 ;;^UTILITY(U,$J,358.3,12209,2)
 ;;=^5044276
 ;;^UTILITY(U,$J,358.3,12210,0)
 ;;=S91.112A^^80^774^14
 ;;^UTILITY(U,$J,358.3,12210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12210,1,3,0)
 ;;=3^Laceration w/o FB of Left Great Toe w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12210,1,4,0)
 ;;=4^S91.112A
 ;;^UTILITY(U,$J,358.3,12210,2)
 ;;=^5044186
 ;;^UTILITY(U,$J,358.3,12211,0)
 ;;=S61.412A^^80^774^15
 ;;^UTILITY(U,$J,358.3,12211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12211,1,3,0)
 ;;=3^Laceration w/o FB of Left Hand,Init Encntr
 ;;^UTILITY(U,$J,358.3,12211,1,4,0)
 ;;=4^S61.412A
 ;;^UTILITY(U,$J,358.3,12211,2)
 ;;=^5032990
 ;;^UTILITY(U,$J,358.3,12212,0)
 ;;=S61.311A^^80^774^17
 ;;^UTILITY(U,$J,358.3,12212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12212,1,3,0)
 ;;=3^Laceration w/o FB of Left Index Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12212,1,4,0)
 ;;=4^S61.311A
 ;;^UTILITY(U,$J,358.3,12212,2)
 ;;=^5032909
 ;;^UTILITY(U,$J,358.3,12213,0)
 ;;=S61.211A^^80^774^18
 ;;^UTILITY(U,$J,358.3,12213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12213,1,3,0)
 ;;=3^Laceration w/o FB of Left Index Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12213,1,4,0)
 ;;=4^S61.211A
 ;;^UTILITY(U,$J,358.3,12213,2)
 ;;=^5032774
 ;;^UTILITY(U,$J,358.3,12214,0)
 ;;=S91.215A^^80^774^20
 ;;^UTILITY(U,$J,358.3,12214,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12214,1,3,0)
 ;;=3^Laceration w/o FB of Left Lesser Toe(s) w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12214,1,4,0)
 ;;=4^S91.215A
 ;;^UTILITY(U,$J,358.3,12214,2)
 ;;=^5044282
 ;;^UTILITY(U,$J,358.3,12215,0)
 ;;=S91.115A^^80^774^21
 ;;^UTILITY(U,$J,358.3,12215,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12215,1,3,0)
 ;;=3^Laceration w/o FB of Left Lesser Toe(s) w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12215,1,4,0)
 ;;=4^S91.115A
 ;;^UTILITY(U,$J,358.3,12215,2)
 ;;=^5044195
 ;;^UTILITY(U,$J,358.3,12216,0)
 ;;=S61.317A^^80^774^22
 ;;^UTILITY(U,$J,358.3,12216,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12216,1,3,0)
 ;;=3^Laceration w/o FB of Left Little Finger w/ Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12216,1,4,0)
 ;;=4^S61.317A
 ;;^UTILITY(U,$J,358.3,12216,2)
 ;;=^5032927
 ;;^UTILITY(U,$J,358.3,12217,0)
 ;;=S61.217A^^80^774^23
 ;;^UTILITY(U,$J,358.3,12217,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,12217,1,3,0)
 ;;=3^Laceration w/o FB of Left Little Finger w/o Nail Damage,Init Encntr
 ;;^UTILITY(U,$J,358.3,12217,1,4,0)
 ;;=4^S61.217A
