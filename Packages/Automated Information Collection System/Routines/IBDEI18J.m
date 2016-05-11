IBDEI18J ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,21001,1,4,0)
 ;;=4^S56.811A
 ;;^UTILITY(U,$J,358.3,21001,2)
 ;;=^5031862
 ;;^UTILITY(U,$J,358.3,21002,0)
 ;;=S56.812A^^84^942^21
 ;;^UTILITY(U,$J,358.3,21002,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21002,1,3,0)
 ;;=3^Strain of Left Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21002,1,4,0)
 ;;=4^S56.812A
 ;;^UTILITY(U,$J,358.3,21002,2)
 ;;=^5031865
 ;;^UTILITY(U,$J,358.3,21003,0)
 ;;=S56.116A^^84^942^33
 ;;^UTILITY(U,$J,358.3,21003,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21003,1,3,0)
 ;;=3^Strain of Left Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21003,1,4,0)
 ;;=4^S56.116A
 ;;^UTILITY(U,$J,358.3,21003,2)
 ;;=^5031631
 ;;^UTILITY(U,$J,358.3,21004,0)
 ;;=S56.117A^^84^942^46
 ;;^UTILITY(U,$J,358.3,21004,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21004,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21004,1,4,0)
 ;;=4^S56.117A
 ;;^UTILITY(U,$J,358.3,21004,2)
 ;;=^5031634
 ;;^UTILITY(U,$J,358.3,21005,0)
 ;;=S56.118A^^84^942^26
 ;;^UTILITY(U,$J,358.3,21005,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21005,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21005,1,4,0)
 ;;=4^S56.118A
 ;;^UTILITY(U,$J,358.3,21005,2)
 ;;=^5031637
 ;;^UTILITY(U,$J,358.3,21006,0)
 ;;=S56.211A^^84^942^40
 ;;^UTILITY(U,$J,358.3,21006,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21006,1,3,0)
 ;;=3^Strain of Right Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21006,1,4,0)
 ;;=4^S56.211A
 ;;^UTILITY(U,$J,358.3,21006,2)
 ;;=^5031691
 ;;^UTILITY(U,$J,358.3,21007,0)
 ;;=S56.212A^^84^942^20
 ;;^UTILITY(U,$J,358.3,21007,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21007,1,3,0)
 ;;=3^Strain of Left Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21007,1,4,0)
 ;;=4^S56.212A
 ;;^UTILITY(U,$J,358.3,21007,2)
 ;;=^5031694
 ;;^UTILITY(U,$J,358.3,21008,0)
 ;;=S56.311A^^84^942^56
 ;;^UTILITY(U,$J,358.3,21008,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21008,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21008,1,4,0)
 ;;=4^S56.311A
 ;;^UTILITY(U,$J,358.3,21008,2)
 ;;=^5031715
 ;;^UTILITY(U,$J,358.3,21009,0)
 ;;=S56.312A^^84^942^35
 ;;^UTILITY(U,$J,358.3,21009,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21009,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21009,1,4,0)
 ;;=4^S56.312A
 ;;^UTILITY(U,$J,358.3,21009,2)
 ;;=^5031718
 ;;^UTILITY(U,$J,358.3,21010,0)
 ;;=S56.411A^^84^942^44
 ;;^UTILITY(U,$J,358.3,21010,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21010,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21010,1,4,0)
 ;;=4^S56.411A
 ;;^UTILITY(U,$J,358.3,21010,2)
 ;;=^5031763
 ;;^UTILITY(U,$J,358.3,21011,0)
 ;;=S56.412A^^84^942^24
 ;;^UTILITY(U,$J,358.3,21011,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21011,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21011,1,4,0)
 ;;=4^S56.412A
 ;;^UTILITY(U,$J,358.3,21011,2)
 ;;=^5031766
 ;;^UTILITY(U,$J,358.3,21012,0)
 ;;=S56.413A^^84^942^52
 ;;^UTILITY(U,$J,358.3,21012,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,21012,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,21012,1,4,0)
 ;;=4^S56.413A
 ;;^UTILITY(U,$J,358.3,21012,2)
 ;;=^5031769
 ;;^UTILITY(U,$J,358.3,21013,0)
 ;;=S56.414A^^84^942^32
