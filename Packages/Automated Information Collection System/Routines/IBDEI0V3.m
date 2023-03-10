IBDEI0V3 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14030,2)
 ;;=^5010833
 ;;^UTILITY(U,$J,358.3,14031,0)
 ;;=M19.231^^55^668^25
 ;;^UTILITY(U,$J,358.3,14031,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14031,1,3,0)
 ;;=3^Secondary osteoarthritis, right wrist
 ;;^UTILITY(U,$J,358.3,14031,1,4,0)
 ;;=4^M19.231
 ;;^UTILITY(U,$J,358.3,14031,2)
 ;;=^5010844
 ;;^UTILITY(U,$J,358.3,14032,0)
 ;;=M19.232^^55^668^24
 ;;^UTILITY(U,$J,358.3,14032,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14032,1,3,0)
 ;;=3^Secondary osteoarthritis, left wrist
 ;;^UTILITY(U,$J,358.3,14032,1,4,0)
 ;;=4^M19.232
 ;;^UTILITY(U,$J,358.3,14032,2)
 ;;=^5010845
 ;;^UTILITY(U,$J,358.3,14033,0)
 ;;=S40.022A^^55^669^1
 ;;^UTILITY(U,$J,358.3,14033,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14033,1,3,0)
 ;;=3^Contusion of left upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,14033,1,4,0)
 ;;=4^S40.022A
 ;;^UTILITY(U,$J,358.3,14033,2)
 ;;=^5026165
 ;;^UTILITY(U,$J,358.3,14034,0)
 ;;=S40.021A^^55^669^3
 ;;^UTILITY(U,$J,358.3,14034,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14034,1,3,0)
 ;;=3^Contusion of right upper arm, initial encounter
 ;;^UTILITY(U,$J,358.3,14034,1,4,0)
 ;;=4^S40.021A
 ;;^UTILITY(U,$J,358.3,14034,2)
 ;;=^5026162
 ;;^UTILITY(U,$J,358.3,14035,0)
 ;;=M84.422A^^55^669^9
 ;;^UTILITY(U,$J,358.3,14035,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14035,1,3,0)
 ;;=3^Pathological fracture, left humerus, init for fx
 ;;^UTILITY(U,$J,358.3,14035,1,4,0)
 ;;=4^M84.422A
 ;;^UTILITY(U,$J,358.3,14035,2)
 ;;=^5013824
 ;;^UTILITY(U,$J,358.3,14036,0)
 ;;=M84.421A^^55^669^11
 ;;^UTILITY(U,$J,358.3,14036,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14036,1,3,0)
 ;;=3^Pathological fracture, right humerus, init for fx
 ;;^UTILITY(U,$J,358.3,14036,1,4,0)
 ;;=4^M84.421A
 ;;^UTILITY(U,$J,358.3,14036,2)
 ;;=^5013818
 ;;^UTILITY(U,$J,358.3,14037,0)
 ;;=S42.202A^^55^669^5
 ;;^UTILITY(U,$J,358.3,14037,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14037,1,3,0)
 ;;=3^Fracture of upper end of left humerus, init for clos fx,Unspec
 ;;^UTILITY(U,$J,358.3,14037,1,4,0)
 ;;=4^S42.202A
 ;;^UTILITY(U,$J,358.3,14037,2)
 ;;=^5026768
 ;;^UTILITY(U,$J,358.3,14038,0)
 ;;=S42.201A^^55^669^7
 ;;^UTILITY(U,$J,358.3,14038,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14038,1,3,0)
 ;;=3^Fracture of upper end of right humerus, init,Unspec
 ;;^UTILITY(U,$J,358.3,14038,1,4,0)
 ;;=4^S42.201A
 ;;^UTILITY(U,$J,358.3,14038,2)
 ;;=^5026761
 ;;^UTILITY(U,$J,358.3,14039,0)
 ;;=S40.022D^^55^669^2
 ;;^UTILITY(U,$J,358.3,14039,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14039,1,3,0)
 ;;=3^Contusion of left upper arm, subsequent encounter
 ;;^UTILITY(U,$J,358.3,14039,1,4,0)
 ;;=4^S40.022D
 ;;^UTILITY(U,$J,358.3,14039,2)
 ;;=^5026166
 ;;^UTILITY(U,$J,358.3,14040,0)
 ;;=S40.021D^^55^669^4
 ;;^UTILITY(U,$J,358.3,14040,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14040,1,3,0)
 ;;=3^Contusion of right upper arm, subsequent encounter
 ;;^UTILITY(U,$J,358.3,14040,1,4,0)
 ;;=4^S40.021D
 ;;^UTILITY(U,$J,358.3,14040,2)
 ;;=^5026163
 ;;^UTILITY(U,$J,358.3,14041,0)
 ;;=S42.202D^^55^669^6
 ;;^UTILITY(U,$J,358.3,14041,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14041,1,3,0)
 ;;=3^Fracture of upper end of left humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,14041,1,4,0)
 ;;=4^S42.202D
 ;;^UTILITY(U,$J,358.3,14041,2)
 ;;=^5026770
 ;;^UTILITY(U,$J,358.3,14042,0)
 ;;=S42.201D^^55^669^8
 ;;^UTILITY(U,$J,358.3,14042,1,0)
 ;;=^358.31IA^4^2
