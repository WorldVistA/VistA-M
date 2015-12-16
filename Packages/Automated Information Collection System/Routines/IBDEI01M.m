IBDEI01M ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,201,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, accidental, subs
 ;;^UTILITY(U,$J,358.3,201,1,4,0)
 ;;=4^T49.6X1D
 ;;^UTILITY(U,$J,358.3,201,2)
 ;;=^5051915
 ;;^UTILITY(U,$J,358.3,202,0)
 ;;=T49.6X1S^^1^10^56
 ;;^UTILITY(U,$J,358.3,202,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,202,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, accidental, sequela
 ;;^UTILITY(U,$J,358.3,202,1,4,0)
 ;;=4^T49.6X1S
 ;;^UTILITY(U,$J,358.3,202,2)
 ;;=^5051916
 ;;^UTILITY(U,$J,358.3,203,0)
 ;;=T49.6X3D^^1^10^64
 ;;^UTILITY(U,$J,358.3,203,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,203,1,3,0)
 ;;=3^Poisoning by otorhino drugs and preparations, assault, subs
 ;;^UTILITY(U,$J,358.3,203,1,4,0)
 ;;=4^T49.6X3D
 ;;^UTILITY(U,$J,358.3,203,2)
 ;;=^5051921
 ;;^UTILITY(U,$J,358.3,204,0)
 ;;=T49.6X3S^^1^10^57
 ;;^UTILITY(U,$J,358.3,204,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,204,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, assault, sequela
 ;;^UTILITY(U,$J,358.3,204,1,4,0)
 ;;=4^T49.6X3S
 ;;^UTILITY(U,$J,358.3,204,2)
 ;;=^5051922
 ;;^UTILITY(U,$J,358.3,205,0)
 ;;=T49.6X2A^^1^10^58
 ;;^UTILITY(U,$J,358.3,205,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,205,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, self-harm, init
 ;;^UTILITY(U,$J,358.3,205,1,4,0)
 ;;=4^T49.6X2A
 ;;^UTILITY(U,$J,358.3,205,2)
 ;;=^5051917
 ;;^UTILITY(U,$J,358.3,206,0)
 ;;=T49.6X2D^^1^10^59
 ;;^UTILITY(U,$J,358.3,206,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,206,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, self-harm, subs
 ;;^UTILITY(U,$J,358.3,206,1,4,0)
 ;;=4^T49.6X2D
 ;;^UTILITY(U,$J,358.3,206,2)
 ;;=^5051918
 ;;^UTILITY(U,$J,358.3,207,0)
 ;;=T49.6X2S^^1^10^60
 ;;^UTILITY(U,$J,358.3,207,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,207,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, self-harm, sequela
 ;;^UTILITY(U,$J,358.3,207,1,4,0)
 ;;=4^T49.6X2S
 ;;^UTILITY(U,$J,358.3,207,2)
 ;;=^5051919
 ;;^UTILITY(U,$J,358.3,208,0)
 ;;=T49.6X4A^^1^10^61
 ;;^UTILITY(U,$J,358.3,208,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,208,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, undetermined, init
 ;;^UTILITY(U,$J,358.3,208,1,4,0)
 ;;=4^T49.6X4A
 ;;^UTILITY(U,$J,358.3,208,2)
 ;;=^5051923
 ;;^UTILITY(U,$J,358.3,209,0)
 ;;=T49.6X4D^^1^10^62
 ;;^UTILITY(U,$J,358.3,209,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,209,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, undetermined, subs
 ;;^UTILITY(U,$J,358.3,209,1,4,0)
 ;;=4^T49.6X4D
 ;;^UTILITY(U,$J,358.3,209,2)
 ;;=^5051924
 ;;^UTILITY(U,$J,358.3,210,0)
 ;;=T49.6X4S^^1^10^63
 ;;^UTILITY(U,$J,358.3,210,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,210,1,3,0)
 ;;=3^Poisoning by otorhino drugs and prep, undetermined, sequela
 ;;^UTILITY(U,$J,358.3,210,1,4,0)
 ;;=4^T49.6X4S
 ;;^UTILITY(U,$J,358.3,210,2)
 ;;=^5051925
 ;;^UTILITY(U,$J,358.3,211,0)
 ;;=T36.91XA^^1^10^65
 ;;^UTILITY(U,$J,358.3,211,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,211,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, accidental, init
 ;;^UTILITY(U,$J,358.3,211,1,4,0)
 ;;=4^T36.91XA
 ;;^UTILITY(U,$J,358.3,211,2)
 ;;=^5049418
 ;;^UTILITY(U,$J,358.3,212,0)
 ;;=T36.91XD^^1^10^66
 ;;^UTILITY(U,$J,358.3,212,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,212,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, accidental, subs
 ;;^UTILITY(U,$J,358.3,212,1,4,0)
 ;;=4^T36.91XD
 ;;^UTILITY(U,$J,358.3,212,2)
 ;;=^5049419
 ;;^UTILITY(U,$J,358.3,213,0)
 ;;=T36.91XS^^1^10^67
 ;;^UTILITY(U,$J,358.3,213,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,213,1,3,0)
 ;;=3^Poisoning by unsp systemic antibiotic, accidental, sequela
