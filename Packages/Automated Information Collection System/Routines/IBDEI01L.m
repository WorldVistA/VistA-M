IBDEI01L ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,189,0)
 ;;=T36.8X1D^^1^10^43
 ;;^UTILITY(U,$J,358.3,189,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,189,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, subs
 ;;^UTILITY(U,$J,358.3,189,1,4,0)
 ;;=4^T36.8X1D
 ;;^UTILITY(U,$J,358.3,189,2)
 ;;=^5049401
 ;;^UTILITY(U,$J,358.3,190,0)
 ;;=T36.8X1S^^1^10^44
 ;;^UTILITY(U,$J,358.3,190,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,190,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, accidental, sequela
 ;;^UTILITY(U,$J,358.3,190,1,4,0)
 ;;=4^T36.8X1S
 ;;^UTILITY(U,$J,358.3,190,2)
 ;;=^5049402
 ;;^UTILITY(U,$J,358.3,191,0)
 ;;=T36.8X3A^^1^10^45
 ;;^UTILITY(U,$J,358.3,191,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,191,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, assault, init encntr
 ;;^UTILITY(U,$J,358.3,191,1,4,0)
 ;;=4^T36.8X3A
 ;;^UTILITY(U,$J,358.3,191,2)
 ;;=^5049406
 ;;^UTILITY(U,$J,358.3,192,0)
 ;;=T36.8X3D^^1^10^46
 ;;^UTILITY(U,$J,358.3,192,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,192,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, assault, subs encntr
 ;;^UTILITY(U,$J,358.3,192,1,4,0)
 ;;=4^T36.8X3D
 ;;^UTILITY(U,$J,358.3,192,2)
 ;;=^5049407
 ;;^UTILITY(U,$J,358.3,193,0)
 ;;=T36.8X3S^^1^10^53
 ;;^UTILITY(U,$J,358.3,193,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,193,1,3,0)
 ;;=3^Poisoning by other systemic antibiotics, assault, sequela
 ;;^UTILITY(U,$J,358.3,193,1,4,0)
 ;;=4^T36.8X3S
 ;;^UTILITY(U,$J,358.3,193,2)
 ;;=^5049408
 ;;^UTILITY(U,$J,358.3,194,0)
 ;;=T36.8X2A^^1^10^47
 ;;^UTILITY(U,$J,358.3,194,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,194,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, self-harm, init
 ;;^UTILITY(U,$J,358.3,194,1,4,0)
 ;;=4^T36.8X2A
 ;;^UTILITY(U,$J,358.3,194,2)
 ;;=^5049403
 ;;^UTILITY(U,$J,358.3,195,0)
 ;;=T36.8X2D^^1^10^48
 ;;^UTILITY(U,$J,358.3,195,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,195,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, self-harm, subs
 ;;^UTILITY(U,$J,358.3,195,1,4,0)
 ;;=4^T36.8X2D
 ;;^UTILITY(U,$J,358.3,195,2)
 ;;=^5049404
 ;;^UTILITY(U,$J,358.3,196,0)
 ;;=T36.8X2S^^1^10^49
 ;;^UTILITY(U,$J,358.3,196,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,196,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, self-harm, sequela
 ;;^UTILITY(U,$J,358.3,196,1,4,0)
 ;;=4^T36.8X2S
 ;;^UTILITY(U,$J,358.3,196,2)
 ;;=^5049405
 ;;^UTILITY(U,$J,358.3,197,0)
 ;;=T36.8X4A^^1^10^50
 ;;^UTILITY(U,$J,358.3,197,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,197,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, undetermined, init
 ;;^UTILITY(U,$J,358.3,197,1,4,0)
 ;;=4^T36.8X4A
 ;;^UTILITY(U,$J,358.3,197,2)
 ;;=^5049409
 ;;^UTILITY(U,$J,358.3,198,0)
 ;;=T36.8X4D^^1^10^51
 ;;^UTILITY(U,$J,358.3,198,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,198,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, undetermined, subs
 ;;^UTILITY(U,$J,358.3,198,1,4,0)
 ;;=4^T36.8X4D
 ;;^UTILITY(U,$J,358.3,198,2)
 ;;=^5049410
 ;;^UTILITY(U,$J,358.3,199,0)
 ;;=T36.8X4S^^1^10^52
 ;;^UTILITY(U,$J,358.3,199,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,199,1,3,0)
 ;;=3^Poisoning by oth systemic antibiotics, undetermined, sequela
 ;;^UTILITY(U,$J,358.3,199,1,4,0)
 ;;=4^T36.8X4S
 ;;^UTILITY(U,$J,358.3,199,2)
 ;;=^5049411
 ;;^UTILITY(U,$J,358.3,200,0)
 ;;=T49.6X1A^^1^10^54
 ;;^UTILITY(U,$J,358.3,200,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,200,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, accidental, init
 ;;^UTILITY(U,$J,358.3,200,1,4,0)
 ;;=4^T49.6X1A
 ;;^UTILITY(U,$J,358.3,200,2)
 ;;=^5051914
 ;;^UTILITY(U,$J,358.3,201,0)
 ;;=T49.6X1D^^1^10^55
 ;;^UTILITY(U,$J,358.3,201,1,0)
 ;;=^358.31IA^4^2
