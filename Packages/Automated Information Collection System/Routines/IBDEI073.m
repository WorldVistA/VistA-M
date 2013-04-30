IBDEI073 ; ; 20-FEB-2013
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 20, 2013
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9301,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9301,1,4,0)
 ;;=4^729.1
 ;;^UTILITY(U,$J,358.3,9301,1,5,0)
 ;;=5^Neuropathic Pain
 ;;^UTILITY(U,$J,358.3,9301,2)
 ;;=Neuropathic Pain^80160
 ;;^UTILITY(U,$J,358.3,9302,0)
 ;;=608.9^^74^641^20
 ;;^UTILITY(U,$J,358.3,9302,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9302,1,4,0)
 ;;=4^608.9
 ;;^UTILITY(U,$J,358.3,9302,1,5,0)
 ;;=5^Penile Pain
 ;;^UTILITY(U,$J,358.3,9302,2)
 ;;=Penile Pain^123856
 ;;^UTILITY(U,$J,358.3,9303,0)
 ;;=608.89^^74^641^21
 ;;^UTILITY(U,$J,358.3,9303,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9303,1,4,0)
 ;;=4^608.89
 ;;^UTILITY(U,$J,358.3,9303,1,5,0)
 ;;=5^Scrotal Pain
 ;;^UTILITY(U,$J,358.3,9303,2)
 ;;=Scrotal Pain^88009
 ;;^UTILITY(U,$J,358.3,9304,0)
 ;;=625.9^^74^641^19
 ;;^UTILITY(U,$J,358.3,9304,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9304,1,4,0)
 ;;=4^625.9
 ;;^UTILITY(U,$J,358.3,9304,1,5,0)
 ;;=5^Pelvic Pain (Female)
 ;;^UTILITY(U,$J,358.3,9304,2)
 ;;=^123993
 ;;^UTILITY(U,$J,358.3,9305,0)
 ;;=388.70^^74^641^8
 ;;^UTILITY(U,$J,358.3,9305,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9305,1,4,0)
 ;;=4^388.70
 ;;^UTILITY(U,$J,358.3,9305,1,5,0)
 ;;=5^Ear Pain
 ;;^UTILITY(U,$J,358.3,9305,2)
 ;;=Ear Pain^37811
 ;;^UTILITY(U,$J,358.3,9306,0)
 ;;=526.9^^74^641^13
 ;;^UTILITY(U,$J,358.3,9306,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9306,1,4,0)
 ;;=4^526.9
 ;;^UTILITY(U,$J,358.3,9306,1,5,0)
 ;;=5^Jaw Pain
 ;;^UTILITY(U,$J,358.3,9306,2)
 ;;=Jaw Pain^66177
 ;;^UTILITY(U,$J,358.3,9307,0)
 ;;=789.01^^74^641^5
 ;;^UTILITY(U,$J,358.3,9307,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9307,1,4,0)
 ;;=4^789.01
 ;;^UTILITY(U,$J,358.3,9307,1,5,0)
 ;;=5^Abdominal Pain, Ruq
 ;;^UTILITY(U,$J,358.3,9307,2)
 ;;=Abdominal Pain, RUQ^303318
 ;;^UTILITY(U,$J,358.3,9308,0)
 ;;=789.02^^74^641^3
 ;;^UTILITY(U,$J,358.3,9308,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9308,1,4,0)
 ;;=4^789.02
 ;;^UTILITY(U,$J,358.3,9308,1,5,0)
 ;;=5^Abdominal Pain, Luq
 ;;^UTILITY(U,$J,358.3,9308,2)
 ;;=Abdominal Pain, LUQ^303319
 ;;^UTILITY(U,$J,358.3,9309,0)
 ;;=789.03^^74^641^4
 ;;^UTILITY(U,$J,358.3,9309,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9309,1,4,0)
 ;;=4^789.03
 ;;^UTILITY(U,$J,358.3,9309,1,5,0)
 ;;=5^Abdominal Pain, Rlq
 ;;^UTILITY(U,$J,358.3,9309,2)
 ;;=Abdominal PainLLQ^303320
 ;;^UTILITY(U,$J,358.3,9310,0)
 ;;=789.04^^74^641^2
 ;;^UTILITY(U,$J,358.3,9310,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9310,1,4,0)
 ;;=4^789.04
 ;;^UTILITY(U,$J,358.3,9310,1,5,0)
 ;;=5^Abdominal Pain, Llq
 ;;^UTILITY(U,$J,358.3,9310,2)
 ;;=^303321
 ;;^UTILITY(U,$J,358.3,9311,0)
 ;;=789.06^^74^641^9
 ;;^UTILITY(U,$J,358.3,9311,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9311,1,4,0)
 ;;=4^789.06
 ;;^UTILITY(U,$J,358.3,9311,1,5,0)
 ;;=5^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,9311,2)
 ;;=Epigastric Pain^303323
 ;;^UTILITY(U,$J,358.3,9312,0)
 ;;=789.07^^74^641^1
 ;;^UTILITY(U,$J,358.3,9312,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9312,1,4,0)
 ;;=4^789.07
 ;;^UTILITY(U,$J,358.3,9312,1,5,0)
 ;;=5^Abdominal Pain, Generalized
 ;;^UTILITY(U,$J,358.3,9312,2)
 ;;=^303324
 ;;^UTILITY(U,$J,358.3,9313,0)
 ;;=788.0^^74^641^14
 ;;^UTILITY(U,$J,358.3,9313,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9313,1,4,0)
 ;;=4^788.0
 ;;^UTILITY(U,$J,358.3,9313,1,5,0)
 ;;=5^Kidney Pain
 ;;^UTILITY(U,$J,358.3,9313,2)
 ;;=^265306
 ;;^UTILITY(U,$J,358.3,9314,0)
 ;;=V68.1^^74^642^4
 ;;^UTILITY(U,$J,358.3,9314,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9314,1,4,0)
 ;;=4^V68.1
 ;;^UTILITY(U,$J,358.3,9314,1,5,0)
 ;;=5^Rx Refill (Also Mark Condition)
 ;;^UTILITY(U,$J,358.3,9314,2)
 ;;=RX Refill (also mark Condition)^295585
 ;;^UTILITY(U,$J,358.3,9315,0)
 ;;=V68.81^^74^642^5
 ;;^UTILITY(U,$J,358.3,9315,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9315,1,4,0)
 ;;=4^V68.81
 ;;^UTILITY(U,$J,358.3,9315,1,5,0)
 ;;=5^Transfer Of Care (Also Mark Conditions)
 ;;^UTILITY(U,$J,358.3,9315,2)
 ;;=Transfer of Care ^295587
 ;;^UTILITY(U,$J,358.3,9316,0)
 ;;=V58.83^^74^642^1
 ;;^UTILITY(U,$J,358.3,9316,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9316,1,4,0)
 ;;=4^V58.83
 ;;^UTILITY(U,$J,358.3,9316,1,5,0)
 ;;=5^Encounter For Therapeutic Drug Monitoring
 ;;^UTILITY(U,$J,358.3,9316,2)
 ;;=Encounter for Therapeutic Drug Monitoring^322076
 ;;^UTILITY(U,$J,358.3,9317,0)
 ;;=V68.09^^74^642^3
 ;;^UTILITY(U,$J,358.3,9317,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9317,1,4,0)
 ;;=4^V68.09
 ;;^UTILITY(U,$J,358.3,9317,1,5,0)
 ;;=5^Issue Of Med Certif Nec
 ;;^UTILITY(U,$J,358.3,9317,2)
 ;;=^335321
 ;;^UTILITY(U,$J,358.3,9318,0)
 ;;=V60.89^^74^642^2
 ;;^UTILITY(U,$J,358.3,9318,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9318,1,4,0)
 ;;=4^V60.89
 ;;^UTILITY(U,$J,358.3,9318,1,5,0)
 ;;=5^Housing/Econo Needs NEC
 ;;^UTILITY(U,$J,358.3,9318,2)
 ;;=^295545
 ;;^UTILITY(U,$J,358.3,9319,0)
 ;;=E880.1^^74^643^1
 ;;^UTILITY(U,$J,358.3,9319,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9319,1,4,0)
 ;;=4^E880.1
 ;;^UTILITY(U,$J,358.3,9319,1,5,0)
 ;;=5^Fall On/From Sidewalk Or Curb
 ;;^UTILITY(U,$J,358.3,9319,2)
 ;;=Fall on/from Sidewalk or Curb^303367
 ;;^UTILITY(U,$J,358.3,9320,0)
 ;;=E881.0^^74^643^2
 ;;^UTILITY(U,$J,358.3,9320,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9320,1,4,0)
 ;;=4^E881.0
 ;;^UTILITY(U,$J,358.3,9320,1,5,0)
 ;;=5^Fall From Ladder
 ;;^UTILITY(U,$J,358.3,9320,2)
 ;;=Fall From Ladder^294644
 ;;^UTILITY(U,$J,358.3,9321,0)
 ;;=E882.^^74^643^3
 ;;^UTILITY(U,$J,358.3,9321,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9321,1,4,0)
 ;;=4^E882.
 ;;^UTILITY(U,$J,358.3,9321,1,5,0)
 ;;=5^Fall From Building
 ;;^UTILITY(U,$J,358.3,9321,2)
 ;;=Fall From Building^294646
 ;;^UTILITY(U,$J,358.3,9322,0)
 ;;=E883.9^^74^643^4
 ;;^UTILITY(U,$J,358.3,9322,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9322,1,4,0)
 ;;=4^E883.9
 ;;^UTILITY(U,$J,358.3,9322,1,5,0)
 ;;=5^Fall Into Hole
 ;;^UTILITY(U,$J,358.3,9322,2)
 ;;=Fall Into Hole^294650
 ;;^UTILITY(U,$J,358.3,9323,0)
 ;;=E884.2^^74^643^5
 ;;^UTILITY(U,$J,358.3,9323,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9323,1,4,0)
 ;;=4^E884.2
 ;;^UTILITY(U,$J,358.3,9323,1,5,0)
 ;;=5^Fall From Chair
 ;;^UTILITY(U,$J,358.3,9323,2)
 ;;=Fall From Chair^294653
 ;;^UTILITY(U,$J,358.3,9324,0)
 ;;=E884.3^^74^643^6
 ;;^UTILITY(U,$J,358.3,9324,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9324,1,4,0)
 ;;=4^E884.3
 ;;^UTILITY(U,$J,358.3,9324,1,5,0)
 ;;=5^Fall From Wheelchair
 ;;^UTILITY(U,$J,358.3,9324,2)
 ;;=Fall From Wheelchair^303368
 ;;^UTILITY(U,$J,358.3,9325,0)
 ;;=E884.4^^74^643^7
 ;;^UTILITY(U,$J,358.3,9325,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9325,1,4,0)
 ;;=4^E884.4
 ;;^UTILITY(U,$J,358.3,9325,1,5,0)
 ;;=5^Fall From Bed
 ;;^UTILITY(U,$J,358.3,9325,2)
 ;;=Fall From Bed^303369
 ;;^UTILITY(U,$J,358.3,9326,0)
 ;;=E884.6^^74^643^8
 ;;^UTILITY(U,$J,358.3,9326,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9326,1,4,0)
 ;;=4^E884.6
 ;;^UTILITY(U,$J,358.3,9326,1,5,0)
 ;;=5^Fall From Commode
 ;;^UTILITY(U,$J,358.3,9326,2)
 ;;=Fall from Commode^303371
 ;;^UTILITY(U,$J,358.3,9327,0)
 ;;=E884.9^^74^643^9
 ;;^UTILITY(U,$J,358.3,9327,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9327,1,4,0)
 ;;=4^E884.9
 ;;^UTILITY(U,$J,358.3,9327,1,5,0)
 ;;=5^Other Fall, One Level To Another
 ;;^UTILITY(U,$J,358.3,9327,2)
 ;;=Other Fall^294654
 ;;^UTILITY(U,$J,358.3,9328,0)
 ;;=E885.1^^74^643^10
 ;;^UTILITY(U,$J,358.3,9328,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9328,1,4,0)
 ;;=4^E885.1
 ;;^UTILITY(U,$J,358.3,9328,1,5,0)
 ;;=5^Fall From Roller Skates
 ;;^UTILITY(U,$J,358.3,9328,2)
 ;;=Fall from Roller Skates^322100
 ;;^UTILITY(U,$J,358.3,9329,0)
 ;;=E885.2^^74^643^11
 ;;^UTILITY(U,$J,358.3,9329,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9329,1,4,0)
 ;;=4^E885.2
 ;;^UTILITY(U,$J,358.3,9329,1,5,0)
 ;;=5^Fall From Skateboard
 ;;^UTILITY(U,$J,358.3,9329,2)
 ;;=Fall from Skateboard^322102
 ;;^UTILITY(U,$J,358.3,9330,0)
 ;;=E885.3^^74^643^12
 ;;^UTILITY(U,$J,358.3,9330,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9330,1,4,0)
 ;;=4^E885.3
 ;;^UTILITY(U,$J,358.3,9330,1,5,0)
 ;;=5^Fall From Skis
 ;;^UTILITY(U,$J,358.3,9330,2)
 ;;=Fall from Skis^322103
 ;;^UTILITY(U,$J,358.3,9331,0)
 ;;=E885.4^^74^643^13
 ;;^UTILITY(U,$J,358.3,9331,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9331,1,4,0)
 ;;=4^E885.4
 ;;^UTILITY(U,$J,358.3,9331,1,5,0)
 ;;=5^Fall From Snowboard
 ;;^UTILITY(U,$J,358.3,9331,2)
 ;;=Fall from Snowboard^322104
 ;;^UTILITY(U,$J,358.3,9332,0)
 ;;=E885.9^^74^643^14
 ;;^UTILITY(U,$J,358.3,9332,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9332,1,4,0)
 ;;=4^E885.9
 ;;^UTILITY(U,$J,358.3,9332,1,5,0)
 ;;=5^Fall After Tripping Or Slipping
 ;;^UTILITY(U,$J,358.3,9332,2)
 ;;=Fall after tripping or slipping^322105
 ;;^UTILITY(U,$J,358.3,9333,0)
 ;;=E886.0^^74^643^15
 ;;^UTILITY(U,$J,358.3,9333,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9333,1,4,0)
 ;;=4^E886.0
 ;;^UTILITY(U,$J,358.3,9333,1,5,0)
 ;;=5^Fall In Sports
 ;;^UTILITY(U,$J,358.3,9333,2)
 ;;=Fall in Sports^294656
 ;;^UTILITY(U,$J,358.3,9334,0)
 ;;=E886.9^^74^643^16
 ;;^UTILITY(U,$J,358.3,9334,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9334,1,4,0)
 ;;=4^E886.9
 ;;^UTILITY(U,$J,358.3,9334,1,5,0)
 ;;=5^Fall, Collision With Another Person
 ;;^UTILITY(U,$J,358.3,9334,2)
 ;;=Fall, Collision with another person^294657
 ;;^UTILITY(U,$J,358.3,9335,0)
 ;;=E888.9^^74^643^17
 ;;^UTILITY(U,$J,358.3,9335,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9335,1,4,0)
 ;;=4^E888.9
 ;;^UTILITY(U,$J,358.3,9335,1,5,0)
 ;;=5^Fall, Not Specified
 ;;^UTILITY(U,$J,358.3,9335,2)
 ;;=Fall, Not Specified^323639
 ;;^UTILITY(U,$J,358.3,9336,0)
 ;;=E819.0^^74^643^18
 ;;^UTILITY(U,$J,358.3,9336,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,9336,1,4,0)
 ;;=4^E819.0
 ;;^UTILITY(U,$J,358.3,9336,1,5,0)
 ;;=5^Traffic Accident, Driver
 ;;^UTILITY(U,$J,358.3,9336,2)
 ;;=Traffic Accident, Driver^294215
 ;;^UTILITY(U,$J,358.3,9337,0)
 ;;=E819.1^^74^643^19
 ;;^UTILITY(U,$J,358.3,9337,1,0)
 ;;=^358.31IA^5^2
