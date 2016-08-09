IBDEI08H ; ; 12-MAY-2016
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;MAY 12, 2016
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8430,1,3,0)
 ;;=3^Vomiting w/o Nausea
 ;;^UTILITY(U,$J,358.3,8430,1,4,0)
 ;;=4^R11.11
 ;;^UTILITY(U,$J,358.3,8430,2)
 ;;=^5019233
 ;;^UTILITY(U,$J,358.3,8431,0)
 ;;=S43.51XA^^42^511^11
 ;;^UTILITY(U,$J,358.3,8431,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8431,1,3,0)
 ;;=3^Sprain of Right Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,8431,1,4,0)
 ;;=4^S43.51XA
 ;;^UTILITY(U,$J,358.3,8431,2)
 ;;=^5027903
 ;;^UTILITY(U,$J,358.3,8432,0)
 ;;=S43.52XA^^42^511^2
 ;;^UTILITY(U,$J,358.3,8432,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8432,1,3,0)
 ;;=3^Sprain of Left Acromioclavicular Joint
 ;;^UTILITY(U,$J,358.3,8432,1,4,0)
 ;;=4^S43.52XA
 ;;^UTILITY(U,$J,358.3,8432,2)
 ;;=^5027906
 ;;^UTILITY(U,$J,358.3,8433,0)
 ;;=S43.421A^^42^511^16
 ;;^UTILITY(U,$J,358.3,8433,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8433,1,3,0)
 ;;=3^Sprain of Right Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,8433,1,4,0)
 ;;=4^S43.421A
 ;;^UTILITY(U,$J,358.3,8433,2)
 ;;=^5027879
 ;;^UTILITY(U,$J,358.3,8434,0)
 ;;=S43.422A^^42^511^7
 ;;^UTILITY(U,$J,358.3,8434,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8434,1,3,0)
 ;;=3^Sprain of Left Rotator Cuff Capsule
 ;;^UTILITY(U,$J,358.3,8434,1,4,0)
 ;;=4^S43.422A
 ;;^UTILITY(U,$J,358.3,8434,2)
 ;;=^5027882
 ;;^UTILITY(U,$J,358.3,8435,0)
 ;;=S53.401A^^42^511^13
 ;;^UTILITY(U,$J,358.3,8435,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8435,1,3,0)
 ;;=3^Sprain of Right Elbow
 ;;^UTILITY(U,$J,358.3,8435,1,4,0)
 ;;=4^S53.401A
 ;;^UTILITY(U,$J,358.3,8435,2)
 ;;=^5031361
 ;;^UTILITY(U,$J,358.3,8436,0)
 ;;=S53.402A^^42^511^4
 ;;^UTILITY(U,$J,358.3,8436,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8436,1,3,0)
 ;;=3^Sprain of Left Elbow
 ;;^UTILITY(U,$J,358.3,8436,1,4,0)
 ;;=4^S53.402A
 ;;^UTILITY(U,$J,358.3,8436,2)
 ;;=^5031364
 ;;^UTILITY(U,$J,358.3,8437,0)
 ;;=S56.011A^^42^511^53
 ;;^UTILITY(U,$J,358.3,8437,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8437,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8437,1,4,0)
 ;;=4^S56.011A
 ;;^UTILITY(U,$J,358.3,8437,2)
 ;;=^5031568
 ;;^UTILITY(U,$J,358.3,8438,0)
 ;;=S56.012A^^42^511^35
 ;;^UTILITY(U,$J,358.3,8438,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8438,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8438,1,4,0)
 ;;=4^S56.012A
 ;;^UTILITY(U,$J,358.3,8438,2)
 ;;=^5031571
 ;;^UTILITY(U,$J,358.3,8439,0)
 ;;=S56.111A^^42^511^41
 ;;^UTILITY(U,$J,358.3,8439,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8439,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8439,1,4,0)
 ;;=4^S56.111A
 ;;^UTILITY(U,$J,358.3,8439,2)
 ;;=^5031616
 ;;^UTILITY(U,$J,358.3,8440,0)
 ;;=S56.112A^^42^511^22
 ;;^UTILITY(U,$J,358.3,8440,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8440,1,3,0)
 ;;=3^Strain of Left Index Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8440,1,4,0)
 ;;=4^S56.112A
 ;;^UTILITY(U,$J,358.3,8440,2)
 ;;=^5031619
 ;;^UTILITY(U,$J,358.3,8441,0)
 ;;=S56.113A^^42^511^49
 ;;^UTILITY(U,$J,358.3,8441,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8441,1,3,0)
 ;;=3^Strain of Right Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8441,1,4,0)
 ;;=4^S56.113A
 ;;^UTILITY(U,$J,358.3,8441,2)
 ;;=^5031622
 ;;^UTILITY(U,$J,358.3,8442,0)
 ;;=S56.114A^^42^511^30
 ;;^UTILITY(U,$J,358.3,8442,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8442,1,3,0)
 ;;=3^Strain of Left Middle Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8442,1,4,0)
 ;;=4^S56.114A
 ;;^UTILITY(U,$J,358.3,8442,2)
 ;;=^5031625
 ;;^UTILITY(U,$J,358.3,8443,0)
 ;;=S56.115A^^42^511^51
 ;;^UTILITY(U,$J,358.3,8443,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8443,1,3,0)
 ;;=3^Strain of Right Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8443,1,4,0)
 ;;=4^S56.115A
 ;;^UTILITY(U,$J,358.3,8443,2)
 ;;=^5031628
 ;;^UTILITY(U,$J,358.3,8444,0)
 ;;=S56.417A^^42^511^43
 ;;^UTILITY(U,$J,358.3,8444,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8444,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Extn Musc/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8444,1,4,0)
 ;;=4^S56.417A
 ;;^UTILITY(U,$J,358.3,8444,2)
 ;;=^5031781
 ;;^UTILITY(U,$J,358.3,8445,0)
 ;;=S56.418A^^42^511^24
 ;;^UTILITY(U,$J,358.3,8445,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8445,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Extn Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8445,1,4,0)
 ;;=4^S56.418A
 ;;^UTILITY(U,$J,358.3,8445,2)
 ;;=^5031784
 ;;^UTILITY(U,$J,358.3,8446,0)
 ;;=S56.811A^^42^511^39
 ;;^UTILITY(U,$J,358.3,8446,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8446,1,3,0)
 ;;=3^Strain of Right Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8446,1,4,0)
 ;;=4^S56.811A
 ;;^UTILITY(U,$J,358.3,8446,2)
 ;;=^5031862
 ;;^UTILITY(U,$J,358.3,8447,0)
 ;;=S56.812A^^42^511^20
 ;;^UTILITY(U,$J,358.3,8447,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8447,1,3,0)
 ;;=3^Strain of Left Forearm Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8447,1,4,0)
 ;;=4^S56.812A
 ;;^UTILITY(U,$J,358.3,8447,2)
 ;;=^5031865
 ;;^UTILITY(U,$J,358.3,8448,0)
 ;;=S56.116A^^42^511^32
 ;;^UTILITY(U,$J,358.3,8448,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8448,1,3,0)
 ;;=3^Strain of Left Ring Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8448,1,4,0)
 ;;=4^S56.116A
 ;;^UTILITY(U,$J,358.3,8448,2)
 ;;=^5031631
 ;;^UTILITY(U,$J,358.3,8449,0)
 ;;=S56.117A^^42^511^44
 ;;^UTILITY(U,$J,358.3,8449,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8449,1,3,0)
 ;;=3^Strain of Right Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8449,1,4,0)
 ;;=4^S56.117A
 ;;^UTILITY(U,$J,358.3,8449,2)
 ;;=^5031634
 ;;^UTILITY(U,$J,358.3,8450,0)
 ;;=S56.118A^^42^511^25
 ;;^UTILITY(U,$J,358.3,8450,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8450,1,3,0)
 ;;=3^Strain of Left Little Finger at Forearm Level Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8450,1,4,0)
 ;;=4^S56.118A
 ;;^UTILITY(U,$J,358.3,8450,2)
 ;;=^5031637
 ;;^UTILITY(U,$J,358.3,8451,0)
 ;;=S56.211A^^42^511^38
 ;;^UTILITY(U,$J,358.3,8451,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8451,1,3,0)
 ;;=3^Strain of Right Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8451,1,4,0)
 ;;=4^S56.211A
 ;;^UTILITY(U,$J,358.3,8451,2)
 ;;=^5031691
 ;;^UTILITY(U,$J,358.3,8452,0)
 ;;=S56.212A^^42^511^19
 ;;^UTILITY(U,$J,358.3,8452,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8452,1,3,0)
 ;;=3^Strain of Left Forearm Flexor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8452,1,4,0)
 ;;=4^S56.212A
 ;;^UTILITY(U,$J,358.3,8452,2)
 ;;=^5031694
 ;;^UTILITY(U,$J,358.3,8453,0)
 ;;=S56.311A^^42^511^54
 ;;^UTILITY(U,$J,358.3,8453,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8453,1,3,0)
 ;;=3^Strain of Right Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8453,1,4,0)
 ;;=4^S56.311A
 ;;^UTILITY(U,$J,358.3,8453,2)
 ;;=^5031715
 ;;^UTILITY(U,$J,358.3,8454,0)
 ;;=S56.312A^^42^511^34
 ;;^UTILITY(U,$J,358.3,8454,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8454,1,3,0)
 ;;=3^Strain of Left Thumb at Forearm Level Extn/Abdr Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8454,1,4,0)
 ;;=4^S56.312A
 ;;^UTILITY(U,$J,358.3,8454,2)
 ;;=^5031718
 ;;^UTILITY(U,$J,358.3,8455,0)
 ;;=S56.411A^^42^511^42
 ;;^UTILITY(U,$J,358.3,8455,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,8455,1,3,0)
 ;;=3^Strain of Right Index Finger at Forearm Level Extensor Muscle/Fasc/Tendon
 ;;^UTILITY(U,$J,358.3,8455,1,4,0)
 ;;=4^S56.411A
 ;;^UTILITY(U,$J,358.3,8455,2)
 ;;=^5031763
 ;;^UTILITY(U,$J,358.3,8456,0)
 ;;=S56.412A^^42^511^23
 ;;^UTILITY(U,$J,358.3,8456,1,0)
 ;;=^358.31IA^4^2
