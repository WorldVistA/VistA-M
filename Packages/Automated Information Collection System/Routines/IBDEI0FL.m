IBDEI0FL ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7540,1,5,0)
 ;;=5^Nausea & vomiting
 ;;^UTILITY(U,$J,358.3,7540,2)
 ;;=nausea and vomiting^81644
 ;;^UTILITY(U,$J,358.3,7541,0)
 ;;=787.03^^55^583^155
 ;;^UTILITY(U,$J,358.3,7541,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7541,1,4,0)
 ;;=4^787.03
 ;;^UTILITY(U,$J,358.3,7541,1,5,0)
 ;;=5^Vomiting Alone
 ;;^UTILITY(U,$J,358.3,7541,2)
 ;;=Vomiting Alone^127237
 ;;^UTILITY(U,$J,358.3,7542,0)
 ;;=784.8^^55^583^29
 ;;^UTILITY(U,$J,358.3,7542,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7542,1,4,0)
 ;;=4^784.8
 ;;^UTILITY(U,$J,358.3,7542,1,5,0)
 ;;=5^Bleeding from throat
 ;;^UTILITY(U,$J,358.3,7542,2)
 ;;=^273371
 ;;^UTILITY(U,$J,358.3,7543,0)
 ;;=525.9^^55^583^47
 ;;^UTILITY(U,$J,358.3,7543,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7543,1,4,0)
 ;;=4^525.9
 ;;^UTILITY(U,$J,358.3,7543,1,5,0)
 ;;=5^Dental Pain
 ;;^UTILITY(U,$J,358.3,7543,2)
 ;;=Dental Pain^123871
 ;;^UTILITY(U,$J,358.3,7544,0)
 ;;=784.7^^55^583^69
 ;;^UTILITY(U,$J,358.3,7544,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7544,1,4,0)
 ;;=4^784.7
 ;;^UTILITY(U,$J,358.3,7544,1,5,0)
 ;;=5^Epistaxis
 ;;^UTILITY(U,$J,358.3,7544,2)
 ;;=Epistaxis^41658
 ;;^UTILITY(U,$J,358.3,7545,0)
 ;;=784.0^^55^583^79
 ;;^UTILITY(U,$J,358.3,7545,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7545,1,4,0)
 ;;=4^784.0
 ;;^UTILITY(U,$J,358.3,7545,1,5,0)
 ;;=5^Headache
 ;;^UTILITY(U,$J,358.3,7545,2)
 ;;=Headache^54133
 ;;^UTILITY(U,$J,358.3,7546,0)
 ;;=784.2^^55^583^108
 ;;^UTILITY(U,$J,358.3,7546,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7546,1,4,0)
 ;;=4^784.2
 ;;^UTILITY(U,$J,358.3,7546,1,5,0)
 ;;=5^Mass or Lump in Head/Neck
 ;;^UTILITY(U,$J,358.3,7546,2)
 ;;=Mass or Lump in Head/Neck^273367
 ;;^UTILITY(U,$J,358.3,7547,0)
 ;;=784.1^^55^583^149
 ;;^UTILITY(U,$J,358.3,7547,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7547,1,4,0)
 ;;=4^784.1
 ;;^UTILITY(U,$J,358.3,7547,1,5,0)
 ;;=5^Throat Pain
 ;;^UTILITY(U,$J,358.3,7547,2)
 ;;=Throat Pain^276881
 ;;^UTILITY(U,$J,358.3,7548,0)
 ;;=781.0^^55^583^12
 ;;^UTILITY(U,$J,358.3,7548,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7548,1,4,0)
 ;;=4^781.0
 ;;^UTILITY(U,$J,358.3,7548,1,5,0)
 ;;=5^Abnormal Involuntary Movement
 ;;^UTILITY(U,$J,358.3,7548,2)
 ;;=Abnormal Involuntary MMovement^23827
 ;;^UTILITY(U,$J,358.3,7549,0)
 ;;=781.2^^55^583^16
 ;;^UTILITY(U,$J,358.3,7549,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7549,1,4,0)
 ;;=4^781.2
 ;;^UTILITY(U,$J,358.3,7549,1,5,0)
 ;;=5^Abnormality of Gait
 ;;^UTILITY(U,$J,358.3,7549,2)
 ;;=^48820
 ;;^UTILITY(U,$J,358.3,7550,0)
 ;;=305.00^^55^583^19
 ;;^UTILITY(U,$J,358.3,7550,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7550,1,4,0)
 ;;=4^305.00
 ;;^UTILITY(U,$J,358.3,7550,1,5,0)
 ;;=5^Alcohol Abuse, unsp
 ;;^UTILITY(U,$J,358.3,7550,2)
 ;;=^268227
 ;;^UTILITY(U,$J,358.3,7551,0)
 ;;=784.3^^55^583^25
 ;;^UTILITY(U,$J,358.3,7551,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7551,1,4,0)
 ;;=4^784.3
 ;;^UTILITY(U,$J,358.3,7551,1,5,0)
 ;;=5^Aphasia
 ;;^UTILITY(U,$J,358.3,7551,2)
 ;;=Aphasia^9453
 ;;^UTILITY(U,$J,358.3,7552,0)
 ;;=781.3^^55^583^102
 ;;^UTILITY(U,$J,358.3,7552,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7552,1,4,0)
 ;;=4^781.3
 ;;^UTILITY(U,$J,358.3,7552,1,5,0)
 ;;=5^Lack of Coordination
 ;;^UTILITY(U,$J,358.3,7552,2)
 ;;=^11172
 ;;^UTILITY(U,$J,358.3,7553,0)
 ;;=733.6^^55^583^44
 ;;^UTILITY(U,$J,358.3,7553,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,7553,1,4,0)
 ;;=4^733.6
 ;;^UTILITY(U,$J,358.3,7553,1,5,0)
 ;;=5^Costochondritis
 ;;^UTILITY(U,$J,358.3,7553,2)
 ;;=Costochondritis^119586
 ;;^UTILITY(U,$J,358.3,7554,0)
 ;;=311.^^55^583^48
 ;;^UTILITY(U,$J,358.3,7554,1,0)
 ;;=^358.31IA^5^2
