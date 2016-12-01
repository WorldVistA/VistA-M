IBDEI06C ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7911,1,3,0)
 ;;=3^Abrasion,Right ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,7911,1,4,0)
 ;;=4^S90.511A
 ;;^UTILITY(U,$J,358.3,7911,2)
 ;;=^5043997
 ;;^UTILITY(U,$J,358.3,7912,0)
 ;;=S90.512A^^29^437^1
 ;;^UTILITY(U,$J,358.3,7912,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7912,1,3,0)
 ;;=3^Abrasion,Left ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,7912,1,4,0)
 ;;=4^S90.512A
 ;;^UTILITY(U,$J,358.3,7912,2)
 ;;=^5044000
 ;;^UTILITY(U,$J,358.3,7913,0)
 ;;=S40.811A^^29^437^28
 ;;^UTILITY(U,$J,358.3,7913,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7913,1,3,0)
 ;;=3^Abrasion,Right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,7913,1,4,0)
 ;;=4^S40.811A
 ;;^UTILITY(U,$J,358.3,7913,2)
 ;;=^5026225
 ;;^UTILITY(U,$J,358.3,7914,0)
 ;;=S40.812A^^29^437^13
 ;;^UTILITY(U,$J,358.3,7914,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7914,1,3,0)
 ;;=3^Abrasion,Left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,7914,1,4,0)
 ;;=4^S40.812A
 ;;^UTILITY(U,$J,358.3,7914,2)
 ;;=^5026228
 ;;^UTILITY(U,$J,358.3,7915,0)
 ;;=S05.01XA^^29^437^46
 ;;^UTILITY(U,$J,358.3,7915,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7915,1,3,0)
 ;;=3^Conjunctiva/Corneal Abrasion w/o FB,Right Eye,Init Enctr
 ;;^UTILITY(U,$J,358.3,7915,1,4,0)
 ;;=4^S05.01XA
 ;;^UTILITY(U,$J,358.3,7915,2)
 ;;=^5020579
 ;;^UTILITY(U,$J,358.3,7916,0)
 ;;=S05.02XA^^29^437^45
 ;;^UTILITY(U,$J,358.3,7916,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7916,1,3,0)
 ;;=3^Conjuctiva/Corneal Abrasion w/o FB,Left Eye,Init Encntr
 ;;^UTILITY(U,$J,358.3,7916,1,4,0)
 ;;=4^S05.02XA
 ;;^UTILITY(U,$J,358.3,7916,2)
 ;;=^5020582
 ;;^UTILITY(U,$J,358.3,7917,0)
 ;;=S50.311A^^29^437^17
 ;;^UTILITY(U,$J,358.3,7917,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7917,1,3,0)
 ;;=3^Abrasion,Right elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,7917,1,4,0)
 ;;=4^S50.311A
 ;;^UTILITY(U,$J,358.3,7917,2)
 ;;=^5028500
 ;;^UTILITY(U,$J,358.3,7918,0)
 ;;=S50.312A^^29^437^2
 ;;^UTILITY(U,$J,358.3,7918,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7918,1,3,0)
 ;;=3^Abrasion,Left elbow, initial encounter
 ;;^UTILITY(U,$J,358.3,7918,1,4,0)
 ;;=4^S50.312A
 ;;^UTILITY(U,$J,358.3,7918,2)
 ;;=^5028503
 ;;^UTILITY(U,$J,358.3,7919,0)
 ;;=S00.81XA^^29^437^15
 ;;^UTILITY(U,$J,358.3,7919,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7919,1,3,0)
 ;;=3^Abrasion,Other part of head, initial encounter
 ;;^UTILITY(U,$J,358.3,7919,1,4,0)
 ;;=4^S00.81XA
 ;;^UTILITY(U,$J,358.3,7919,2)
 ;;=^5019988
 ;;^UTILITY(U,$J,358.3,7920,0)
 ;;=S90.811A^^29^437^18
 ;;^UTILITY(U,$J,358.3,7920,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7920,1,3,0)
 ;;=3^Abrasion,Right foot, initial encounter
 ;;^UTILITY(U,$J,358.3,7920,1,4,0)
 ;;=4^S90.811A
 ;;^UTILITY(U,$J,358.3,7920,2)
 ;;=^5044051
 ;;^UTILITY(U,$J,358.3,7921,0)
 ;;=S90.812A^^29^437^3
 ;;^UTILITY(U,$J,358.3,7921,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7921,1,3,0)
 ;;=3^Abrasion,Left foot, initial encounter
 ;;^UTILITY(U,$J,358.3,7921,1,4,0)
 ;;=4^S90.812A
 ;;^UTILITY(U,$J,358.3,7921,2)
 ;;=^5044054
 ;;^UTILITY(U,$J,358.3,7922,0)
 ;;=S90.411A^^29^437^20
 ;;^UTILITY(U,$J,358.3,7922,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7922,1,3,0)
 ;;=3^Abrasion,Right great toe, initial encounter
 ;;^UTILITY(U,$J,358.3,7922,1,4,0)
 ;;=4^S90.411A
 ;;^UTILITY(U,$J,358.3,7922,2)
 ;;=^5043889
 ;;^UTILITY(U,$J,358.3,7923,0)
 ;;=S90.412A^^29^437^5
 ;;^UTILITY(U,$J,358.3,7923,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7923,1,3,0)
 ;;=3^Abrasion,Left great toe, initial encounter
 ;;^UTILITY(U,$J,358.3,7923,1,4,0)
 ;;=4^S90.412A
 ;;^UTILITY(U,$J,358.3,7923,2)
 ;;=^5043892
 ;;^UTILITY(U,$J,358.3,7924,0)
 ;;=S90.414A^^29^437^23
 ;;^UTILITY(U,$J,358.3,7924,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7924,1,3,0)
 ;;=3^Abrasion,Right lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,7924,1,4,0)
 ;;=4^S90.414A
 ;;^UTILITY(U,$J,358.3,7924,2)
 ;;=^5043898
 ;;^UTILITY(U,$J,358.3,7925,0)
 ;;=S90.415A^^29^437^8
 ;;^UTILITY(U,$J,358.3,7925,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7925,1,3,0)
 ;;=3^Abrasion,Left lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,7925,1,4,0)
 ;;=4^S90.415A
 ;;^UTILITY(U,$J,358.3,7925,2)
 ;;=^5043901
 ;;^UTILITY(U,$J,358.3,7926,0)
 ;;=S50.811A^^29^437^19
 ;;^UTILITY(U,$J,358.3,7926,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7926,1,3,0)
 ;;=3^Abrasion,Right forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,7926,1,4,0)
 ;;=4^S50.811A
 ;;^UTILITY(U,$J,358.3,7926,2)
 ;;=^5028554
 ;;^UTILITY(U,$J,358.3,7927,0)
 ;;=S50.812A^^29^437^4
 ;;^UTILITY(U,$J,358.3,7927,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7927,1,3,0)
 ;;=3^Abrasion,Left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,7927,1,4,0)
 ;;=4^S50.812A
 ;;^UTILITY(U,$J,358.3,7927,2)
 ;;=^5028557
 ;;^UTILITY(U,$J,358.3,7928,0)
 ;;=S60.511A^^29^437^21
 ;;^UTILITY(U,$J,358.3,7928,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7928,1,3,0)
 ;;=3^Abrasion,Right hand, initial encounter
 ;;^UTILITY(U,$J,358.3,7928,1,4,0)
 ;;=4^S60.511A
 ;;^UTILITY(U,$J,358.3,7928,2)
 ;;=^5032528
 ;;^UTILITY(U,$J,358.3,7929,0)
 ;;=S60.512A^^29^437^6
 ;;^UTILITY(U,$J,358.3,7929,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7929,1,3,0)
 ;;=3^Abrasion,Left hand, initial encounter
 ;;^UTILITY(U,$J,358.3,7929,1,4,0)
 ;;=4^S60.512A
 ;;^UTILITY(U,$J,358.3,7929,2)
 ;;=^5032531
 ;;^UTILITY(U,$J,358.3,7930,0)
 ;;=S80.211A^^29^437^22
 ;;^UTILITY(U,$J,358.3,7930,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7930,1,3,0)
 ;;=3^Abrasion,Right knee, initial encounter
 ;;^UTILITY(U,$J,358.3,7930,1,4,0)
 ;;=4^S80.211A
 ;;^UTILITY(U,$J,358.3,7930,2)
 ;;=^5039906
 ;;^UTILITY(U,$J,358.3,7931,0)
 ;;=S80.212A^^29^437^7
 ;;^UTILITY(U,$J,358.3,7931,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7931,1,3,0)
 ;;=3^Abrasion,Left knee, initial encounter
 ;;^UTILITY(U,$J,358.3,7931,1,4,0)
 ;;=4^S80.212A
 ;;^UTILITY(U,$J,358.3,7931,2)
 ;;=^5039909
 ;;^UTILITY(U,$J,358.3,7932,0)
 ;;=S80.811A^^29^437^24
 ;;^UTILITY(U,$J,358.3,7932,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7932,1,3,0)
 ;;=3^Abrasion,Right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,7932,1,4,0)
 ;;=4^S80.811A
 ;;^UTILITY(U,$J,358.3,7932,2)
 ;;=^5039960
 ;;^UTILITY(U,$J,358.3,7933,0)
 ;;=S80.812A^^29^437^9
 ;;^UTILITY(U,$J,358.3,7933,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7933,1,3,0)
 ;;=3^Abrasion,Left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,7933,1,4,0)
 ;;=4^S80.812A
 ;;^UTILITY(U,$J,358.3,7933,2)
 ;;=^5039963
 ;;^UTILITY(U,$J,358.3,7934,0)
 ;;=S40.211A^^29^437^25
 ;;^UTILITY(U,$J,358.3,7934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7934,1,3,0)
 ;;=3^Abrasion,Right shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,7934,1,4,0)
 ;;=4^S40.211A
 ;;^UTILITY(U,$J,358.3,7934,2)
 ;;=^5026171
 ;;^UTILITY(U,$J,358.3,7935,0)
 ;;=S40.212A^^29^437^10
 ;;^UTILITY(U,$J,358.3,7935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7935,1,3,0)
 ;;=3^Abrasion,Left shoulder, initial encounter
 ;;^UTILITY(U,$J,358.3,7935,1,4,0)
 ;;=4^S40.212A
 ;;^UTILITY(U,$J,358.3,7935,2)
 ;;=^5026174
 ;;^UTILITY(U,$J,358.3,7936,0)
 ;;=S70.311A^^29^437^26
 ;;^UTILITY(U,$J,358.3,7936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7936,1,3,0)
 ;;=3^Abrasion,Right thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,7936,1,4,0)
 ;;=4^S70.311A
 ;;^UTILITY(U,$J,358.3,7936,2)
 ;;=^5036903
 ;;^UTILITY(U,$J,358.3,7937,0)
 ;;=S70.312A^^29^437^11
 ;;^UTILITY(U,$J,358.3,7937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7937,1,3,0)
 ;;=3^Abrasion,Left thigh, initial encounter
 ;;^UTILITY(U,$J,358.3,7937,1,4,0)
 ;;=4^S70.312A
 ;;^UTILITY(U,$J,358.3,7937,2)
 ;;=^5036906
 ;;^UTILITY(U,$J,358.3,7938,0)
 ;;=S60.311A^^29^437^27
 ;;^UTILITY(U,$J,358.3,7938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7938,1,3,0)
 ;;=3^Abrasion,Right thumb, initial encounter
 ;;^UTILITY(U,$J,358.3,7938,1,4,0)
 ;;=4^S60.311A
 ;;^UTILITY(U,$J,358.3,7938,2)
 ;;=^5032285
 ;;^UTILITY(U,$J,358.3,7939,0)
 ;;=S60.312A^^29^437^12
 ;;^UTILITY(U,$J,358.3,7939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7939,1,3,0)
 ;;=3^Abrasion,Left thumb, initial encounter
 ;;^UTILITY(U,$J,358.3,7939,1,4,0)
 ;;=4^S60.312A
 ;;^UTILITY(U,$J,358.3,7939,2)
 ;;=^5032288
 ;;^UTILITY(U,$J,358.3,7940,0)
 ;;=S60.811A^^29^437^29
 ;;^UTILITY(U,$J,358.3,7940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7940,1,3,0)
 ;;=3^Abrasion,Right wrist, initial encounter
 ;;^UTILITY(U,$J,358.3,7940,1,4,0)
 ;;=4^S60.811A
 ;;^UTILITY(U,$J,358.3,7940,2)
 ;;=^5032582
 ;;^UTILITY(U,$J,358.3,7941,0)
 ;;=S60.812A^^29^437^14
 ;;^UTILITY(U,$J,358.3,7941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7941,1,3,0)
 ;;=3^Abrasion,Left wrist, initial encounter
 ;;^UTILITY(U,$J,358.3,7941,1,4,0)
 ;;=4^S60.812A
 ;;^UTILITY(U,$J,358.3,7941,2)
 ;;=^5032585
 ;;^UTILITY(U,$J,358.3,7942,0)
 ;;=T78.3XXA^^29^437^30
 ;;^UTILITY(U,$J,358.3,7942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7942,1,3,0)
 ;;=3^Angioneurotic edema, initial encounter
 ;;^UTILITY(U,$J,358.3,7942,1,4,0)
 ;;=4^T78.3XXA
 ;;^UTILITY(U,$J,358.3,7942,2)
 ;;=^5054281
 ;;^UTILITY(U,$J,358.3,7943,0)
 ;;=T63.441A^^29^437^246
 ;;^UTILITY(U,$J,358.3,7943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7943,1,3,0)
 ;;=3^Toxic effect of venom of bees, accidental, init
 ;;^UTILITY(U,$J,358.3,7943,1,4,0)
 ;;=4^T63.441A
 ;;^UTILITY(U,$J,358.3,7943,2)
 ;;=^5053522
 ;;^UTILITY(U,$J,358.3,7944,0)
 ;;=S91.051A^^29^437^147
 ;;^UTILITY(U,$J,358.3,7944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7944,1,3,0)
 ;;=3^Open bite, right ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,7944,1,4,0)
 ;;=4^S91.051A
 ;;^UTILITY(U,$J,358.3,7944,2)
 ;;=^5044159
 ;;^UTILITY(U,$J,358.3,7945,0)
 ;;=S91.052A^^29^437^139
 ;;^UTILITY(U,$J,358.3,7945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7945,1,3,0)
 ;;=3^Open bite, left ankle, initial encounter
 ;;^UTILITY(U,$J,358.3,7945,1,4,0)
 ;;=4^S91.052A
 ;;^UTILITY(U,$J,358.3,7945,2)
 ;;=^5044162
