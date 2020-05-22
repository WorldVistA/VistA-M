IBDEI0GX ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,7338,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7338,1,3,0)
 ;;=3^Secondary Osteonecrosis,Pelvis
 ;;^UTILITY(U,$J,358.3,7338,1,4,0)
 ;;=4^M87.350
 ;;^UTILITY(U,$J,358.3,7338,2)
 ;;=^5014809
 ;;^UTILITY(U,$J,358.3,7339,0)
 ;;=M87.351^^58^473^170
 ;;^UTILITY(U,$J,358.3,7339,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7339,1,3,0)
 ;;=3^Secondary Osteonecrosis,Right Femur
 ;;^UTILITY(U,$J,358.3,7339,1,4,0)
 ;;=4^M87.351
 ;;^UTILITY(U,$J,358.3,7339,2)
 ;;=^5014810
 ;;^UTILITY(U,$J,358.3,7340,0)
 ;;=M87.352^^58^473^167
 ;;^UTILITY(U,$J,358.3,7340,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7340,1,3,0)
 ;;=3^Secondary Osteonecrosis,Left Femur
 ;;^UTILITY(U,$J,358.3,7340,1,4,0)
 ;;=4^M87.352
 ;;^UTILITY(U,$J,358.3,7340,2)
 ;;=^5014811
 ;;^UTILITY(U,$J,358.3,7341,0)
 ;;=M87.811^^58^473^82
 ;;^UTILITY(U,$J,358.3,7341,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7341,1,3,0)
 ;;=3^Osteonecrosis,Right Shoulder
 ;;^UTILITY(U,$J,358.3,7341,1,4,0)
 ;;=4^M87.811
 ;;^UTILITY(U,$J,358.3,7341,2)
 ;;=^5014831
 ;;^UTILITY(U,$J,358.3,7342,0)
 ;;=M87.812^^58^473^79
 ;;^UTILITY(U,$J,358.3,7342,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7342,1,3,0)
 ;;=3^Osteonecrosis,Left Shoulder
 ;;^UTILITY(U,$J,358.3,7342,1,4,0)
 ;;=4^M87.812
 ;;^UTILITY(U,$J,358.3,7342,2)
 ;;=^5014832
 ;;^UTILITY(U,$J,358.3,7343,0)
 ;;=M87.850^^58^473^80
 ;;^UTILITY(U,$J,358.3,7343,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7343,1,3,0)
 ;;=3^Osteonecrosis,Pelvis
 ;;^UTILITY(U,$J,358.3,7343,1,4,0)
 ;;=4^M87.850
 ;;^UTILITY(U,$J,358.3,7343,2)
 ;;=^5014852
 ;;^UTILITY(U,$J,358.3,7344,0)
 ;;=M87.851^^58^473^81
 ;;^UTILITY(U,$J,358.3,7344,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7344,1,3,0)
 ;;=3^Osteonecrosis,Right Femur
 ;;^UTILITY(U,$J,358.3,7344,1,4,0)
 ;;=4^M87.851
 ;;^UTILITY(U,$J,358.3,7344,2)
 ;;=^5014853
 ;;^UTILITY(U,$J,358.3,7345,0)
 ;;=M87.852^^58^473^78
 ;;^UTILITY(U,$J,358.3,7345,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7345,1,3,0)
 ;;=3^Osteonecrosis,Left Femur
 ;;^UTILITY(U,$J,358.3,7345,1,4,0)
 ;;=4^M87.852
 ;;^UTILITY(U,$J,358.3,7345,2)
 ;;=^5014854
 ;;^UTILITY(U,$J,358.3,7346,0)
 ;;=M88.0^^58^473^69
 ;;^UTILITY(U,$J,358.3,7346,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7346,1,3,0)
 ;;=3^Osteitis Deformans of Skull
 ;;^UTILITY(U,$J,358.3,7346,1,4,0)
 ;;=4^M88.0
 ;;^UTILITY(U,$J,358.3,7346,2)
 ;;=^5014874
 ;;^UTILITY(U,$J,358.3,7347,0)
 ;;=M88.1^^58^473^70
 ;;^UTILITY(U,$J,358.3,7347,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7347,1,3,0)
 ;;=3^Osteitis Deformans of Vertebrae
 ;;^UTILITY(U,$J,358.3,7347,1,4,0)
 ;;=4^M88.1
 ;;^UTILITY(U,$J,358.3,7347,2)
 ;;=^5014875
 ;;^UTILITY(U,$J,358.3,7348,0)
 ;;=M88.89^^58^473^68
 ;;^UTILITY(U,$J,358.3,7348,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7348,1,3,0)
 ;;=3^Osteitis Deformans of Mult Sites
 ;;^UTILITY(U,$J,358.3,7348,1,4,0)
 ;;=4^M88.89
 ;;^UTILITY(U,$J,358.3,7348,2)
 ;;=^5014898
 ;;^UTILITY(U,$J,358.3,7349,0)
 ;;=M94.0^^58^473^15
 ;;^UTILITY(U,$J,358.3,7349,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7349,1,3,0)
 ;;=3^Chondrocostal Junction Syndrome/Costochondritis
 ;;^UTILITY(U,$J,358.3,7349,1,4,0)
 ;;=4^M94.0
 ;;^UTILITY(U,$J,358.3,7349,2)
 ;;=^5015327
 ;;^UTILITY(U,$J,358.3,7350,0)
 ;;=M94.20^^58^473^18
 ;;^UTILITY(U,$J,358.3,7350,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,7350,1,3,0)
 ;;=3^Chondromalacia,Unspec Site
 ;;^UTILITY(U,$J,358.3,7350,1,4,0)
 ;;=4^M94.20
