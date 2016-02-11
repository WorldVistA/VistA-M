IBDEI0D9 ; ; 19-NOV-2015
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JUN 29, 2015
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5762,2)
 ;;=^5010808
 ;;^UTILITY(U,$J,358.3,5763,0)
 ;;=M19.012^^40^376^11
 ;;^UTILITY(U,$J,358.3,5763,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5763,1,3,0)
 ;;=3^Primary Osteoarthritis,Left Shoulder
 ;;^UTILITY(U,$J,358.3,5763,1,4,0)
 ;;=4^M19.012
 ;;^UTILITY(U,$J,358.3,5763,2)
 ;;=^5010809
 ;;^UTILITY(U,$J,358.3,5764,0)
 ;;=M19.021^^40^376^14
 ;;^UTILITY(U,$J,358.3,5764,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5764,1,3,0)
 ;;=3^Primary Osteoarthritis,Right Elbow
 ;;^UTILITY(U,$J,358.3,5764,1,4,0)
 ;;=4^M19.021
 ;;^UTILITY(U,$J,358.3,5764,2)
 ;;=^5010811
 ;;^UTILITY(U,$J,358.3,5765,0)
 ;;=M19.022^^40^376^9
 ;;^UTILITY(U,$J,358.3,5765,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5765,1,3,0)
 ;;=3^Primary Osteoarthritis,Left Elbow
 ;;^UTILITY(U,$J,358.3,5765,1,4,0)
 ;;=4^M19.022
 ;;^UTILITY(U,$J,358.3,5765,2)
 ;;=^5010812
 ;;^UTILITY(U,$J,358.3,5766,0)
 ;;=M19.031^^40^376^17
 ;;^UTILITY(U,$J,358.3,5766,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5766,1,3,0)
 ;;=3^Primary Osteoarthritis,Right Wrist
 ;;^UTILITY(U,$J,358.3,5766,1,4,0)
 ;;=4^M19.031
 ;;^UTILITY(U,$J,358.3,5766,2)
 ;;=^5010814
 ;;^UTILITY(U,$J,358.3,5767,0)
 ;;=M19.032^^40^376^12
 ;;^UTILITY(U,$J,358.3,5767,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5767,1,3,0)
 ;;=3^Primary Osteoarthritis,Left Wrist
 ;;^UTILITY(U,$J,358.3,5767,1,4,0)
 ;;=4^M19.032
 ;;^UTILITY(U,$J,358.3,5767,2)
 ;;=^5010815
 ;;^UTILITY(U,$J,358.3,5768,0)
 ;;=M19.041^^40^376^15
 ;;^UTILITY(U,$J,358.3,5768,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5768,1,3,0)
 ;;=3^Primary Osteoarthritis,Right Hand
 ;;^UTILITY(U,$J,358.3,5768,1,4,0)
 ;;=4^M19.041
 ;;^UTILITY(U,$J,358.3,5768,2)
 ;;=^5010817
 ;;^UTILITY(U,$J,358.3,5769,0)
 ;;=M19.042^^40^376^10
 ;;^UTILITY(U,$J,358.3,5769,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5769,1,3,0)
 ;;=3^Primary Osteoarthritis,Left Hand
 ;;^UTILITY(U,$J,358.3,5769,1,4,0)
 ;;=4^M19.042
 ;;^UTILITY(U,$J,358.3,5769,2)
 ;;=^5010818
 ;;^UTILITY(U,$J,358.3,5770,0)
 ;;=M19.071^^40^376^13
 ;;^UTILITY(U,$J,358.3,5770,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5770,1,3,0)
 ;;=3^Primary Osteoarthritis,Right Ankle/Foot
 ;;^UTILITY(U,$J,358.3,5770,1,4,0)
 ;;=4^M19.071
 ;;^UTILITY(U,$J,358.3,5770,2)
 ;;=^5010820
 ;;^UTILITY(U,$J,358.3,5771,0)
 ;;=M19.072^^40^376^8
 ;;^UTILITY(U,$J,358.3,5771,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5771,1,3,0)
 ;;=3^Primary Osteoarthritis,Left Ankle/Foot
 ;;^UTILITY(U,$J,358.3,5771,1,4,0)
 ;;=4^M19.072
 ;;^UTILITY(U,$J,358.3,5771,2)
 ;;=^5010821
 ;;^UTILITY(U,$J,358.3,5772,0)
 ;;=M12.9^^40^376^1
 ;;^UTILITY(U,$J,358.3,5772,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5772,1,3,0)
 ;;=3^Arthropathy,Unspec
 ;;^UTILITY(U,$J,358.3,5772,1,4,0)
 ;;=4^M12.9
 ;;^UTILITY(U,$J,358.3,5772,2)
 ;;=^5010666
 ;;^UTILITY(U,$J,358.3,5773,0)
 ;;=M23.021^^40^376^2
 ;;^UTILITY(U,$J,358.3,5773,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5773,1,3,0)
 ;;=3^Cystic Meniscus,Posterior Horn of Medial Meniscus,Right Knee
 ;;^UTILITY(U,$J,358.3,5773,1,4,0)
 ;;=4^M23.021
 ;;^UTILITY(U,$J,358.3,5773,2)
 ;;=^5011201
 ;;^UTILITY(U,$J,358.3,5774,0)
 ;;=M23.022^^40^376^3
 ;;^UTILITY(U,$J,358.3,5774,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5774,1,3,0)
 ;;=3^Cystic Meniscus,Posterior Horn of Medial Meniscus,Left Knee
 ;;^UTILITY(U,$J,358.3,5774,1,4,0)
 ;;=4^M23.022
 ;;^UTILITY(U,$J,358.3,5774,2)
 ;;=^5011202
 ;;^UTILITY(U,$J,358.3,5775,0)
 ;;=M23.221^^40^376^4
 ;;^UTILITY(U,$J,358.3,5775,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5775,1,3,0)
 ;;=3^Derangement of Post Horn of Medial Meniscus d/t Old Tear/Inj,Right Knee
