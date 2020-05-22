IBDEI23R ; ; 04-FEB-2020
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 04, 2020
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,33603,1,4,0)
 ;;=4^S42.202A
 ;;^UTILITY(U,$J,358.3,33603,2)
 ;;=^5026768
 ;;^UTILITY(U,$J,358.3,33604,0)
 ;;=S42.201A^^132^1707^7
 ;;^UTILITY(U,$J,358.3,33604,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33604,1,3,0)
 ;;=3^Fracture of upper end of right humerus, init,Unspec
 ;;^UTILITY(U,$J,358.3,33604,1,4,0)
 ;;=4^S42.201A
 ;;^UTILITY(U,$J,358.3,33604,2)
 ;;=^5026761
 ;;^UTILITY(U,$J,358.3,33605,0)
 ;;=S40.022D^^132^1707^2
 ;;^UTILITY(U,$J,358.3,33605,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33605,1,3,0)
 ;;=3^Contusion of left upper arm, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33605,1,4,0)
 ;;=4^S40.022D
 ;;^UTILITY(U,$J,358.3,33605,2)
 ;;=^5026166
 ;;^UTILITY(U,$J,358.3,33606,0)
 ;;=S40.021D^^132^1707^4
 ;;^UTILITY(U,$J,358.3,33606,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33606,1,3,0)
 ;;=3^Contusion of right upper arm, subsequent encounter
 ;;^UTILITY(U,$J,358.3,33606,1,4,0)
 ;;=4^S40.021D
 ;;^UTILITY(U,$J,358.3,33606,2)
 ;;=^5026163
 ;;^UTILITY(U,$J,358.3,33607,0)
 ;;=S42.202D^^132^1707^6
 ;;^UTILITY(U,$J,358.3,33607,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33607,1,3,0)
 ;;=3^Fracture of upper end of left humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,33607,1,4,0)
 ;;=4^S42.202D
 ;;^UTILITY(U,$J,358.3,33607,2)
 ;;=^5026770
 ;;^UTILITY(U,$J,358.3,33608,0)
 ;;=S42.201D^^132^1707^8
 ;;^UTILITY(U,$J,358.3,33608,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33608,1,3,0)
 ;;=3^Fracture of upper end of right humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,33608,1,4,0)
 ;;=4^S42.201D
 ;;^UTILITY(U,$J,358.3,33608,2)
 ;;=^5026763
 ;;^UTILITY(U,$J,358.3,33609,0)
 ;;=M84.422D^^132^1707^10
 ;;^UTILITY(U,$J,358.3,33609,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33609,1,3,0)
 ;;=3^Pathological fracture, left humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,33609,1,4,0)
 ;;=4^M84.422D
 ;;^UTILITY(U,$J,358.3,33609,2)
 ;;=^5013825
 ;;^UTILITY(U,$J,358.3,33610,0)
 ;;=M84.421D^^132^1707^12
 ;;^UTILITY(U,$J,358.3,33610,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33610,1,3,0)
 ;;=3^Pathological fracture, right humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,33610,1,4,0)
 ;;=4^M84.421D
 ;;^UTILITY(U,$J,358.3,33610,2)
 ;;=^5013819
 ;;^UTILITY(U,$J,358.3,33611,0)
 ;;=M00.862^^132^1708^3
 ;;^UTILITY(U,$J,358.3,33611,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33611,1,3,0)
 ;;=3^Arthritis d/t other bacteria, left knee
 ;;^UTILITY(U,$J,358.3,33611,1,4,0)
 ;;=4^M00.862
 ;;^UTILITY(U,$J,358.3,33611,2)
 ;;=^5009686
 ;;^UTILITY(U,$J,358.3,33612,0)
 ;;=M00.861^^132^1708^4
 ;;^UTILITY(U,$J,358.3,33612,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33612,1,3,0)
 ;;=3^Arthritis d/t other bacteria, right knee
 ;;^UTILITY(U,$J,358.3,33612,1,4,0)
 ;;=4^M00.861
 ;;^UTILITY(U,$J,358.3,33612,2)
 ;;=^5009685
 ;;^UTILITY(U,$J,358.3,33613,0)
 ;;=M22.42^^132^1708^10
 ;;^UTILITY(U,$J,358.3,33613,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33613,1,3,0)
 ;;=3^Chondromalacia patellae, left knee
 ;;^UTILITY(U,$J,358.3,33613,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,33613,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,33614,0)
 ;;=M22.41^^132^1708^11
 ;;^UTILITY(U,$J,358.3,33614,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,33614,1,3,0)
 ;;=3^Chondromalacia patellae, right knee
 ;;^UTILITY(U,$J,358.3,33614,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,33614,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,33615,0)
 ;;=M94.262^^132^1708^12
 ;;^UTILITY(U,$J,358.3,33615,1,0)
 ;;=^358.31IA^4^2
