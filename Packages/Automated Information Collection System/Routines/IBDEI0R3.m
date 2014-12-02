IBDEI0R3 ; ; 12-AUG-2014
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 15, 2014
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13365,1,5,0)
 ;;=5^Fall from Wheelchair
 ;;^UTILITY(U,$J,358.3,13365,2)
 ;;=Fall From Wheelchair^303368
 ;;^UTILITY(U,$J,358.3,13366,0)
 ;;=E884.4^^87^833^3
 ;;^UTILITY(U,$J,358.3,13366,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13366,1,4,0)
 ;;=4^E884.4
 ;;^UTILITY(U,$J,358.3,13366,1,5,0)
 ;;=5^Fall from Bed
 ;;^UTILITY(U,$J,358.3,13366,2)
 ;;=Fall From Bed^303369
 ;;^UTILITY(U,$J,358.3,13367,0)
 ;;=E884.6^^87^833^6
 ;;^UTILITY(U,$J,358.3,13367,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13367,1,4,0)
 ;;=4^E884.6
 ;;^UTILITY(U,$J,358.3,13367,1,5,0)
 ;;=5^Fall from Commode
 ;;^UTILITY(U,$J,358.3,13367,2)
 ;;=Fall from Commode^303371
 ;;^UTILITY(U,$J,358.3,13368,0)
 ;;=E884.9^^87^833^18
 ;;^UTILITY(U,$J,358.3,13368,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13368,1,4,0)
 ;;=4^E884.9
 ;;^UTILITY(U,$J,358.3,13368,1,5,0)
 ;;=5^Other Fall, one level to another
 ;;^UTILITY(U,$J,358.3,13368,2)
 ;;=Other Fall^294654
 ;;^UTILITY(U,$J,358.3,13369,0)
 ;;=E885.1^^87^833^8
 ;;^UTILITY(U,$J,358.3,13369,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13369,1,4,0)
 ;;=4^E885.1
 ;;^UTILITY(U,$J,358.3,13369,1,5,0)
 ;;=5^Fall from Roller Skates
 ;;^UTILITY(U,$J,358.3,13369,2)
 ;;=Fall from Roller Skates^322100
 ;;^UTILITY(U,$J,358.3,13370,0)
 ;;=E885.2^^87^833^9
 ;;^UTILITY(U,$J,358.3,13370,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13370,1,4,0)
 ;;=4^E885.2
 ;;^UTILITY(U,$J,358.3,13370,1,5,0)
 ;;=5^Fall from Skateboard
 ;;^UTILITY(U,$J,358.3,13370,2)
 ;;=Fall from Skateboard^322102
 ;;^UTILITY(U,$J,358.3,13371,0)
 ;;=E885.3^^87^833^10
 ;;^UTILITY(U,$J,358.3,13371,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13371,1,4,0)
 ;;=4^E885.3
 ;;^UTILITY(U,$J,358.3,13371,1,5,0)
 ;;=5^Fall from Skis
 ;;^UTILITY(U,$J,358.3,13371,2)
 ;;=Fall from Skis^322103
 ;;^UTILITY(U,$J,358.3,13372,0)
 ;;=E885.4^^87^833^11
 ;;^UTILITY(U,$J,358.3,13372,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13372,1,4,0)
 ;;=4^E885.4
 ;;^UTILITY(U,$J,358.3,13372,1,5,0)
 ;;=5^Fall from Snowboard
 ;;^UTILITY(U,$J,358.3,13372,2)
 ;;=Fall from Snowboard^322104
 ;;^UTILITY(U,$J,358.3,13373,0)
 ;;=E885.9^^87^833^1
 ;;^UTILITY(U,$J,358.3,13373,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13373,1,4,0)
 ;;=4^E885.9
 ;;^UTILITY(U,$J,358.3,13373,1,5,0)
 ;;=5^Fall After Tripping or Slipping
 ;;^UTILITY(U,$J,358.3,13373,2)
 ;;=Fall after tripping or slipping^322105
 ;;^UTILITY(U,$J,358.3,13374,0)
 ;;=E886.0^^87^833^13
 ;;^UTILITY(U,$J,358.3,13374,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13374,1,4,0)
 ;;=4^E886.0
 ;;^UTILITY(U,$J,358.3,13374,1,5,0)
 ;;=5^Fall in Sports
 ;;^UTILITY(U,$J,358.3,13374,2)
 ;;=Fall in Sports^294656
 ;;^UTILITY(U,$J,358.3,13375,0)
 ;;=E886.9^^87^833^15
 ;;^UTILITY(U,$J,358.3,13375,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13375,1,4,0)
 ;;=4^E886.9
 ;;^UTILITY(U,$J,358.3,13375,1,5,0)
 ;;=5^Fall, Collision with another person
 ;;^UTILITY(U,$J,358.3,13375,2)
 ;;=Fall, Collision with another person^294657
 ;;^UTILITY(U,$J,358.3,13376,0)
 ;;=E888.9^^87^833^16
 ;;^UTILITY(U,$J,358.3,13376,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13376,1,4,0)
 ;;=4^E888.9
 ;;^UTILITY(U,$J,358.3,13376,1,5,0)
 ;;=5^Fall, Not Specified
 ;;^UTILITY(U,$J,358.3,13376,2)
 ;;=Fall, Not Specified^323639
 ;;^UTILITY(U,$J,358.3,13377,0)
 ;;=E819.0^^87^833^19
 ;;^UTILITY(U,$J,358.3,13377,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13377,1,4,0)
 ;;=4^E819.0
 ;;^UTILITY(U,$J,358.3,13377,1,5,0)
 ;;=5^Traffic Accident, Driver
 ;;^UTILITY(U,$J,358.3,13377,2)
 ;;=Traffic Accident, Driver^294215
 ;;^UTILITY(U,$J,358.3,13378,0)
 ;;=E819.1^^87^833^20
