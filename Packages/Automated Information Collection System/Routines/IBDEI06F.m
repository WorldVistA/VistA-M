IBDEI06F ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8458,1,5,0)
 ;;=5^Abdominal Pain, Llq
 ;;^UTILITY(U,$J,358.3,8458,2)
 ;;=^303321
 ;;^UTILITY(U,$J,358.3,8459,0)
 ;;=789.06^^62^470^8
 ;;^UTILITY(U,$J,358.3,8459,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8459,1,4,0)
 ;;=4^789.06
 ;;^UTILITY(U,$J,358.3,8459,1,5,0)
 ;;=5^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,8459,2)
 ;;=Epigastric Pain^303323
 ;;^UTILITY(U,$J,358.3,8460,0)
 ;;=789.07^^62^470^1
 ;;^UTILITY(U,$J,358.3,8460,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8460,1,4,0)
 ;;=4^789.07
 ;;^UTILITY(U,$J,358.3,8460,1,5,0)
 ;;=5^Abdominal Pain, Generalized
 ;;^UTILITY(U,$J,358.3,8460,2)
 ;;=^303324
 ;;^UTILITY(U,$J,358.3,8461,0)
 ;;=788.0^^62^470^13
 ;;^UTILITY(U,$J,358.3,8461,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8461,1,4,0)
 ;;=4^788.0
 ;;^UTILITY(U,$J,358.3,8461,1,5,0)
 ;;=5^Kidney Pain
 ;;^UTILITY(U,$J,358.3,8461,2)
 ;;=^265306
 ;;^UTILITY(U,$J,358.3,8462,0)
 ;;=V68.1^^62^471^4
 ;;^UTILITY(U,$J,358.3,8462,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8462,1,4,0)
 ;;=4^V68.1
 ;;^UTILITY(U,$J,358.3,8462,1,5,0)
 ;;=5^Rx Refill (Also Mark Condition)
 ;;^UTILITY(U,$J,358.3,8462,2)
 ;;=RX Refill (also mark Condition)^295585
 ;;^UTILITY(U,$J,358.3,8463,0)
 ;;=V68.81^^62^471^5
 ;;^UTILITY(U,$J,358.3,8463,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8463,1,4,0)
 ;;=4^V68.81
 ;;^UTILITY(U,$J,358.3,8463,1,5,0)
 ;;=5^Transfer Of Care (Also Mark Conditions)
 ;;^UTILITY(U,$J,358.3,8463,2)
 ;;=Transfer of Care ^295587
 ;;^UTILITY(U,$J,358.3,8464,0)
 ;;=V58.83^^62^471^1
 ;;^UTILITY(U,$J,358.3,8464,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8464,1,4,0)
 ;;=4^V58.83
 ;;^UTILITY(U,$J,358.3,8464,1,5,0)
 ;;=5^Encounter For Therapeutic Drug Monitoring
 ;;^UTILITY(U,$J,358.3,8464,2)
 ;;=Encounter for Therapeutic Drug Monitoring^322076
 ;;^UTILITY(U,$J,358.3,8465,0)
 ;;=V68.09^^62^471^3
 ;;^UTILITY(U,$J,358.3,8465,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8465,1,4,0)
 ;;=4^V68.09
 ;;^UTILITY(U,$J,358.3,8465,1,5,0)
 ;;=5^Issue Of Med Certif Nec
 ;;^UTILITY(U,$J,358.3,8465,2)
 ;;=^335321
 ;;^UTILITY(U,$J,358.3,8466,0)
 ;;=V60.89^^62^471^2
 ;;^UTILITY(U,$J,358.3,8466,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8466,1,4,0)
 ;;=4^V60.89
 ;;^UTILITY(U,$J,358.3,8466,1,5,0)
 ;;=5^Housing/Econo Needs NEC
 ;;^UTILITY(U,$J,358.3,8466,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,8467,0)
 ;;=E880.1^^62^472^14
 ;;^UTILITY(U,$J,358.3,8467,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8467,1,4,0)
 ;;=4^E880.1
 ;;^UTILITY(U,$J,358.3,8467,1,5,0)
 ;;=5^Fall On/From Sidewalk Or Curb
 ;;^UTILITY(U,$J,358.3,8467,2)
 ;;=Fall on/from Sidewalk or Curb^303367
 ;;^UTILITY(U,$J,358.3,8468,0)
 ;;=E881.0^^62^472^6
 ;;^UTILITY(U,$J,358.3,8468,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8468,1,4,0)
 ;;=4^E881.0
 ;;^UTILITY(U,$J,358.3,8468,1,5,0)
 ;;=5^Fall From Ladder
 ;;^UTILITY(U,$J,358.3,8468,2)
 ;;=Fall From Ladder^294644
 ;;^UTILITY(U,$J,358.3,8469,0)
 ;;=E882.^^62^472^3
 ;;^UTILITY(U,$J,358.3,8469,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8469,1,4,0)
 ;;=4^E882.
 ;;^UTILITY(U,$J,358.3,8469,1,5,0)
 ;;=5^Fall From Building
 ;;^UTILITY(U,$J,358.3,8469,2)
 ;;=Fall From Building^294646
 ;;^UTILITY(U,$J,358.3,8470,0)
 ;;=E883.9^^62^472^13
 ;;^UTILITY(U,$J,358.3,8470,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8470,1,4,0)
 ;;=4^E883.9
 ;;^UTILITY(U,$J,358.3,8470,1,5,0)
 ;;=5^Fall Into Hole
 ;;^UTILITY(U,$J,358.3,8470,2)
 ;;=Fall Into Hole^294650
 ;;^UTILITY(U,$J,358.3,8471,0)
 ;;=E884.2^^62^472^4
 ;;^UTILITY(U,$J,358.3,8471,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8471,1,4,0)
 ;;=4^E884.2
 ;;^UTILITY(U,$J,358.3,8471,1,5,0)
 ;;=5^Fall From Chair
 ;;^UTILITY(U,$J,358.3,8471,2)
 ;;=Fall From Chair^294653
 ;;^UTILITY(U,$J,358.3,8472,0)
 ;;=E884.3^^62^472^11
 ;;^UTILITY(U,$J,358.3,8472,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8472,1,4,0)
 ;;=4^E884.3
 ;;^UTILITY(U,$J,358.3,8472,1,5,0)
 ;;=5^Fall From Wheelchair
 ;;^UTILITY(U,$J,358.3,8472,2)
 ;;=Fall From Wheelchair^303368
 ;;^UTILITY(U,$J,358.3,8473,0)
 ;;=E884.4^^62^472^2
 ;;^UTILITY(U,$J,358.3,8473,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8473,1,4,0)
 ;;=4^E884.4
 ;;^UTILITY(U,$J,358.3,8473,1,5,0)
 ;;=5^Fall From Bed
 ;;^UTILITY(U,$J,358.3,8473,2)
 ;;=Fall From Bed^303369
 ;;^UTILITY(U,$J,358.3,8474,0)
 ;;=E884.6^^62^472^5
 ;;^UTILITY(U,$J,358.3,8474,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8474,1,4,0)
 ;;=4^E884.6
 ;;^UTILITY(U,$J,358.3,8474,1,5,0)
 ;;=5^Fall From Commode
 ;;^UTILITY(U,$J,358.3,8474,2)
 ;;=Fall from Commode^303371
 ;;^UTILITY(U,$J,358.3,8475,0)
 ;;=E884.9^^62^472^18
 ;;^UTILITY(U,$J,358.3,8475,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8475,1,4,0)
 ;;=4^E884.9
 ;;^UTILITY(U,$J,358.3,8475,1,5,0)
 ;;=5^Other Fall, One Level To Another
 ;;^UTILITY(U,$J,358.3,8475,2)
 ;;=Other Fall^294654
 ;;^UTILITY(U,$J,358.3,8476,0)
 ;;=E885.1^^62^472^7
 ;;^UTILITY(U,$J,358.3,8476,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8476,1,4,0)
 ;;=4^E885.1
 ;;^UTILITY(U,$J,358.3,8476,1,5,0)
 ;;=5^Fall From Roller Skates
 ;;^UTILITY(U,$J,358.3,8476,2)
 ;;=Fall from Roller Skates^322100
 ;;^UTILITY(U,$J,358.3,8477,0)
 ;;=E885.2^^62^472^8
 ;;^UTILITY(U,$J,358.3,8477,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8477,1,4,0)
 ;;=4^E885.2
 ;;^UTILITY(U,$J,358.3,8477,1,5,0)
 ;;=5^Fall From Skateboard
 ;;^UTILITY(U,$J,358.3,8477,2)
 ;;=Fall from Skateboard^322102
 ;;^UTILITY(U,$J,358.3,8478,0)
 ;;=E885.3^^62^472^9
 ;;^UTILITY(U,$J,358.3,8478,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8478,1,4,0)
 ;;=4^E885.3
 ;;^UTILITY(U,$J,358.3,8478,1,5,0)
 ;;=5^Fall From Skis
 ;;^UTILITY(U,$J,358.3,8478,2)
 ;;=Fall from Skis^322103
 ;;^UTILITY(U,$J,358.3,8479,0)
 ;;=E885.4^^62^472^10
 ;;^UTILITY(U,$J,358.3,8479,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8479,1,4,0)
 ;;=4^E885.4
 ;;^UTILITY(U,$J,358.3,8479,1,5,0)
 ;;=5^Fall From Snowboard
 ;;^UTILITY(U,$J,358.3,8479,2)
 ;;=Fall from Snowboard^322104
 ;;^UTILITY(U,$J,358.3,8480,0)
 ;;=E885.9^^62^472^1
 ;;^UTILITY(U,$J,358.3,8480,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8480,1,4,0)
 ;;=4^E885.9
 ;;^UTILITY(U,$J,358.3,8480,1,5,0)
 ;;=5^Fall After Tripping Or Slipping
 ;;^UTILITY(U,$J,358.3,8480,2)
 ;;=Fall after tripping or slipping^322105
 ;;^UTILITY(U,$J,358.3,8481,0)
 ;;=E886.0^^62^472^12
 ;;^UTILITY(U,$J,358.3,8481,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8481,1,4,0)
 ;;=4^E886.0
 ;;^UTILITY(U,$J,358.3,8481,1,5,0)
 ;;=5^Fall In Sports
 ;;^UTILITY(U,$J,358.3,8481,2)
 ;;=Fall in Sports^294656
 ;;^UTILITY(U,$J,358.3,8482,0)
 ;;=E886.9^^62^472^15
 ;;^UTILITY(U,$J,358.3,8482,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8482,1,4,0)
 ;;=4^E886.9
 ;;^UTILITY(U,$J,358.3,8482,1,5,0)
 ;;=5^Fall, Collision With Another Person
 ;;^UTILITY(U,$J,358.3,8482,2)
 ;;=Fall, Collision with another person^294657
 ;;^UTILITY(U,$J,358.3,8483,0)
 ;;=E888.9^^62^472^16
 ;;^UTILITY(U,$J,358.3,8483,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8483,1,4,0)
 ;;=4^E888.9
 ;;^UTILITY(U,$J,358.3,8483,1,5,0)
 ;;=5^Fall, Not Specified
 ;;^UTILITY(U,$J,358.3,8483,2)
 ;;=Fall, Not Specified^323639
 ;;^UTILITY(U,$J,358.3,8484,0)
 ;;=E819.0^^62^472^19
 ;;^UTILITY(U,$J,358.3,8484,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8484,1,4,0)
 ;;=4^E819.0
 ;;^UTILITY(U,$J,358.3,8484,1,5,0)
 ;;=5^Traffic Accident, Driver
 ;;^UTILITY(U,$J,358.3,8484,2)
 ;;=Traffic Accident, Driver^294215
 ;;^UTILITY(U,$J,358.3,8485,0)
 ;;=E819.1^^62^472^20
 ;;^UTILITY(U,$J,358.3,8485,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8485,1,4,0)
 ;;=4^E819.1
 ;;^UTILITY(U,$J,358.3,8485,1,5,0)
 ;;=5^Traffic Accident, Passenger
 ;;^UTILITY(U,$J,358.3,8485,2)
 ;;=^294216
 ;;^UTILITY(U,$J,358.3,8486,0)
 ;;=E891.9^^62^472^17
 ;;^UTILITY(U,$J,358.3,8486,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8486,1,4,0)
 ;;=4^E891.9
 ;;^UTILITY(U,$J,358.3,8486,1,5,0)
 ;;=5^Fire In Building
 ;;^UTILITY(U,$J,358.3,8486,2)
 ;;=Fire in Building^294669
 ;;^UTILITY(U,$J,358.3,8487,0)
 ;;=0^1^62^472^0^CODE THE CONDITION OR SYMPTOM FIRST
 ;;^UTILITY(U,$J,358.3,8487,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8487,1,4,0)
 ;;=4
 ;;^UTILITY(U,$J,358.3,8487,1,5,0)
 ;;=5
 ;;^UTILITY(U,$J,358.3,8488,0)
 ;;=309.24^^63^473^3
 ;;^UTILITY(U,$J,358.3,8488,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8488,1,2,0)
 ;;=2^309.24
 ;;^UTILITY(U,$J,358.3,8488,1,5,0)
 ;;=5^Adj Reac w/Anx Mood
 ;;^UTILITY(U,$J,358.3,8488,2)
 ;;=^268308
 ;;^UTILITY(U,$J,358.3,8489,0)
 ;;=309.4^^63^473^5
 ;;^UTILITY(U,$J,358.3,8489,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8489,1,2,0)
 ;;=2^309.4
 ;;^UTILITY(U,$J,358.3,8489,1,5,0)
 ;;=5^Adj Reac w/Emotion & Conduct
 ;;^UTILITY(U,$J,358.3,8489,2)
 ;;=^268312
 ;;^UTILITY(U,$J,358.3,8490,0)
 ;;=309.28^^63^473^1
 ;;^UTILITY(U,$J,358.3,8490,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8490,1,2,0)
 ;;=2^309.28
 ;;^UTILITY(U,$J,358.3,8490,1,5,0)
 ;;=5^Adj Reac W/Mixed Emotion
 ;;^UTILITY(U,$J,358.3,8490,2)
 ;;=^268309
 ;;^UTILITY(U,$J,358.3,8491,0)
 ;;=309.9^^63^473^8
 ;;^UTILITY(U,$J,358.3,8491,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8491,1,2,0)
 ;;=2^309.9
 ;;^UTILITY(U,$J,358.3,8491,1,5,0)
 ;;=5^Adjustment Reaction NOS
 ;;^UTILITY(U,$J,358.3,8491,2)
 ;;=^123757
 ;;^UTILITY(U,$J,358.3,8492,0)
 ;;=309.0^^63^473^10
 ;;^UTILITY(U,$J,358.3,8492,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8492,1,2,0)
 ;;=2^309.0
 ;;^UTILITY(U,$J,358.3,8492,1,5,0)
 ;;=5^Depressive Reac-Brief
 ;;^UTILITY(U,$J,358.3,8492,2)
 ;;=^3308
 ;;^UTILITY(U,$J,358.3,8493,0)
 ;;=309.1^^63^473^11
 ;;^UTILITY(U,$J,358.3,8493,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8493,1,2,0)
 ;;=2^309.1
 ;;^UTILITY(U,$J,358.3,8493,1,5,0)
 ;;=5^Depressive Reac-Prolong
 ;;^UTILITY(U,$J,358.3,8493,2)
 ;;=^268304
 ;;^UTILITY(U,$J,358.3,8494,0)
 ;;=309.3^^63^473^4
 ;;^UTILITY(U,$J,358.3,8494,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8494,1,2,0)
 ;;=2^309.3
 ;;^UTILITY(U,$J,358.3,8494,1,5,0)
 ;;=5^Adj Reac w/Conduct Disord
 ;;^UTILITY(U,$J,358.3,8494,2)
 ;;=^268311
