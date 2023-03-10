IBDEI0V4 ; ; 01-FEB-2022
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;FEB 01, 2022
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,999) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,14042,1,3,0)
 ;;=3^Fracture of upper end of right humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,14042,1,4,0)
 ;;=4^S42.201D
 ;;^UTILITY(U,$J,358.3,14042,2)
 ;;=^5026763
 ;;^UTILITY(U,$J,358.3,14043,0)
 ;;=M84.422D^^55^669^10
 ;;^UTILITY(U,$J,358.3,14043,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14043,1,3,0)
 ;;=3^Pathological fracture, left humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,14043,1,4,0)
 ;;=4^M84.422D
 ;;^UTILITY(U,$J,358.3,14043,2)
 ;;=^5013825
 ;;^UTILITY(U,$J,358.3,14044,0)
 ;;=M84.421D^^55^669^12
 ;;^UTILITY(U,$J,358.3,14044,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14044,1,3,0)
 ;;=3^Pathological fracture, right humerus, subs encntr
 ;;^UTILITY(U,$J,358.3,14044,1,4,0)
 ;;=4^M84.421D
 ;;^UTILITY(U,$J,358.3,14044,2)
 ;;=^5013819
 ;;^UTILITY(U,$J,358.3,14045,0)
 ;;=M00.862^^55^670^3
 ;;^UTILITY(U,$J,358.3,14045,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14045,1,3,0)
 ;;=3^Arthritis d/t other bacteria, left knee
 ;;^UTILITY(U,$J,358.3,14045,1,4,0)
 ;;=4^M00.862
 ;;^UTILITY(U,$J,358.3,14045,2)
 ;;=^5009686
 ;;^UTILITY(U,$J,358.3,14046,0)
 ;;=M00.861^^55^670^4
 ;;^UTILITY(U,$J,358.3,14046,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14046,1,3,0)
 ;;=3^Arthritis d/t other bacteria, right knee
 ;;^UTILITY(U,$J,358.3,14046,1,4,0)
 ;;=4^M00.861
 ;;^UTILITY(U,$J,358.3,14046,2)
 ;;=^5009685
 ;;^UTILITY(U,$J,358.3,14047,0)
 ;;=M22.42^^55^670^10
 ;;^UTILITY(U,$J,358.3,14047,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14047,1,3,0)
 ;;=3^Chondromalacia patellae, left knee
 ;;^UTILITY(U,$J,358.3,14047,1,4,0)
 ;;=4^M22.42
 ;;^UTILITY(U,$J,358.3,14047,2)
 ;;=^5011187
 ;;^UTILITY(U,$J,358.3,14048,0)
 ;;=M22.41^^55^670^11
 ;;^UTILITY(U,$J,358.3,14048,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14048,1,3,0)
 ;;=3^Chondromalacia patellae, right knee
 ;;^UTILITY(U,$J,358.3,14048,1,4,0)
 ;;=4^M22.41
 ;;^UTILITY(U,$J,358.3,14048,2)
 ;;=^5011186
 ;;^UTILITY(U,$J,358.3,14049,0)
 ;;=M94.262^^55^670^12
 ;;^UTILITY(U,$J,358.3,14049,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14049,1,3,0)
 ;;=3^Chondromalacia, left knee
 ;;^UTILITY(U,$J,358.3,14049,1,4,0)
 ;;=4^M94.262
 ;;^UTILITY(U,$J,358.3,14049,2)
 ;;=^5015346
 ;;^UTILITY(U,$J,358.3,14050,0)
 ;;=M94.261^^55^670^13
 ;;^UTILITY(U,$J,358.3,14050,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14050,1,3,0)
 ;;=3^Chondromalacia, right knee
 ;;^UTILITY(U,$J,358.3,14050,1,4,0)
 ;;=4^M94.261
 ;;^UTILITY(U,$J,358.3,14050,2)
 ;;=^5015345
 ;;^UTILITY(U,$J,358.3,14051,0)
 ;;=M24.562^^55^670^17
 ;;^UTILITY(U,$J,358.3,14051,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14051,1,3,0)
 ;;=3^Contracture, left knee
 ;;^UTILITY(U,$J,358.3,14051,1,4,0)
 ;;=4^M24.562
 ;;^UTILITY(U,$J,358.3,14051,2)
 ;;=^5011418
 ;;^UTILITY(U,$J,358.3,14052,0)
 ;;=M24.561^^55^670^18
 ;;^UTILITY(U,$J,358.3,14052,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14052,1,3,0)
 ;;=3^Contracture, right knee
 ;;^UTILITY(U,$J,358.3,14052,1,4,0)
 ;;=4^M24.561
 ;;^UTILITY(U,$J,358.3,14052,2)
 ;;=^5011417
 ;;^UTILITY(U,$J,358.3,14053,0)
 ;;=M23.201^^55^670^33
 ;;^UTILITY(U,$J,358.3,14053,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,14053,1,3,0)
 ;;=3^Derang Unsp Lateral Mensc d/t Old Tear/Inj,Left Knee
 ;;^UTILITY(U,$J,358.3,14053,1,4,0)
 ;;=4^M23.201
 ;;^UTILITY(U,$J,358.3,14053,2)
 ;;=^5011213
 ;;^UTILITY(U,$J,358.3,14054,0)
 ;;=M23.200^^55^670^34
 ;;^UTILITY(U,$J,358.3,14054,1,0)
 ;;=^358.31IA^4^2
