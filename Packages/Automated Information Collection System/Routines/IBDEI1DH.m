IBDEI1DH ; ; 17-FEB-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,23330,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23330,1,3,0)
 ;;=3^Strain of Right Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23330,1,4,0)
 ;;=4^S56.211A
 ;;^UTILITY(U,$J,358.3,23330,2)
 ;;=^5031691
 ;;^UTILITY(U,$J,358.3,23331,0)
 ;;=S56.212A^^87^994^20
 ;;^UTILITY(U,$J,358.3,23331,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23331,1,3,0)
 ;;=3^Strain of Left Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23331,1,4,0)
 ;;=4^S56.212A
 ;;^UTILITY(U,$J,358.3,23331,2)
 ;;=^5031694
 ;;^UTILITY(U,$J,358.3,23332,0)
 ;;=S56.311A^^87^994^56
 ;;^UTILITY(U,$J,358.3,23332,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23332,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23332,1,4,0)
 ;;=4^S56.311A
 ;;^UTILITY(U,$J,358.3,23332,2)
 ;;=^5031715
 ;;^UTILITY(U,$J,358.3,23333,0)
 ;;=S56.312A^^87^994^35
 ;;^UTILITY(U,$J,358.3,23333,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23333,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23333,1,4,0)
 ;;=4^S56.312A
 ;;^UTILITY(U,$J,358.3,23333,2)
 ;;=^5031718
 ;;^UTILITY(U,$J,358.3,23334,0)
 ;;=S56.411A^^87^994^44
 ;;^UTILITY(U,$J,358.3,23334,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23334,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23334,1,4,0)
 ;;=4^S56.411A
 ;;^UTILITY(U,$J,358.3,23334,2)
 ;;=^5031763
 ;;^UTILITY(U,$J,358.3,23335,0)
 ;;=S56.412A^^87^994^24
 ;;^UTILITY(U,$J,358.3,23335,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23335,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23335,1,4,0)
 ;;=4^S56.412A
 ;;^UTILITY(U,$J,358.3,23335,2)
 ;;=^5031766
 ;;^UTILITY(U,$J,358.3,23336,0)
 ;;=S56.413A^^87^994^52
 ;;^UTILITY(U,$J,358.3,23336,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23336,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23336,1,4,0)
 ;;=4^S56.413A
 ;;^UTILITY(U,$J,358.3,23336,2)
 ;;=^5031769
 ;;^UTILITY(U,$J,358.3,23337,0)
 ;;=S56.414A^^87^994^32
 ;;^UTILITY(U,$J,358.3,23337,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23337,1,3,0)
 ;;=3^Strain of Left Middle Finger at Forearm Levle Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23337,1,4,0)
 ;;=4^S56.414A
 ;;^UTILITY(U,$J,358.3,23337,2)
 ;;=^5031772
 ;;^UTILITY(U,$J,358.3,23338,0)
 ;;=S56.415A^^87^994^54
 ;;^UTILITY(U,$J,358.3,23338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23338,1,3,0)
 ;;=3^Strain of Right Ring Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23338,1,4,0)
 ;;=4^S56.415A
 ;;^UTILITY(U,$J,358.3,23338,2)
 ;;=^5031775
 ;;^UTILITY(U,$J,358.3,23339,0)
 ;;=S56.416A^^87^994^34
 ;;^UTILITY(U,$J,358.3,23339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23339,1,3,0)
 ;;=3^Strain of Left Ring Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,23339,1,4,0)
 ;;=4^S56.416A
 ;;^UTILITY(U,$J,358.3,23339,2)
 ;;=^5031778
 ;;^UTILITY(U,$J,358.3,23340,0)
 ;;=S66.912A^^87^994^22
 ;;^UTILITY(U,$J,358.3,23340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23340,1,3,0)
 ;;=3^Strain of Left Hand Muscle/Fasc/Tendon,Unspec
 ;;^UTILITY(U,$J,358.3,23340,1,4,0)
 ;;=4^S66.912A
 ;;^UTILITY(U,$J,358.3,23340,2)
 ;;=^5036534
 ;;^UTILITY(U,$J,358.3,23341,0)
 ;;=S66.911A^^87^994^42
 ;;^UTILITY(U,$J,358.3,23341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,23341,1,3,0)
 ;;=3^Strain of Right Hand Muscle/Fasc/Tendon,Unspec
