IBDEI06D ; ; 09-AUG-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7946,0)
 ;;=S41.151A^^29^437^154
 ;;^UTILITY(U,$J,358.3,7946,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7946,1,3,0)
 ;;=3^Open bite, right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,7946,1,4,0)
 ;;=4^S41.151A
 ;;^UTILITY(U,$J,358.3,7946,2)
 ;;=^5026360
 ;;^UTILITY(U,$J,358.3,7947,0)
 ;;=S41.152A^^29^437^146
 ;;^UTILITY(U,$J,358.3,7947,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7947,1,3,0)
 ;;=3^Open bite, left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,7947,1,4,0)
 ;;=4^S41.152A
 ;;^UTILITY(U,$J,358.3,7947,2)
 ;;=^5026363
 ;;^UTILITY(U,$J,358.3,7948,0)
 ;;=S51.851A^^29^437^149
 ;;^UTILITY(U,$J,358.3,7948,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7948,1,3,0)
 ;;=3^Open bite, right forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,7948,1,4,0)
 ;;=4^S51.851A
 ;;^UTILITY(U,$J,358.3,7948,2)
 ;;=^5028689
 ;;^UTILITY(U,$J,358.3,7949,0)
 ;;=S51.852A^^29^437^141
 ;;^UTILITY(U,$J,358.3,7949,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7949,1,3,0)
 ;;=3^Open bite, left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,7949,1,4,0)
 ;;=4^S51.852A
 ;;^UTILITY(U,$J,358.3,7949,2)
 ;;=^5028692
 ;;^UTILITY(U,$J,358.3,7950,0)
 ;;=S40.861A^^29^437^111
 ;;^UTILITY(U,$J,358.3,7950,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7950,1,3,0)
 ;;=3^Insect bite (nonvenomous) of right upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,7950,1,4,0)
 ;;=4^S40.861A
 ;;^UTILITY(U,$J,358.3,7950,2)
 ;;=^5026261
 ;;^UTILITY(U,$J,358.3,7951,0)
 ;;=S40.862A^^29^437^109
 ;;^UTILITY(U,$J,358.3,7951,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7951,1,3,0)
 ;;=3^Insect bite (nonvenomous) of left upper arm, init encntr
 ;;^UTILITY(U,$J,358.3,7951,1,4,0)
 ;;=4^S40.862A
 ;;^UTILITY(U,$J,358.3,7951,2)
 ;;=^5026264
 ;;^UTILITY(U,$J,358.3,7952,0)
 ;;=S50.861A^^29^437^110
 ;;^UTILITY(U,$J,358.3,7952,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7952,1,3,0)
 ;;=3^Insect bite (nonvenomous) of right forearm, init encntr
 ;;^UTILITY(U,$J,358.3,7952,1,4,0)
 ;;=4^S50.861A
 ;;^UTILITY(U,$J,358.3,7952,2)
 ;;=^5028590
 ;;^UTILITY(U,$J,358.3,7953,0)
 ;;=S50.862A^^29^437^108
 ;;^UTILITY(U,$J,358.3,7953,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7953,1,3,0)
 ;;=3^Insect bite (nonvenomous) of left forearm, initial encounter
 ;;^UTILITY(U,$J,358.3,7953,1,4,0)
 ;;=4^S50.862A
 ;;^UTILITY(U,$J,358.3,7953,2)
 ;;=^5028593
 ;;^UTILITY(U,$J,358.3,7954,0)
 ;;=S91.351A^^29^437^148
 ;;^UTILITY(U,$J,358.3,7954,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7954,1,3,0)
 ;;=3^Open bite, right foot, initial encounter
 ;;^UTILITY(U,$J,358.3,7954,1,4,0)
 ;;=4^S91.351A
 ;;^UTILITY(U,$J,358.3,7954,2)
 ;;=^5044344
 ;;^UTILITY(U,$J,358.3,7955,0)
 ;;=S91.352A^^29^437^140
 ;;^UTILITY(U,$J,358.3,7955,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7955,1,3,0)
 ;;=3^Open bite, left foot, initial encounter
 ;;^UTILITY(U,$J,358.3,7955,1,4,0)
 ;;=4^S91.352A
 ;;^UTILITY(U,$J,358.3,7955,2)
 ;;=^5044347
 ;;^UTILITY(U,$J,358.3,7956,0)
 ;;=S61.451A^^29^437^151
 ;;^UTILITY(U,$J,358.3,7956,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7956,1,3,0)
 ;;=3^Open bite, right hand, initial encounter
 ;;^UTILITY(U,$J,358.3,7956,1,4,0)
 ;;=4^S61.451A
 ;;^UTILITY(U,$J,358.3,7956,2)
 ;;=^5033011
 ;;^UTILITY(U,$J,358.3,7957,0)
 ;;=S61.452A^^29^437^143
 ;;^UTILITY(U,$J,358.3,7957,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7957,1,3,0)
 ;;=3^Open bite, left hand, initial encounter
 ;;^UTILITY(U,$J,358.3,7957,1,4,0)
 ;;=4^S61.452A
 ;;^UTILITY(U,$J,358.3,7957,2)
 ;;=^5033014
 ;;^UTILITY(U,$J,358.3,7958,0)
 ;;=S81.851A^^29^437^153
 ;;^UTILITY(U,$J,358.3,7958,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7958,1,3,0)
 ;;=3^Open bite, right lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,7958,1,4,0)
 ;;=4^S81.851A
 ;;^UTILITY(U,$J,358.3,7958,2)
 ;;=^5040095
 ;;^UTILITY(U,$J,358.3,7959,0)
 ;;=S81.852A^^29^437^145
 ;;^UTILITY(U,$J,358.3,7959,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7959,1,3,0)
 ;;=3^Open bite, left lower leg, initial encounter
 ;;^UTILITY(U,$J,358.3,7959,1,4,0)
 ;;=4^S81.852A
 ;;^UTILITY(U,$J,358.3,7959,2)
 ;;=^5040098
 ;;^UTILITY(U,$J,358.3,7960,0)
 ;;=S91.151A^^29^437^150
 ;;^UTILITY(U,$J,358.3,7960,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7960,1,3,0)
 ;;=3^Open bite, right great toe w/o damage to nail, init encntr
 ;;^UTILITY(U,$J,358.3,7960,1,4,0)
 ;;=4^S91.151A
 ;;^UTILITY(U,$J,358.3,7960,2)
 ;;=^5044243
 ;;^UTILITY(U,$J,358.3,7961,0)
 ;;=S91.152A^^29^437^142
 ;;^UTILITY(U,$J,358.3,7961,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7961,1,3,0)
 ;;=3^Open bite, left great toe w/o damage to nail, init encntr
 ;;^UTILITY(U,$J,358.3,7961,1,4,0)
 ;;=4^S91.152A
 ;;^UTILITY(U,$J,358.3,7961,2)
 ;;=^5044246
 ;;^UTILITY(U,$J,358.3,7962,0)
 ;;=S91.154A^^29^437^152
 ;;^UTILITY(U,$J,358.3,7962,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7962,1,3,0)
 ;;=3^Open bite, right lesser toe(s) w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,7962,1,4,0)
 ;;=4^S91.154A
 ;;^UTILITY(U,$J,358.3,7962,2)
 ;;=^5044252
 ;;^UTILITY(U,$J,358.3,7963,0)
 ;;=S91.155A^^29^437^144
 ;;^UTILITY(U,$J,358.3,7963,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7963,1,3,0)
 ;;=3^Open bite, left lesser toe(s) w/o damage to nail, init
 ;;^UTILITY(U,$J,358.3,7963,1,4,0)
 ;;=4^S91.155A
 ;;^UTILITY(U,$J,358.3,7963,2)
 ;;=^5044255
 ;;^UTILITY(U,$J,358.3,7964,0)
 ;;=S90.425A^^29^437^31
 ;;^UTILITY(U,$J,358.3,7964,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7964,1,3,0)
 ;;=3^Blister (nonthermal), left lesser toe(s), initial encounter
 ;;^UTILITY(U,$J,358.3,7964,1,4,0)
 ;;=4^S90.425A
 ;;^UTILITY(U,$J,358.3,7964,2)
 ;;=^5043919
 ;;^UTILITY(U,$J,358.3,7965,0)
 ;;=T23.121A^^29^437^35
 ;;^UTILITY(U,$J,358.3,7965,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7965,1,3,0)
 ;;=3^Burn first degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,7965,1,4,0)
 ;;=4^T23.121A
 ;;^UTILITY(U,$J,358.3,7965,2)
 ;;=^5047671
 ;;^UTILITY(U,$J,358.3,7966,0)
 ;;=T23.122A^^29^437^34
 ;;^UTILITY(U,$J,358.3,7966,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7966,1,3,0)
 ;;=3^Burn first degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,7966,1,4,0)
 ;;=4^T23.122A
 ;;^UTILITY(U,$J,358.3,7966,2)
 ;;=^5047674
 ;;^UTILITY(U,$J,358.3,7967,0)
 ;;=T23.221A^^29^437^39
 ;;^UTILITY(U,$J,358.3,7967,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7967,1,3,0)
 ;;=3^Burn second degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,7967,1,4,0)
 ;;=4^T23.221A
 ;;^UTILITY(U,$J,358.3,7967,2)
 ;;=^5047749
 ;;^UTILITY(U,$J,358.3,7968,0)
 ;;=T23.222A^^29^437^38
 ;;^UTILITY(U,$J,358.3,7968,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7968,1,3,0)
 ;;=3^Burn second degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,7968,1,4,0)
 ;;=4^T23.222A
 ;;^UTILITY(U,$J,358.3,7968,2)
 ;;=^5047752
 ;;^UTILITY(U,$J,358.3,7969,0)
 ;;=T23.321A^^29^437^43
 ;;^UTILITY(U,$J,358.3,7969,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7969,1,3,0)
 ;;=3^Burn third degree of single r finger except thumb, init
 ;;^UTILITY(U,$J,358.3,7969,1,4,0)
 ;;=4^T23.321A
 ;;^UTILITY(U,$J,358.3,7969,2)
 ;;=^5047827
 ;;^UTILITY(U,$J,358.3,7970,0)
 ;;=T23.322A^^29^437^42
 ;;^UTILITY(U,$J,358.3,7970,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7970,1,3,0)
 ;;=3^Burn third degree of single l finger except thumb, init
 ;;^UTILITY(U,$J,358.3,7970,1,4,0)
 ;;=4^T23.322A
 ;;^UTILITY(U,$J,358.3,7970,2)
 ;;=^5047830
 ;;^UTILITY(U,$J,358.3,7971,0)
 ;;=T23.101A^^29^437^33
 ;;^UTILITY(U,$J,358.3,7971,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7971,1,3,0)
 ;;=3^Burn first degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,7971,1,4,0)
 ;;=4^T23.101A
 ;;^UTILITY(U,$J,358.3,7971,2)
 ;;=^5047656
 ;;^UTILITY(U,$J,358.3,7972,0)
 ;;=T23.102A^^29^437^32
 ;;^UTILITY(U,$J,358.3,7972,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7972,1,3,0)
 ;;=3^Burn first degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,7972,1,4,0)
 ;;=4^T23.102A
 ;;^UTILITY(U,$J,358.3,7972,2)
 ;;=^5047659
 ;;^UTILITY(U,$J,358.3,7973,0)
 ;;=T23.201A^^29^437^37
 ;;^UTILITY(U,$J,358.3,7973,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7973,1,3,0)
 ;;=3^Burn second degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,7973,1,4,0)
 ;;=4^T23.201A
 ;;^UTILITY(U,$J,358.3,7973,2)
 ;;=^5047734
 ;;^UTILITY(U,$J,358.3,7974,0)
 ;;=T23.202A^^29^437^36
 ;;^UTILITY(U,$J,358.3,7974,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7974,1,3,0)
 ;;=3^Burn second degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,7974,1,4,0)
 ;;=4^T23.202A
 ;;^UTILITY(U,$J,358.3,7974,2)
 ;;=^5047737
 ;;^UTILITY(U,$J,358.3,7975,0)
 ;;=T23.301A^^29^437^41
 ;;^UTILITY(U,$J,358.3,7975,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7975,1,3,0)
 ;;=3^Burn third degree of right hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,7975,1,4,0)
 ;;=4^T23.301A
 ;;^UTILITY(U,$J,358.3,7975,2)
 ;;=^5047812
 ;;^UTILITY(U,$J,358.3,7976,0)
 ;;=T23.302A^^29^437^40
 ;;^UTILITY(U,$J,358.3,7976,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7976,1,3,0)
 ;;=3^Burn third degree of left hand, unsp site, init encntr
 ;;^UTILITY(U,$J,358.3,7976,1,4,0)
 ;;=4^T23.302A
 ;;^UTILITY(U,$J,358.3,7976,2)
 ;;=^5047815
 ;;^UTILITY(U,$J,358.3,7977,0)
 ;;=T79.A11A^^29^437^248
 ;;^UTILITY(U,$J,358.3,7977,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7977,1,3,0)
 ;;=3^Traumatic compartment syndrome of right upper extrem, init
 ;;^UTILITY(U,$J,358.3,7977,1,4,0)
 ;;=4^T79.A11A
 ;;^UTILITY(U,$J,358.3,7977,2)
 ;;=^5054326
 ;;^UTILITY(U,$J,358.3,7978,0)
 ;;=T79.A12A^^29^437^247
 ;;^UTILITY(U,$J,358.3,7978,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7978,1,3,0)
 ;;=3^Traumatic compartment syndrome of left upper extremity, init
 ;;^UTILITY(U,$J,358.3,7978,1,4,0)
 ;;=4^T79.A12A
 ;;^UTILITY(U,$J,358.3,7978,2)
 ;;=^5054329
 ;;^UTILITY(U,$J,358.3,7979,0)
 ;;=S06.0X9A^^29^437^44
