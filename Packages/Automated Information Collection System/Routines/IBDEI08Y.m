IBDEI08Y ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8909,1,3,0)
 ;;=3^Abrasion,Right ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,8909,1,4,0)
 ;;=4^S90.511A
 ;;^UTILITY(U,$J,358.3,8909,2)
 ;;=^5043997
 ;;^UTILITY(U,$J,358.3,8910,0)
 ;;=S90.512A^^45^533^1
 ;;^UTILITY(U,$J,358.3,8910,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8910,1,3,0)
 ;;=3^Abrasion,Left ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,8910,1,4,0)
 ;;=4^S90.512A
 ;;^UTILITY(U,$J,358.3,8910,2)
 ;;=^5044000
 ;;^UTILITY(U,$J,358.3,8911,0)
 ;;=S40.811A^^45^533^28
 ;;^UTILITY(U,$J,358.3,8911,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8911,1,3,0)
 ;;=3^Abrasion,Right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,8911,1,4,0)
 ;;=4^S40.811A
 ;;^UTILITY(U,$J,358.3,8911,2)
 ;;=^5026225
 ;;^UTILITY(U,$J,358.3,8912,0)
 ;;=S40.812A^^45^533^13
 ;;^UTILITY(U,$J,358.3,8912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8912,1,3,0)
 ;;=3^Abrasion,Left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,8912,1,4,0)
 ;;=4^S40.812A
 ;;^UTILITY(U,$J,358.3,8912,2)
 ;;=^5026228
 ;;^UTILITY(U,$J,358.3,8913,0)
 ;;=S05.01XA^^45^533^46
 ;;^UTILITY(U,$J,358.3,8913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8913,1,3,0)
 ;;=3^Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init Enctr
 ;;^UTILITY(U,$J,358.3,8913,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,8913,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,8914,0)
 ;;=S05.02XA^^45^533^45
 ;;^UTILITY(U,$J,358.3,8914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8914,1,3,0)
 ;;=3^Conjuctiva/Corneal Abrasion w/o FB,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,8914,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,8914,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,8915,0)
 ;;=S50.311A^^45^533^17
 ;;^UTILITY(U,$J,358.3,8915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8915,1,3,0)
 ;;=3^Abrasion,Right elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,8915,1,4,0)
 ;;=4^S50.311A
 ;;^UTILITY(U,$J,358.3,8915,2)
 ;;=^5028500
 ;;^UTILITY(U,$J,358.3,8916,0)
 ;;=S50.312A^^45^533^2
 ;;^UTILITY(U,$J,358.3,8916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8916,1,3,0)
 ;;=3^Abrasion,Left elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,8916,1,4,0)
 ;;=4^S50.312A
 ;;^UTILITY(U,$J,358.3,8916,2)
 ;;=^5028503
 ;;^UTILITY(U,$J,358.3,8917,0)
 ;;=S00.81XA^^45^533^15
 ;;^UTILITY(U,$J,358.3,8917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8917,1,3,0)
 ;;=3^Abrasion,Other part of head, initial encounter
 ;;^UTILITY(U,$J,358.3,8917,1,4,0)
 ;;=4^S00.81XA
 ;;^UTILITY(U,$J,358.3,8917,2)
 ;;=^5019988
 ;;^UTILITY(U,$J,358.3,8918,0)
 ;;=S90.811A^^45^533^18
 ;;^UTILITY(U,$J,358.3,8918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8918,1,3,0)
 ;;=3^Abrasion,Right foot, initial encounter
 ;;^UTILITY(U,$J,358.3,8918,1,4,0)
 ;;=4^S90.811A
 ;;^UTILITY(U,$J,358.3,8918,2)
 ;;=^5044051
 ;;^UTILITY(U,$J,358.3,8919,0)
 ;;=S90.812A^^45^533^3
 ;;^UTILITY(U,$J,358.3,8919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8919,1,3,0)
 ;;=3^Abrasion,Left foot, initial encounter
 ;;^UTILITY(U,$J,358.3,8919,1,4,0)
 ;;=4^S90.812A
 ;;^UTILITY(U,$J,358.3,8919,2)
 ;;=^5044054
 ;;^UTILITY(U,$J,358.3,8920,0)
 ;;=S90.411A^^45^533^20
 ;;^UTILITY(U,$J,358.3,8920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8920,1,3,0)
 ;;=3^Abrasion,Right great toe, initial encounter
 ;;^UTILITY(U,$J,358.3,8920,1,4,0)
 ;;=4^S90.411A
 ;;^UTILITY(U,$J,358.3,8920,2)
 ;;=^5043889
 ;;^UTILITY(U,$J,358.3,8921,0)
 ;;=S90.412A^^45^533^5
 ;;^UTILITY(U,$J,358.3,8921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8921,1,3,0)
 ;;=3^Abrasion,Left great toe, initial encounter
 ;;^UTILITY(U,$J,358.3,8921,1,4,0)
 ;;=4^S90.412A
 ;;^UTILITY(U,$J,358.3,8921,2)
 ;;=^5043892
 ;;^UTILITY(U,$J,358.3,8922,0)
 ;;=S90.414A^^45^533^23
 ;;^UTILITY(U,$J,358.3,8922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8922,1,3,0)
 ;;=3^Abrasion,Right lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,8922,1,4,0)
 ;;=4^S90.414A
 ;;^UTILITY(U,$J,358.3,8922,2)
 ;;=^5043898
 ;;^UTILITY(U,$J,358.3,8923,0)
 ;;=S90.415A^^45^533^8
 ;;^UTILITY(U,$J,358.3,8923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8923,1,3,0)
 ;;=3^Abrasion,Left lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,8923,1,4,0)
 ;;=4^S90.415A
 ;;^UTILITY(U,$J,358.3,8923,2)
 ;;=^5043901
 ;;^UTILITY(U,$J,358.3,8924,0)
 ;;=S50.811A^^45^533^19
 ;;^UTILITY(U,$J,358.3,8924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8924,1,3,0)
 ;;=3^Abrasion,Right forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,8924,1,4,0)
 ;;=4^S50.811A
 ;;^UTILITY(U,$J,358.3,8924,2)
 ;;=^5028554
 ;;^UTILITY(U,$J,358.3,8925,0)
 ;;=S50.812A^^45^533^4
 ;;^UTILITY(U,$J,358.3,8925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8925,1,3,0)
 ;;=3^Abrasion,Left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,8925,1,4,0)
 ;;=4^S50.812A
 ;;^UTILITY(U,$J,358.3,8925,2)
 ;;=^5028557
 ;;^UTILITY(U,$J,358.3,8926,0)
 ;;=S60.511A^^45^533^21
 ;;^UTILITY(U,$J,358.3,8926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8926,1,3,0)
 ;;=3^Abrasion,Right hand, initial encounter
 ;;^UTILITY(U,$J,358.3,8926,1,4,0)
 ;;=4^S60.511A
 ;;^UTILITY(U,$J,358.3,8926,2)
 ;;=^5032528
 ;;^UTILITY(U,$J,358.3,8927,0)
 ;;=S60.512A^^45^533^6
 ;;^UTILITY(U,$J,358.3,8927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8927,1,3,0)
 ;;=3^Abrasion,Left hand, initial encounter
 ;;^UTILITY(U,$J,358.3,8927,1,4,0)
 ;;=4^S60.512A
 ;;^UTILITY(U,$J,358.3,8927,2)
 ;;=^5032531
 ;;^UTILITY(U,$J,358.3,8928,0)
 ;;=S80.211A^^45^533^22
 ;;^UTILITY(U,$J,358.3,8928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8928,1,3,0)
 ;;=3^Abrasion,Right knee, initial encounter
 ;;^UTILITY(U,$J,358.3,8928,1,4,0)
 ;;=4^S80.211A
 ;;^UTILITY(U,$J,358.3,8928,2)
 ;;=^5039906
 ;;^UTILITY(U,$J,358.3,8929,0)
 ;;=S80.212A^^45^533^7
 ;;^UTILITY(U,$J,358.3,8929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8929,1,3,0)
 ;;=3^Abrasion,Left knee, initial encounter
 ;;^UTILITY(U,$J,358.3,8929,1,4,0)
 ;;=4^S80.212A
 ;;^UTILITY(U,$J,358.3,8929,2)
 ;;=^5039909
 ;;^UTILITY(U,$J,358.3,8930,0)
 ;;=S80.811A^^45^533^24
 ;;^UTILITY(U,$J,358.3,8930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8930,1,3,0)
 ;;=3^Abrasion,Right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,8930,1,4,0)
 ;;=4^S80.811A
 ;;^UTILITY(U,$J,358.3,8930,2)
 ;;=^5039960
 ;;^UTILITY(U,$J,358.3,8931,0)
 ;;=S80.812A^^45^533^9
 ;;^UTILITY(U,$J,358.3,8931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8931,1,3,0)
 ;;=3^Abrasion,Left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,8931,1,4,0)
 ;;=4^S80.812A
 ;;^UTILITY(U,$J,358.3,8931,2)
 ;;=^5039963
 ;;^UTILITY(U,$J,358.3,8932,0)
 ;;=S40.211A^^45^533^25
 ;;^UTILITY(U,$J,358.3,8932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8932,1,3,0)
 ;;=3^Abrasion,Right shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,8932,1,4,0)
 ;;=4^S40.211A
 ;;^UTILITY(U,$J,358.3,8932,2)
 ;;=^5026171
 ;;^UTILITY(U,$J,358.3,8933,0)
 ;;=S40.212A^^45^533^10
 ;;^UTILITY(U,$J,358.3,8933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8933,1,3,0)
 ;;=3^Abrasion,Left shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,8933,1,4,0)
 ;;=4^S40.212A
 ;;^UTILITY(U,$J,358.3,8933,2)
 ;;=^5026174
 ;;^UTILITY(U,$J,358.3,8934,0)
 ;;=S70.311A^^45^533^26
 ;;^UTILITY(U,$J,358.3,8934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8934,1,3,0)
 ;;=3^Abrasion,Right thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,8934,1,4,0)
 ;;=4^S70.311A
 ;;^UTILITY(U,$J,358.3,8934,2)
 ;;=^5036903
 ;;^UTILITY(U,$J,358.3,8935,0)
 ;;=S70.312A^^45^533^11
 ;;^UTILITY(U,$J,358.3,8935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8935,1,3,0)
 ;;=3^Abrasion,Left thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,8935,1,4,0)
 ;;=4^S70.312A
 ;;^UTILITY(U,$J,358.3,8935,2)
 ;;=^5036906
 ;;^UTILITY(U,$J,358.3,8936,0)
 ;;=S60.311A^^45^533^27
 ;;^UTILITY(U,$J,358.3,8936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8936,1,3,0)
 ;;=3^Abrasion,Right thumb, initial encounter
