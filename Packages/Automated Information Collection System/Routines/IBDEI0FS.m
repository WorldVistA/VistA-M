IBDEI0FS ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6816,1,4,0)
 ;;=4^M66.341
 ;;^UTILITY(U,$J,358.3,6816,2)
 ;;=^5012881
 ;;^UTILITY(U,$J,358.3,6817,0)
 ;;=M66.342^^56^439^102
 ;;^UTILITY(U,$J,358.3,6817,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6817,1,3,0)
 ;;=3^Spont ruptr of flexor tendons, lft hand
 ;;^UTILITY(U,$J,358.3,6817,1,4,0)
 ;;=4^M66.342
 ;;^UTILITY(U,$J,358.3,6817,2)
 ;;=^5012882
 ;;^UTILITY(U,$J,358.3,6818,0)
 ;;=M67.01^^56^439^96
 ;;^UTILITY(U,$J,358.3,6818,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6818,1,3,0)
 ;;=3^Short Achilles tendon (acquired), rt ankle
 ;;^UTILITY(U,$J,358.3,6818,1,4,0)
 ;;=4^M67.01
 ;;^UTILITY(U,$J,358.3,6818,2)
 ;;=^5012906
 ;;^UTILITY(U,$J,358.3,6819,0)
 ;;=M67.02^^56^439^95
 ;;^UTILITY(U,$J,358.3,6819,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6819,1,3,0)
 ;;=3^Short Achilles tendon (acquired), lft ankle
 ;;^UTILITY(U,$J,358.3,6819,1,4,0)
 ;;=4^M67.02
 ;;^UTILITY(U,$J,358.3,6819,2)
 ;;=^5012907
 ;;^UTILITY(U,$J,358.3,6820,0)
 ;;=M62.40^^56^439^26
 ;;^UTILITY(U,$J,358.3,6820,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6820,1,3,0)
 ;;=3^Contracture of muscle, unspec site
 ;;^UTILITY(U,$J,358.3,6820,1,4,0)
 ;;=4^M62.40
 ;;^UTILITY(U,$J,358.3,6820,2)
 ;;=^5012631
 ;;^UTILITY(U,$J,358.3,6821,0)
 ;;=M72.0^^56^439^80
 ;;^UTILITY(U,$J,358.3,6821,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6821,1,3,0)
 ;;=3^Palmar fascial fibromatosis [Dupuytren]
 ;;^UTILITY(U,$J,358.3,6821,1,4,0)
 ;;=4^M72.0
 ;;^UTILITY(U,$J,358.3,6821,2)
 ;;=^5013233
 ;;^UTILITY(U,$J,358.3,6822,0)
 ;;=M72.2^^56^439^84
 ;;^UTILITY(U,$J,358.3,6822,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6822,1,3,0)
 ;;=3^Plantar fascial fibromatosis
 ;;^UTILITY(U,$J,358.3,6822,1,4,0)
 ;;=4^M72.2
 ;;^UTILITY(U,$J,358.3,6822,2)
 ;;=^272598
 ;;^UTILITY(U,$J,358.3,6823,0)
 ;;=M62.838^^56^439^69
 ;;^UTILITY(U,$J,358.3,6823,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6823,1,3,0)
 ;;=3^Muscle spasm, oth
 ;;^UTILITY(U,$J,358.3,6823,1,4,0)
 ;;=4^M62.838
 ;;^UTILITY(U,$J,358.3,6823,2)
 ;;=^5012682
 ;;^UTILITY(U,$J,358.3,6824,0)
 ;;=M62.9^^56^439^27
 ;;^UTILITY(U,$J,358.3,6824,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6824,1,3,0)
 ;;=3^Disorder of muscle, unspec
 ;;^UTILITY(U,$J,358.3,6824,1,4,0)
 ;;=4^M62.9
 ;;^UTILITY(U,$J,358.3,6824,2)
 ;;=^5012684
 ;;^UTILITY(U,$J,358.3,6825,0)
 ;;=M79.2^^56^439^74
 ;;^UTILITY(U,$J,358.3,6825,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6825,1,3,0)
 ;;=3^Neuralgia & neuritis, unspec
 ;;^UTILITY(U,$J,358.3,6825,1,4,0)
 ;;=4^M79.2
 ;;^UTILITY(U,$J,358.3,6825,2)
 ;;=^5013322
 ;;^UTILITY(U,$J,358.3,6826,0)
 ;;=M21.751^^56^439^117
 ;;^UTILITY(U,$J,358.3,6826,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6826,1,3,0)
 ;;=3^Unequal limb length (acq), rt femur
 ;;^UTILITY(U,$J,358.3,6826,1,4,0)
 ;;=4^M21.751
 ;;^UTILITY(U,$J,358.3,6826,2)
 ;;=^5011140
 ;;^UTILITY(U,$J,358.3,6827,0)
 ;;=M21.752^^56^439^113
 ;;^UTILITY(U,$J,358.3,6827,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6827,1,3,0)
 ;;=3^Unequal limb length (acq), lft femur
 ;;^UTILITY(U,$J,358.3,6827,1,4,0)
 ;;=4^M21.752
 ;;^UTILITY(U,$J,358.3,6827,2)
 ;;=^5011141
 ;;^UTILITY(U,$J,358.3,6828,0)
 ;;=M21.761^^56^439^118
 ;;^UTILITY(U,$J,358.3,6828,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,6828,1,3,0)
 ;;=3^Unequal limb length (acq), rt tibia
 ;;^UTILITY(U,$J,358.3,6828,1,4,0)
 ;;=4^M21.761
 ;;^UTILITY(U,$J,358.3,6828,2)
 ;;=^5011143
 ;;^UTILITY(U,$J,358.3,6829,0)
 ;;=M21.762^^56^439^115
