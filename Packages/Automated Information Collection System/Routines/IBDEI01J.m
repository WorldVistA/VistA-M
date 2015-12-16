IBDEI01J ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,164,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,164,1,3,0)
 ;;=3^Poisoning by aminoglycosides, accidental, init
 ;;^UTILITY(U,$J,358.3,164,1,4,0)
 ;;=4^T36.5X1A
 ;;^UTILITY(U,$J,358.3,164,2)
 ;;=^5049346
 ;;^UTILITY(U,$J,358.3,165,0)
 ;;=T36.5X1D^^1^10^20
 ;;^UTILITY(U,$J,358.3,165,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,165,1,3,0)
 ;;=3^Poisoning by aminoglycosides, accidental, subs
 ;;^UTILITY(U,$J,358.3,165,1,4,0)
 ;;=4^T36.5X1D
 ;;^UTILITY(U,$J,358.3,165,2)
 ;;=^5049347
 ;;^UTILITY(U,$J,358.3,166,0)
 ;;=T36.5X1S^^1^10^21
 ;;^UTILITY(U,$J,358.3,166,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,166,1,3,0)
 ;;=3^Poisoning by aminoglycosides, accidental, sequela
 ;;^UTILITY(U,$J,358.3,166,1,4,0)
 ;;=4^T36.5X1S
 ;;^UTILITY(U,$J,358.3,166,2)
 ;;=^5049348
 ;;^UTILITY(U,$J,358.3,167,0)
 ;;=T36.5X3A^^1^10^22
 ;;^UTILITY(U,$J,358.3,167,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,167,1,3,0)
 ;;=3^Poisoning by aminoglycosides, assault, initial encounter
 ;;^UTILITY(U,$J,358.3,167,1,4,0)
 ;;=4^T36.5X3A
 ;;^UTILITY(U,$J,358.3,167,2)
 ;;=^5049352
 ;;^UTILITY(U,$J,358.3,168,0)
 ;;=T36.5X3D^^1^10^23
 ;;^UTILITY(U,$J,358.3,168,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,168,1,3,0)
 ;;=3^Poisoning by aminoglycosides, assault, subsequent encounter
 ;;^UTILITY(U,$J,358.3,168,1,4,0)
 ;;=4^T36.5X3D
 ;;^UTILITY(U,$J,358.3,168,2)
 ;;=^5049353
 ;;^UTILITY(U,$J,358.3,169,0)
 ;;=T36.5X3S^^1^10^24
 ;;^UTILITY(U,$J,358.3,169,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,169,1,3,0)
 ;;=3^Poisoning by aminoglycosides, assault, sequela
 ;;^UTILITY(U,$J,358.3,169,1,4,0)
 ;;=4^T36.5X3S
 ;;^UTILITY(U,$J,358.3,169,2)
 ;;=^5049354
 ;;^UTILITY(U,$J,358.3,170,0)
 ;;=T36.5X2A^^1^10^25
 ;;^UTILITY(U,$J,358.3,170,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,170,1,3,0)
 ;;=3^Poisoning by aminoglycosides, intentional self-harm, init
 ;;^UTILITY(U,$J,358.3,170,1,4,0)
 ;;=4^T36.5X2A
 ;;^UTILITY(U,$J,358.3,170,2)
 ;;=^5049349
 ;;^UTILITY(U,$J,358.3,171,0)
 ;;=T36.5X2D^^1^10^26
 ;;^UTILITY(U,$J,358.3,171,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,171,1,3,0)
 ;;=3^Poisoning by aminoglycosides, intentional self-harm, subs
 ;;^UTILITY(U,$J,358.3,171,1,4,0)
 ;;=4^T36.5X2D
 ;;^UTILITY(U,$J,358.3,171,2)
 ;;=^5049350
 ;;^UTILITY(U,$J,358.3,172,0)
 ;;=T36.5X2S^^1^10^27
 ;;^UTILITY(U,$J,358.3,172,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,172,1,3,0)
 ;;=3^Poisoning by aminoglycosides, intentional self-harm, sequela
 ;;^UTILITY(U,$J,358.3,172,1,4,0)
 ;;=4^T36.5X2S
 ;;^UTILITY(U,$J,358.3,172,2)
 ;;=^5049351
 ;;^UTILITY(U,$J,358.3,173,0)
 ;;=T36.5X4A^^1^10^28
 ;;^UTILITY(U,$J,358.3,173,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,173,1,3,0)
 ;;=3^Poisoning by aminoglycosides, undetermined, init encntr
 ;;^UTILITY(U,$J,358.3,173,1,4,0)
 ;;=4^T36.5X4A
 ;;^UTILITY(U,$J,358.3,173,2)
 ;;=^5049355
 ;;^UTILITY(U,$J,358.3,174,0)
 ;;=T36.5X4D^^1^10^29
 ;;^UTILITY(U,$J,358.3,174,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,174,1,3,0)
 ;;=3^Poisoning by aminoglycosides, undetermined, subs encntr
 ;;^UTILITY(U,$J,358.3,174,1,4,0)
 ;;=4^T36.5X4D
 ;;^UTILITY(U,$J,358.3,174,2)
 ;;=^5049356
 ;;^UTILITY(U,$J,358.3,175,0)
 ;;=T36.5X4S^^1^10^30
 ;;^UTILITY(U,$J,358.3,175,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,175,1,3,0)
 ;;=3^Poisoning by aminoglycosides, undetermined, sequela
 ;;^UTILITY(U,$J,358.3,175,1,4,0)
 ;;=4^T36.5X4S
 ;;^UTILITY(U,$J,358.3,175,2)
 ;;=^5049357
 ;;^UTILITY(U,$J,358.3,176,0)
 ;;=T45.1X1A^^1^10^31
 ;;^UTILITY(U,$J,358.3,176,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,176,1,3,0)
 ;;=3^Poisoning by antineopl and immunosup drugs, acc, init
