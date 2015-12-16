IBDEI1R2 ; ; 06-AUG-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,30933,2)
 ;;=^5011566
 ;;^UTILITY(U,$J,358.3,30934,0)
 ;;=M81.0^^179^1935^1
 ;;^UTILITY(U,$J,358.3,30934,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30934,1,3,0)
 ;;=3^Age-related osteoporosis w/o current pathological fracture
 ;;^UTILITY(U,$J,358.3,30934,1,4,0)
 ;;=4^M81.0
 ;;^UTILITY(U,$J,358.3,30934,2)
 ;;=^5013555
 ;;^UTILITY(U,$J,358.3,30935,0)
 ;;=L40.50^^179^1935^2
 ;;^UTILITY(U,$J,358.3,30935,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30935,1,3,0)
 ;;=3^Arthropathic psoriasis, unspecified
 ;;^UTILITY(U,$J,358.3,30935,1,4,0)
 ;;=4^L40.50
 ;;^UTILITY(U,$J,358.3,30935,2)
 ;;=^5009165
 ;;^UTILITY(U,$J,358.3,30936,0)
 ;;=T79.A0XA^^179^1935^3
 ;;^UTILITY(U,$J,358.3,30936,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30936,1,3,0)
 ;;=3^Compartment syndrome, unspecified, initial encounter
 ;;^UTILITY(U,$J,358.3,30936,1,4,0)
 ;;=4^T79.A0XA
 ;;^UTILITY(U,$J,358.3,30936,2)
 ;;=^5054323
 ;;^UTILITY(U,$J,358.3,30937,0)
 ;;=G90.522^^179^1935^4
 ;;^UTILITY(U,$J,358.3,30937,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30937,1,3,0)
 ;;=3^Complex regional pain syndrome I of left lower limb
 ;;^UTILITY(U,$J,358.3,30937,1,4,0)
 ;;=4^G90.522
 ;;^UTILITY(U,$J,358.3,30937,2)
 ;;=^5133371
 ;;^UTILITY(U,$J,358.3,30938,0)
 ;;=G90.512^^179^1935^5
 ;;^UTILITY(U,$J,358.3,30938,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30938,1,3,0)
 ;;=3^Complex regional pain syndrome I of left upper limb
 ;;^UTILITY(U,$J,358.3,30938,1,4,0)
 ;;=4^G90.512
 ;;^UTILITY(U,$J,358.3,30938,2)
 ;;=^5004165
 ;;^UTILITY(U,$J,358.3,30939,0)
 ;;=G90.523^^179^1935^6
 ;;^UTILITY(U,$J,358.3,30939,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30939,1,3,0)
 ;;=3^Complex regional pain syndrome I of lower limb, bilateral
 ;;^UTILITY(U,$J,358.3,30939,1,4,0)
 ;;=4^G90.523
 ;;^UTILITY(U,$J,358.3,30939,2)
 ;;=^5004169
 ;;^UTILITY(U,$J,358.3,30940,0)
 ;;=G90.521^^179^1935^7
 ;;^UTILITY(U,$J,358.3,30940,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30940,1,3,0)
 ;;=3^Complex regional pain syndrome I of right lower limb
 ;;^UTILITY(U,$J,358.3,30940,1,4,0)
 ;;=4^G90.521
 ;;^UTILITY(U,$J,358.3,30940,2)
 ;;=^5004168
 ;;^UTILITY(U,$J,358.3,30941,0)
 ;;=G90.511^^179^1935^8
 ;;^UTILITY(U,$J,358.3,30941,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30941,1,3,0)
 ;;=3^Complex regional pain syndrome I of right upper limb
 ;;^UTILITY(U,$J,358.3,30941,1,4,0)
 ;;=4^G90.511
 ;;^UTILITY(U,$J,358.3,30941,2)
 ;;=^5004164
 ;;^UTILITY(U,$J,358.3,30942,0)
 ;;=I96.^^179^1935^9
 ;;^UTILITY(U,$J,358.3,30942,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30942,1,3,0)
 ;;=3^Gangrene, not elsewhere classified
 ;;^UTILITY(U,$J,358.3,30942,1,4,0)
 ;;=4^I96.
 ;;^UTILITY(U,$J,358.3,30942,2)
 ;;=^5008081
 ;;^UTILITY(U,$J,358.3,30943,0)
 ;;=M10.9^^179^1935^10
 ;;^UTILITY(U,$J,358.3,30943,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30943,1,3,0)
 ;;=3^Gout, unspecified
 ;;^UTILITY(U,$J,358.3,30943,1,4,0)
 ;;=4^M10.9
 ;;^UTILITY(U,$J,358.3,30943,2)
 ;;=^5010404
 ;;^UTILITY(U,$J,358.3,30944,0)
 ;;=M87.08^^179^1935^11
 ;;^UTILITY(U,$J,358.3,30944,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30944,1,3,0)
 ;;=3^Idiopathic aseptic necrosis of bone, other site
 ;;^UTILITY(U,$J,358.3,30944,1,4,0)
 ;;=4^M87.08
 ;;^UTILITY(U,$J,358.3,30944,2)
 ;;=^5014698
 ;;^UTILITY(U,$J,358.3,30945,0)
 ;;=T84.52XA^^179^1935^12
 ;;^UTILITY(U,$J,358.3,30945,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,30945,1,3,0)
 ;;=3^Infect/inflm reaction due to internal left hip prosth, init
 ;;^UTILITY(U,$J,358.3,30945,1,4,0)
 ;;=4^T84.52XA
 ;;^UTILITY(U,$J,358.3,30945,2)
 ;;=^5055388
 ;;^UTILITY(U,$J,358.3,30946,0)
 ;;=T84.54XA^^179^1935^13
